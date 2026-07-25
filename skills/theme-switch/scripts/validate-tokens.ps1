param(
    [Parameter(Mandatory=$true)]
    [string]$CssPath,
    [string]$Theme = ""
)

$warnings = @()
$errors = @()

function Convert-HSLtoRGB([double]$h, [double]$s, [double]$l) {
    $sN = $s / 100.0
    $lN = $l / 100.0
    $c = (1.0 - [Math]::Abs(2.0 * $lN - 1.0)) * $sN
    $hP = if ($h -eq 360) { 0.0 } else { $h / 60.0 }
    $x = $c * (1.0 - [Math]::Abs($hP % 2 - 1.0))
    $m = $lN - $c / 2.0
    [double]$script:r1 = 0.0
    [double]$script:g1 = 0.0
    [double]$script:b1 = 0.0
    if ($hP -lt 1) { $script:r1=$c; $script:g1=$x }
    elseif ($hP -lt 2) { $script:r1=$x; $script:g1=$c }
    elseif ($hP -lt 3) { $script:g1=$c; $script:b1=$x }
    elseif ($hP -lt 4) { $script:g1=$x; $script:b1=$c }
    elseif ($hP -lt 5) { $script:r1=$x; $script:b1=$c }
    else { $script:r1=$c; $script:b1=$x }
    $ro = ($script:r1 + $m) * 255.0
    $go = ($script:g1 + $m) * 255.0
    $bo = ($script:b1 + $m) * 255.0
    return @($ro, $go, $bo)
}

function Get-RelativeLuminance([double]$r, [double]$g, [double]$b) {
    function Lin([double]$v) {
        $n = $v / 255.0
        if ($n -le 0.03928) { return $n / 12.92 }
        return [Math]::Pow(($n + 0.055) / 1.055, 2.4)
    }
    return 0.2126*(Lin $r) + 0.7152*(Lin $g) + 0.0722*(Lin $b)
}

function Get-ContrastRatio([double]$fgH, [double]$fgS, [double]$fgL, [double]$bgH, [double]$bgS, [double]$bgL) {
    $fgRgb = Convert-HSLtoRGB $fgH $fgS $fgL
    $bgRgb = Convert-HSLtoRGB $bgH $bgS $bgL
    $fgLum = Get-RelativeLuminance $fgRgb[0] $fgRgb[1] $fgRgb[2]
    $bgLum = Get-RelativeLuminance $bgRgb[0] $bgRgb[1] $bgRgb[2]
    $lighter = [Math]::Max($fgLum, $bgLum)
    $darker = [Math]::Min($fgLum, $bgLum)
    return ($lighter + 0.05) / ($darker + 0.05)
}

if (-not (Test-Path $CssPath)) {
    Write-Output "ERROR: File not found: $CssPath"
    exit 1
}

$content = Get-Content $CssPath -Raw

$rootMatch = [regex]::Match($content, ':root\s*\{([^}]+)\}')
if (-not $rootMatch.Success) {
    Write-Output "ERROR: No :root block found in $CssPath"
    exit 1
}

$rootBlock = $rootMatch.Groups[1].Value
$vars = @{}
[regex]::Matches($rootBlock, '--([\w-]+)\s*:\s*([^;]+);') | ForEach-Object {
    $vars[$_.Groups[1].Value] = $_.Groups[2].Value.Trim()
}

Write-Output "=== Theme Token Validation ==="
Write-Output "File: $CssPath"
Write-Output "Theme: $(if($Theme){$Theme}else{'unspecified'})"
Write-Output ""

$requiredColorVars = @('background','foreground','card','card-foreground','popover','popover-foreground',
    'primary','primary-foreground','secondary','secondary-foreground','muted','muted-foreground',
    'accent','accent-foreground','destructive','destructive-foreground','border','input','ring')

$requiredOtherVars = @('radius','border-width','font-display','font-sans','font-mono',
    'section-py','card-p','motion-duration','motion-easing','shadow-sm','shadow-md','shadow-elegant')

