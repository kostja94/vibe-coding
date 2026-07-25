<#
.SYNOPSIS
Validates a completed Lovable to Next.js migration.
.DESCRIPTION
Runs 10 checks against the migrated project to verify correctness
and completeness of the migration from Lovable to Next.js.
.NOTES
PowerShell 5.1 compatible. No external dependencies.
#>

$ErrorActionPreference = 'Stop'

function Test-FileExists($relativePath) {
    return Test-Path -LiteralPath (Join-Path $PWD $relativePath) -PathType Leaf
}

function Test-DirExists($relativePath) {
    return Test-Path -LiteralPath (Join-Path $PWD $relativePath) -PathType Container
}

function Get-PackageJson {
    $pkgPath = Join-Path $PWD 'package.json'
    if (-not (Test-Path -LiteralPath $pkgPath -PathType Leaf)) {
        Write-Error "package.json not found in $PWD"
        exit 1
    }
    $raw = Get-Content -LiteralPath $pkgPath -Raw -Encoding UTF8
    return ConvertFrom-Json $raw
}

function Search-InFiles {
    param(
        [string]$Pattern,
        [string[]]$Include,
        [string]$Path = $PWD
    )
    $matches = Select-String -Pattern $Pattern -Path $Path -Recurse -Include $Include -Encoding UTF8 -ErrorAction SilentlyContinue
    return $matches
}

$results = @()

function Add-Result {
    param(
        [string]$Check,
        [string]$Status,
        [string]$Detail
    )
    $results += [PSCustomObject][ordered]@{
        Check  = $Check
        Status = $Status
        Detail = $Detail
    }
    return $results
}

# 1. Build infrastructure (next.config.ts exists + next in dependencies)
$hasNextConfig = Test-FileExists 'next.config.ts' -or Test-FileExists 'next.config.mjs' -or Test-FileExists 'next.config.js'
$pkg = Get-PackageJson
$hasNextDep = $pkg.dependencies.PSObject.Properties.Name -contains 'next'
if ($hasNextConfig -and $hasNextDep) {
    $results = Add-Result -Check 'Build infrastructure' -Status 'PASS' -Detail 'next.config.* found and "next" in dependencies'
} else {
    $missing = @()
    if (-not $hasNextConfig) { $missing += 'next.config.*' }
    if (-not $hasNextDep) { $missing += '"next" in dependencies' }
    $results = Add-Result -Check 'Build infrastructure' -Status 'FAIL' -Detail "Missing: $($missing -join ', ')"
}

# 2. No old stack imports
$oldImports = @()
$rrdMatches = Search-InFiles -Pattern 'react-router-dom' -Include @('*.ts', '*.tsx')
if ($rrdMatches) { $oldImports += "react-router-dom ($(($rrdMatches | Measure-Object).Count) occurrences)" }
$tsrMatches = Search-InFiles -Pattern '@tanstack/react-router' -Include @('*.ts', '*.tsx')
if ($tsrMatches) { $oldImports += "@tanstack/react-router ($(($tsrMatches | Measure-Object).Count) occurrences)" }
$rhaMatches = Search-InFiles -Pattern 'react-helmet-async' -Include @('*.ts', '*.tsx')
if ($rhaMatches) { $oldImports += "react-helmet-async ($(($rhaMatches | Measure-Object).Count) occurrences)" }

if ($oldImports.Count -eq 0) {
    $results = Add-Result -Check 'No old stack imports' -Status 'PASS' -Detail 'No react-router-dom, @tanstack/react-router, or react-helmet-async imports found'
} else {
    $results = Add-Result -Check 'No old stack imports' -Status 'FAIL' -Detail "Found: $($oldImports -join '; ')"
}

# 3. No Vite files
$viteFiles = @()
if (Test-FileExists 'vite.config.ts') { $viteFiles += 'vite.config.ts' }
if (Test-FileExists 'index.html') { $viteFiles += 'index.html' }
if (Test-FileExists 'src/main.tsx') { $viteFiles += 'src/main.tsx' }

if ($viteFiles.Count -eq 0) {
    $results = Add-Result -Check 'No Vite files' -Status 'PASS' -Detail 'vite.config.ts, index.html, src/main.tsx not found'
} else {
    $results = Add-Result -Check 'No Vite files' -Status 'FAIL' -Detail "Still present: $($viteFiles -join ', ')"
}

