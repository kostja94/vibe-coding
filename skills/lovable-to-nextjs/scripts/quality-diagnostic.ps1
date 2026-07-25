<#
.SYNOPSIS
Diagnoses vibe coding quality issues in a Lovable project.
.DESCRIPTION
Checks 10 common quality issues: hardcoded colors, oversized components,
inline styles, any types, flat component dirs, SEO gaps, CLS risks,
performance gaps, CSS redundancy, and repeated Tailwind classes.
.NOTES
PowerShell 5.1 compatible. Uses ripgrep (rg) if available, falls back to Select-String.
#>

$ErrorActionPreference = 'Stop'

$hasRg = $null -ne (Get-Command 'rg' -ErrorAction SilentlyContinue)

function Find-Content {
    param(
        [string]$Pattern,
        [string[]]$Include,
        [string]$Path = $PWD
    )
    if ($hasRg) {
        $rgArgs = @('--no-heading', '--line-count', '--color', 'never')
        foreach ($inc in $Include) {
            $rgArgs += @('--glob', $inc)
        }
        $rgArgs += @($Pattern, $Path)
        $result = & rg @rgArgs 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $result
        }
        return @()
    }
    $ssi = @{
        Pattern  = $Pattern
        Path     = $Path
        Recurse  = $true
        Encoding = 'UTF8'
    }
    if ($Include.Count -gt 0) {
        $ssi['Include'] = $Include
    }
    $matches = Select-String @ssi
    $lines = @()
    foreach ($m in $matches) {
        $lines += "$($m.RelativePath):$($m.LineNumber):$($m.Line.Trim())"
    }
    return $lines
}

function Count-Content {
    param(
        [string]$Pattern,
        [string[]]$Include,
        [string]$Path = $PWD
    )
    if ($hasRg) {
        $rgArgs = @('--count', '--color', 'never')
        foreach ($inc in $Include) {
            $rgArgs += @('--glob', $inc)
        }
        $rgArgs += @($Pattern, $Path)
        $result = & rg @rgArgs 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $result
        }
        return @()
    }
    $ssi = @{
        Pattern  = $Pattern
        Path     = $Path
        Recurse  = $true
        Encoding = 'UTF8'
    }
    if ($Include.Count -gt 0) {
        $ssi['Include'] = $Include
    }
    $matches = Select-String @ssi
    $grouped = $matches | Group-Object -Property { $_.RelativePath } | ForEach-Object {
        "$($_.Name):$($_.Count)"
    }
    return $grouped
}

function Get-TsxFileLineCounts {
    $files = Get-ChildItem -LiteralPath $PWD -Recurse -Include '*.tsx' -File -ErrorAction SilentlyContinue
    $result = @()
    foreach ($f in $files) {
        $count = (Get-Content -LiteralPath $f.FullName | Measure-Object -Line).Lines
        $result += [PSCustomObject]@{
            Path      = $f.FullName.Substring($PWD.Path.Length + 1)
            LineCount = $count
        }
    }
    return $result
}

function Add-Issue {
    param(
        [string]$Name,
        [string]$Count,
        [string]$Severity,
        [string]$Action
    )
    return [PSCustomObject][ordered]@{
        Issue     = $Name
        Count     = $Count
        Severity  = $Severity
        Action    = $Action
    }
}

$issues = @()

# 1. Hardcoded hex colors
$colorMatches = Find-Content -Pattern '#[0-9a-fA-F]{6}' -Include @('*.tsx', '*.ts')
$colorFreq = @{}
foreach ($line in $colorMatches) {
    $found = [regex]::Matches($line, '#[0-9a-fA-F]{6}')
    foreach ($m in $found) {
        $c = $m.Value.ToLower()
        if (-not $colorFreq.ContainsKey($c)) { $colorFreq[$c] = 0 }
        $colorFreq[$c]++
    }
}
$totalColors = ($colorFreq.Values | Measure-Object -Sum).Sum
$topColors = $colorFreq.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 20
$topColorsStr = ($topColors | ForEach-Object { "$($_.Key)($($_.Value))" }) -join ', '
$colorAction = if ($totalColors -gt 0) { "Replace hardcoded colors with CSS variables or Tailwind theme tokens. Top: $topColorsStr" } else { 'None needed' }
$issues += Add-Issue -Name 'Hardcoded hex colors' -Count $totalColors -Severity 'High' -Action $colorAction

