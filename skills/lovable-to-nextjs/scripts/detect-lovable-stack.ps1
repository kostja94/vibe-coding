<#
.SYNOPSIS
Detects which Lovable tech stack a project uses.
.DESCRIPTION
Analyzes the project in the current directory to determine if it uses
Vite + React Router or TanStack Start, along with related tooling.
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

function Get-DependencyVersion($pkg, $name) {
    if ($pkg.dependencies.PSObject.Properties.Name -contains $name) {
        return $pkg.dependencies.$name
    }
    if ($pkg.devDependencies.PSObject.Properties.Name -contains $name) {
        return $pkg.devDependencies.$name
    }
    return $null
}

$pkg = Get-PackageJson

$hasViteConfig = Test-FileExists 'vite.config.ts'
$hasAppConfig = Test-FileExists 'app.config.ts'
$hasMainTsx = Test-FileExists 'src/main.tsx'
$hasRouterTsx = Test-FileExists 'router.tsx'
$hasRoutesDir = Test-DirExists 'src/routes'
$hasPagesDir = Test-DirExists 'src/pages'
$hasUiDir = Test-DirExists 'src/components/ui'

$hasReactRouterDom = Get-DependencyVersion $pkg 'react-router-dom' -ne $null
$hasTanStackRouter = Get-DependencyVersion $pkg '@tanstack/react-router' -ne $null
$hasHelmetAsync = Get-DependencyVersion $pkg 'react-helmet-async' -ne $null
$hasSupabase = Get-DependencyVersion $pkg '@supabase/supabase-js' -ne $null
$tailwindVersion = Get-DependencyVersion $pkg 'tailwindcss'
$reactVersion = Get-DependencyVersion $pkg 'react'

$viteScore = 0
$tanstackScore = 0

if ($hasViteConfig) { $viteScore += 3 }
if ($hasMainTsx) { $viteScore += 2 }
if ($hasPagesDir) { $viteScore += 2 }
if ($hasReactRouterDom) { $viteScore += 3 }

if ($hasAppConfig) { $tanstackScore += 3 }
if ($hasRouterTsx) { $tanstackScore += 2 }
if ($hasRoutesDir) { $tanstackScore += 2 }
if ($hasTanStackRouter) { $tanstackScore += 3 }

if ($viteScore -ge $tanstackScore -and $viteScore -gt 0) {
    $stackType = 'Vite + React Router'
    $routeStructure = if ($hasPagesDir) { 'src/pages/' } else { 'unknown' }
} elseif ($tanstackScore -gt 0) {
    $stackType = 'TanStack Start'
    $routeStructure = if ($hasRoutesDir) { 'src/routes/' } else { 'unknown' }
} else {
    $stackType = 'Unknown'
    $routeStructure = 'unknown'
}

$uiLibrary = if ($hasUiDir) { 'shadcn/ui' } else { 'none detected' }
$backend = if ($hasSupabase) { 'Supabase' } else { 'none detected' }
$seo = if ($hasHelmetAsync) { 'react-helmet-async' } else { 'none detected' }

$report = [ordered]@{
    'Stack Type'          = $stackType
    'Route Structure'     = $routeStructure
    'React Version'       = if ($reactVersion) { $reactVersion } else { 'not found' }
    'Tailwind Version'    = if ($tailwindVersion) { $tailwindVersion } else { 'not found' }
    'UI Component Library' = $uiLibrary
    'Backend Integration' = $backend
    'SEO Approach'        = $seo
}

Write-Output ''
Write-Output '=== Lovable Stack Detection Report ==='
Write-Output ''
foreach ($key in $report.Keys) {
    Write-Output ("  {0,-22} {1}" -f "${key}:", $report[$key])
}
Write-Output ''

Write-Output '=== Raw Detection Signals ==='
Write-Output ''
Write-Output ("  {0,-30} {1}" -f 'vite.config.ts:', $hasViteConfig)
Write-Output ("  {0,-30} {1}" -f 'app.config.ts:', $hasAppConfig)
Write-Output ("  {0,-30} {1}" -f 'src/main.tsx:', $hasMainTsx)
Write-Output ("  {0,-30} {1}" -f 'router.tsx:', $hasRouterTsx)
Write-Output ("  {0,-30} {1}" -f 'src/routes/ directory:', $hasRoutesDir)
Write-Output ("  {0,-30} {1}" -f 'src/pages/ directory:', $hasPagesDir)
Write-Output ("  {0,-30} {1}" -f 'src/components/ui/ directory:', $hasUiDir)
Write-Output ("  {0,-30} {1}" -f 'react-router-dom:', ($hasReactRouterDom -ne $null))
Write-Output ("  {0,-30} {1}" -f '@tanstack/react-router:', ($hasTanStackRouter -ne $null))
Write-Output ("  {0,-30} {1}" -f 'react-helmet-async:', ($hasHelmetAsync -ne $null))
Write-Output ("  {0,-30} {1}" -f '@supabase/supabase-js:', ($hasSupabase -ne $null))
Write-Output ''