# 4. CSS variables defined in globals.css
$globalsPaths = @('src/app/globals.css', 'src/styles/globals.css', 'app/globals.css', 'styles/globals.css')
$globalsPath = $null
foreach ($p in $globalsPaths) {
    if (Test-FileExists $p) {
        $globalsPath = $p
        break
    }
}
if ($globalsPath) {
    $globalsContent = Get-Content -LiteralPath (Join-Path $PWD $globalsPath) -Raw -Encoding UTF8
    $hasBackground = $globalsContent -match '--background'
    $hasForeground = $globalsContent -match '--foreground'
    $hasPrimary = $globalsContent -match '--primary'
    $cssVars = @()
    if ($hasBackground) { $cssVars += '--background' }
    if ($hasForeground) { $cssVars += '--foreground' }
    if ($hasPrimary) { $cssVars += '--primary' }
    if ($hasBackground -and $hasForeground -and $hasPrimary) {
        $results = Add-Result -Check 'CSS variables defined' -Status 'PASS' -Detail "Found --background, --foreground, --primary in $globalsPath"
    } else {
        $results = Add-Result -Check 'CSS variables defined' -Status 'FAIL' -Detail "Missing: --background, --foreground, --primary. Found only: $($cssVars -join ', ')"
    }
} else {
    $results = Add-Result -Check 'CSS variables defined' -Status 'FAIL' -Detail 'globals.css not found in expected locations'
}

# 5. "use client" on UI components
$uiDir = Join-Path $PWD 'src\components\ui'
$missingUseClient = @()
if (Test-Path -LiteralPath $uiDir -PathType Container) {
    $uiFiles = Get-ChildItem -LiteralPath $uiDir -Filter '*.tsx' -File -ErrorAction SilentlyContinue
    foreach ($f in $uiFiles) {
        $firstLine = Get-Content -LiteralPath $f.FullName -TotalCount 1 -Encoding UTF8
        if ($firstLine -notmatch '"use client"' -and $firstLine -notmatch "'use client'") {
            $missingUseClient += $f.Name
        }
    }
    if ($missingUseClient.Count -eq 0) {
        $results = Add-Result -Check '"use client" on UI components' -Status 'PASS' -Detail "All src/components/ui/*.tsx have 'use client'"
    } else {
        $results = Add-Result -Check '"use client" on UI components' -Status 'FAIL' -Detail "Missing 'use client': $($missingUseClient -join ', ')"
    }
} else {
    $results = Add-Result -Check '"use client" on UI components' -Status 'FAIL' -Detail 'src/components/ui/ directory not found'
}

# 6. All route pages exist
$hasPageTsx = Test-FileExists 'src/app/page.tsx' -or Test-FileExists 'app/page.tsx'
$hasLayoutTsx = Test-FileExists 'src/app/layout.tsx' -or Test-FileExists 'app/layout.tsx'
$missingPages = @()
if (-not $hasPageTsx) { $missingPages += 'page.tsx' }
if (-not $hasLayoutTsx) { $missingPages += 'layout.tsx' }

if ($missingPages.Count -eq 0) {
    $results = Add-Result -Check 'Route pages exist' -Status 'PASS' -Detail 'page.tsx and layout.tsx found in src/app/'
} else {
    $results = Add-Result -Check 'Route pages exist' -Status 'FAIL' -Detail "Missing: $($missingPages -join ', ')"
}

# 7. next/font usage
$layoutPath = $null
if (Test-FileExists 'src/app/layout.tsx') { $layoutPath = 'src/app/layout.tsx' }
elseif (Test-FileExists 'app/layout.tsx') { $layoutPath = 'app/layout.tsx' }

if ($layoutPath) {
    $layoutContent = Get-Content -LiteralPath (Join-Path $PWD $layoutPath) -Raw -Encoding UTF8
    $usesNextFont = $layoutContent -match 'next/font'
    $usesGoogleFontLink = $layoutContent -match 'fonts\.googleapis\.com' -or $layoutContent -match '<link[^>]*rel="stylesheet"[^>]*font'

    if ($usesNextFont -and -not $usesGoogleFontLink) {
        $results = Add-Result -Check 'next/font usage' -Status 'PASS' -Detail "layout.tsx uses next/font (no Google Fonts <link>)"
    } elseif ($usesNextFont -and $usesGoogleFontLink) {
        $results = Add-Result -Check 'next/font usage' -Status 'FAIL' -Detail 'layout.tsx uses next/font but also has Google Fonts <link> — remove the <link>'
    } elseif (-not $usesNextFont -and -not $usesGoogleFontLink) {
        $results = Add-Result -Check 'next/font usage' -Status 'FAIL' -Detail 'layout.tsx does not use next/font and no Google Fonts <link> found — add next/font'
    } else {
        $results = Add-Result -Check 'next/font usage' -Status 'FAIL' -Detail 'layout.tsx uses Google Fonts <link> instead of next/font — migrate to next/font'
    }
} else {
    $results = Add-Result -Check 'next/font usage' -Status 'FAIL' -Detail 'layout.tsx not found'
}