# 2. Oversized component files
$allFiles = Get-TsxFileLineCounts
$oversized = $allFiles | Where-Object { $_.LineCount -gt 300 } | Sort-Object -Property LineCount -Descending
$oversizedCount = ($oversized | Measure-Object).Count
$oversizedStr = if ($oversizedCount -gt 0) {
    ($oversized | ForEach-Object { "$($_.Path) ($($_.LineCount) lines)" }) -join '; '
} else { 'None' }
$issues += Add-Issue -Name 'Oversized component files (>300 lines)' -Count $oversizedCount -Severity 'Medium' -Action "Split large components into smaller ones. Files: $oversizedStr"

# 3. Inline styles
$inlineStyleMatches = Count-Content -Pattern 'style=\{\{' -Include @('*.tsx')
$inlineTotal = 0
$inlineDetails = @()
foreach ($entry in $inlineStyleMatches) {
    $parts = $entry -split ':'
    $file = $parts[0]
    $count = [int]$parts[1]
    $inlineTotal += $count
    $inlineDetails += "$file ($count)"
}
$inlineStr = if ($inlineTotal -gt 0) { $inlineDetails -join '; ' } else { 'None' }
$issues += Add-Issue -Name 'Inline styles (style={{ }})' -Count $inlineTotal -Severity 'Medium' -Action "Move inline styles to CSS modules or Tailwind classes. Files: $inlineStr"

# 4. : any types
$anyMatches = Count-Content -Pattern ': any' -Include @('*.tsx', '*.ts')
$anyTotal = 0
$anyDetails = @()
foreach ($entry in $anyMatches) {
    $parts = $entry -split ':'
    $file = $parts[0]
    $count = [int]$parts[1]
    $anyTotal += $count
    $anyDetails += "$file ($count)"
}
$anyStr = if ($anyTotal -gt 0) { $anyDetails -join '; ' } else { 'None' }
$issues += Add-Issue -Name '": any" type annotations' -Count $anyTotal -Severity 'High' -Action "Replace : any with proper TypeScript types. Files: $anyStr"

# 5. Flat component directory
$componentsDir = Join-Path $PWD 'src\components'
$flatFiles = @()
if (Test-Path -LiteralPath $componentsDir -PathType Container) {
    $flatFiles = Get-ChildItem -LiteralPath $componentsDir -File -ErrorAction SilentlyContinue | Where-Object {
        $_.Extension -match '\.(tsx?|jsx?)$'
    }
}
$flatCount = ($flatFiles | Measure-Object).Count
$flatNames = ($flatFiles | ForEach-Object { $_.Name }) -join ', '
$issues += Add-Issue -Name 'Flat component directory' -Count $flatCount -Severity 'Low' -Action "Move files into feature-based subdirectories. Files: $(if ($flatCount -gt 0) { $flatNames } else { 'None' })"

# 6. SEO gaps
$seoIssues = @()
$indexPath = Join-Path $PWD 'index.html'
if (Test-Path -LiteralPath $indexPath -PathType Leaf) {
    $htmlContent = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8
    $hasOg = $htmlContent -match 'og:'
    $hasJsonLd = $htmlContent -match 'application/ld\+json'
    $hasHreflang = $htmlContent -match 'hreflang'
    if (-not $hasOg) { $seoIssues += 'No og: meta tags' }
    if (-not $hasJsonLd) { $seoIssues += 'No JSON-LD structured data' }
    if (-not $hasHreflang) { $seoIssues += 'No hreflang tags' }
} else {
    $seoIssues += 'index.html not found'
}
$seoCount = ($seoIssues | Measure-Object).Count
$seoStr = if ($seoCount -gt 0) { $seoIssues -join '; ' } else { 'None' }
$issues += Add-Issue -Name 'SEO gaps' -Count $seoCount -Severity 'Medium' -Action "Add missing SEO elements: $seoStr"

