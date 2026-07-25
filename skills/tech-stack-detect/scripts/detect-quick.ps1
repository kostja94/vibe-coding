# detect-quick.ps1 — L1+L2 quick tech stack detection (headers + cookies + CSP)
# Usage: .\detect-quick.ps1 <url>
# Example: .\detect-quick.ps1 https://stripe.com

param(
    [Parameter(Mandatory = $true)]
    [string]$Url
)

$Url = $Url.TrimEnd('/')

Write-Output "=== L1: HTTP Response Headers ==="
Write-Output "Target: $Url"
Write-Output ""

try {
    $r = Invoke-WebRequest -Uri $Url -UseBasicParsing -MaximumRedirection 5 -ErrorAction Stop
    $r.Headers.GetEnumerator() | Sort-Object Key | ForEach-Object { Write-Output "$($_.Key): $($_.Value)" }
}
catch {
    Write-Output "ERROR: Failed to fetch $Url"
    Write-Output $_.Exception.Message
    exit 1
}

Write-Output ""
Write-Output "=== L2: Cookies (Set-Cookie) ==="
# Compatibility: without -UseBasicParsing, Headers is a WebHeaderCollection (has GetValues);
# with -UseBasicParsing (PS 5.1), Headers is Dictionary<string,string> where multiple
# Set-Cookie headers are pre-joined into one comma-connected string. Branch accordingly.
if ($r.Headers -is [System.Net.WebHeaderCollection]) {
    $setCookieValues = $r.Headers.GetValues("Set-Cookie")
    if ($setCookieValues) {
        $setCookieValues | ForEach-Object { Write-Output $_ }
    }
    else {
        Write-Output "(no Set-Cookie headers)"
    }
}
else {
    $setCookie = $r.Headers["Set-Cookie"]
    if ($setCookie) {
        Write-Output $setCookie
    }
    else {
        Write-Output "(no Set-Cookie headers)"
    }
}

Write-Output ""
Write-Output "=== CSP Mining: domains in Content-Security-Policy ==="
$csp = $r.Headers["Content-Security-Policy"]
if ($csp) {
    # Extract domain-like tokens from the CSP value
    $domains = [regex]::Matches($csp, "(?:https?:\/\/)?(\*\.)?([a-zA-Z0-9][-a-zA-Z0-9]*\.)+[a-zA-Z]{2,}") |
        ForEach-Object { $_.Value } | Sort-Object -Unique
    if ($domains) {
        $domains | ForEach-Object { Write-Output $_ }
        Write-Output ""
        Write-Output "-> Match these domains against references/csp-mining.md"
    }
    else {
        Write-Output "(CSP present but no external domains found)"
    }
}
else {
    Write-Output "(no Content-Security-Policy header)"
}

Write-Output ""
Write-Output "=== Next steps ==="
Write-Output "L3: fetch $Url/robots.txt"
Write-Output "L4: nslookup -type=MX/TXT/NS on the domain"
Write-Output "L5: fetch the HTML and match against references/signatures-platforms.md + signatures-services.md"