# 8. Security headers in next.config.*
$nextConfigFiles = Get-ChildItem -LiteralPath $PWD -Filter 'next.config.*' -File -ErrorAction SilentlyContinue
$hasSecurityHeaders = $false
$nextConfigDetail = ''
foreach ($ncf in $nextConfigFiles) {
    $content = Get-Content -LiteralPath $ncf.FullName -Raw -Encoding UTF8
    if ($content -match 'X-Frame-Options') {
        $hasSecurityHeaders = $true
        $nextConfigDetail = "X-Frame-Options found in $($ncf.Name)"
        break
    }
}
if ($hasSecurityHeaders) {
    $results = Add-Result -Check 'Security headers' -Status 'PASS' -Detail $nextConfigDetail
} else {
    $results = Add-Result -Check 'Security headers' -Status 'FAIL' -Detail 'X-Frame-Options header not found in next.config.*'
}

# 9. robots.ts and sitemap.ts
$hasRobots = Test-FileExists 'src/app/robots.ts' -or Test-FileExists 'app/robots.ts'
$hasSitemap = Test-FileExists 'src/app/sitemap.ts' -or Test-FileExists 'app/sitemap.ts'
$seoFiles = @()
if ($hasRobots) { $seoFiles += 'robots.ts' }
if ($hasSitemap) { $seoFiles += 'sitemap.ts' }
$missingSeo = @()
if (-not $hasRobots) { $missingSeo += 'robots.ts' }
if (-not $hasSitemap) { $missingSeo += 'sitemap.ts' }

if ($missingSeo.Count -eq 0) {
    $results = Add-Result -Check 'robots.ts and sitemap.ts' -Status 'PASS' -Detail 'Both robots.ts and sitemap.ts found in src/app/'
} else {
    $results = Add-Result -Check 'robots.ts and sitemap.ts' -Status 'FAIL' -Detail "Missing: $($missingSeo -join ', ')"
}

# 10. TypeScript strict mode
$tsconfigPath = Join-Path $PWD 'tsconfig.json'
if (Test-Path -LiteralPath $tsconfigPath -PathType Leaf) {
    $tsconfigRaw = Get-Content -LiteralPath $tsconfigPath -Raw -Encoding UTF8
    try {
        $tsconfig = ConvertFrom-Json $tsconfigRaw
        $isStrict = $tsconfig.compilerOptions.strict -eq $true
    } catch {
        $isStrict = $false
    }
    if ($isStrict) {
        $results = Add-Result -Check 'TypeScript strict mode' -Status 'PASS' -Detail '"strict": true found in tsconfig.json'
    } else {
        $results = Add-Result -Check 'TypeScript strict mode' -Status 'FAIL' -Detail '"strict": true not set in tsconfig.json compilerOptions'
    }
} else {
    $results = Add-Result -Check 'TypeScript strict mode' -Status 'FAIL' -Detail 'tsconfig.json not found'
}

# Output
Write-Output ''
Write-Output '=== Next.js Migration Validation Report ==='
Write-Output ''
$results | Format-Table -Property Check, Status, Detail -Wrap -AutoSize
Write-Output ''

$passCount = ($results | Where-Object { $_.Status -eq 'PASS' } | Measure-Object).Count
$failCount = ($results | Where-Object { $_.Status -eq 'FAIL' } | Measure-Object).Count
Write-Output "Summary: $passCount PASS, $failCount FAIL out of $($results.Count) checks"
if ($failCount -gt 0) {
    Write-Output ''
    Write-Output 'Failing checks:'
    $results | Where-Object { $_.Status -eq 'FAIL' } | ForEach-Object {
        Write-Output "  - $($_.Check): $($_.Detail)"
    }
}
Write-Output ''