# 7. CLS risks - <img without width/height/loading
$imgMatches = Find-Content -Pattern '<img\s' -Include @('*.tsx', '*.ts')
$clsCount = 0
$clsFiles = @()
foreach ($line in $imgMatches) {
    $content = $line -replace '^[^:]+:\d+:', ''
    if ($content -match '<img\s' -and $content -notmatch 'width=' -and $content -notmatch 'loading=') {
        $clsCount++
        $filePart = ($line -split ':')[0]
        if ($clsFiles -notcontains $filePart) { $clsFiles += $filePart }
    }
}
$clsStr = if ($clsFiles.Count -gt 0) { $clsFiles -join '; ' } else { 'None' }
$issues += Add-Issue -Name 'CLS risks (img without width/height/loading)' -Count $clsCount -Severity 'High' -Action "Add width, height, and loading attributes to <img> tags. Files: $clsStr"

# 8. Performance gaps
$perfIssues = @()
if (Test-Path -LiteralPath $indexPath -PathType Leaf) {
    $htmlContent = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8
    $hasPreload = $htmlContent -match 'rel="preload"'
    $hasFontDisplay = $htmlContent -match 'font-display'
    if (-not $hasPreload) { $perfIssues += 'No <link rel="preload">' }
    if (-not $hasFontDisplay) { $perfIssues += 'No font-display' }
} else {
    $perfIssues += 'index.html not found'
}
$perfCount = ($perfIssues | Measure-Object).Count
$perfStr = if ($perfCount -gt 0) { $perfIssues -join '; ' } else { 'None' }
$issues += Add-Issue -Name 'Performance gaps' -Count $perfCount -Severity 'Medium' -Action "Add preloading and font-display. Issues: $perfStr"

# 9. CSS redundancy - most frequently repeated color values in CSS files
$cssColorMatches = Find-Content -Pattern '#[0-9a-fA-F]{3,8}\b|rgba?\(' -Include @('*.css')
$cssColorFreq = @{}
foreach ($line in $cssColorMatches) {
    $content = $line -replace '^[^:]+:\d+:', ''
    $hexFound = [regex]::Matches($content, '#[0-9a-fA-F]{3,8}\b')
    foreach ($m in $hexFound) {
        $c = $m.Value.ToLower()
        if (-not $cssColorFreq.ContainsKey($c)) { $cssColorFreq[$c] = 0 }
        $cssColorFreq[$c]++
    }
    $rgbaFound = [regex]::Matches($content, 'rgba?\([^)]+\)')
    foreach ($m in $rgbaFound) {
        $c = $m.Value.Trim().ToLower()
        if (-not $cssColorFreq.ContainsKey($c)) { $cssColorFreq[$c] = 0 }
        $cssColorFreq[$c]++
    }
}
$topCssColors = $cssColorFreq.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 10
$cssRedundancyStr = if ($topCssColors.Count -gt 0) {
    ($topCssColors | ForEach-Object { "$($_.Key)($($_.Value))" }) -join ', '
} else { 'None' }
$issues += Add-Issue -Name 'CSS color redundancy' -Count ($topCssColors | Measure-Object).Count -Severity 'Low' -Action "Consolidate repeated colors into CSS variables. Top: $cssRedundancyStr"

# 10. Repeated Tailwind classes
$issues += Add-Issue -Name 'Repeated Tailwind classes' -Count 'N/A' -Severity 'Low' -Action 'Manual review needed — automated detection of repeated Tailwind class combinations is unreliable. Look for repeated utility groups like "flex items-center gap-2" and extract into shared components.'

# Output
Write-Output ''
Write-Output '=== Lovable Quality Diagnostic Report ==='
Write-Output ''
$issues | Format-Table -Property Issue, Count, Severity, Action -Wrap -AutoSize
Write-Output ''