Write-Output "--- Gate 4: CSS Variable Completeness ---"
$missingColor = $requiredColorVars | Where-Object { -not $vars.ContainsKey($_) }
$missingOther = $requiredOtherVars | Where-Object { -not $vars.ContainsKey($_) }
if (($missingColor.Count -gt 0) -or ($missingOther.Count -gt 0)) {
    $allMissing = @($missingColor) + @($missingOther) | Where-Object { $_ }
    $errors += "Missing CSS variables: $($allMissing -join ', ')"
    Write-Output "FAIL: Missing variables: $($allMissing -join ', ')"
} else {
    Write-Output "PASS: All required variables present"
}

Write-Output ""
Write-Output "--- Gate 1: Color Contrast ---"

function Test-ContrastPair($fgName, $bgName, [double]$minRatio) {
    if (-not $vars.ContainsKey($fgName) -or -not $vars.ContainsKey($bgName)) { return }
    $fgParts = $vars[$fgName] -split '\s+' | Where-Object { $_ -match '^\d' }
    $bgParts = $vars[$bgName] -split '\s+' | Where-Object { $_ -match '^\d' }
    if ($fgParts.Count -lt 3 -or $bgParts.Count -lt 3) {
        Write-Output "SKIP: $fgName or $bgName has insufficient HSL parts"
        return
    }
    $fgH = [double]$fgParts[0]
    $fgS = [double]($fgParts[1] -replace '%','')
    $fgL = [double]($fgParts[2] -replace '%','')
    $bgH = [double]$bgParts[0]
    $bgS = [double]($bgParts[1] -replace '%','')
    $bgL = [double]($bgParts[2] -replace '%','')
    $ratio = Get-ContrastRatio $fgH $fgS $fgL $bgH $bgS $bgL
    $ratioStr = [Math]::Round($ratio, 2)
    if ($ratio -ge $minRatio) {
        Write-Output "PASS: $fgName on $bgName = ${ratioStr}:1 (min $minRatio)"
    } else {
        Write-Output "FAIL: $fgName on $bgName = ${ratioStr}:1 (min $minRatio)"
        $errors += "Contrast fail: $fgName on $bgName = ${ratioStr}:1"
    }
}

Test-ContrastPair 'foreground' 'background' 4.5
Test-ContrastPair 'muted-foreground' 'background' 3.0
Test-ContrastPair 'primary-foreground' 'primary' 4.5
Test-ContrastPair 'card-foreground' 'card' 4.5
Test-ContrastPair 'destructive-foreground' 'destructive' 4.5

Write-Output ""
Write-Output "--- Gate 5: Theme-Specific Rules ---"
if ($Theme -eq 'brutalist') {
    if ($vars['motion-duration'] -and $vars['motion-duration'] -notmatch '^[0-4]\d?ms$') {
        $warnings += "Brutalist: motion-duration should be 0-50ms, got $($vars['motion-duration'])"
    }
    if ($vars['radius'] -and $vars['radius'] -notmatch '^(0px|0\.1\drem|0\.2\drem)$') {
        $warnings += "Brutalist: radius should be 0-2px, got $($vars['radius'])"
    }
}
if ($Theme -eq 'neubrutalism') {
    if ($vars['radius'] -and $vars['radius'] -ne '0px') {
        $warnings += "Neubrutalism: radius should be 0px, got $($vars['radius'])"
    }
}
if ($Theme -eq 'glassmorphism') {
    if (-not $vars.ContainsKey('backdrop-blur')) {
        $warnings += "Glassmorphism: missing --backdrop-blur variable"
    }
}

Write-Output ""
Write-Output "=== Summary ==="
Write-Output "Errors: $($errors.Count)"
Write-Output "Warnings: $($warnings.Count)"
if ($errors.Count -gt 0) {
    Write-Output ""
    Write-Output "BLOCKING ISSUES:"
    $errors | ForEach-Object { Write-Output "  - $_" }
}
if ($warnings.Count -gt 0) {
    Write-Output ""
    Write-Output "WARNINGS:"
    $warnings | ForEach-Object { Write-Output "  - $_" }
}

if ($errors.Count -gt 0) { exit 1 }
if ($warnings.Count -gt 0) { exit 2 }
exit 0
