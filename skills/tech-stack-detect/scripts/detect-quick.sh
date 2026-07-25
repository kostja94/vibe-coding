#!/usr/bin/env bash
# detect-quick.sh — L1+L2 quick tech stack detection (headers + cookies + CSP)
# Usage: ./detect-quick.sh <url>
# Example: ./detect-quick.sh https://stripe.com

set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

URL="${1%/}"

echo "=== L1: HTTP Response Headers ==="
echo "Target: $URL"
echo ""

HEADERS="$(curl -sI -L --max-redirs 5 "$URL")" || {
    echo "ERROR: Failed to fetch $URL"
    exit 1
}

echo "$HEADERS"

echo ""
echo "=== L2: Cookies (Set-Cookie) ==="
COOKIES="$(echo "$HEADERS" | grep -i '^set-cookie:' || true)"
if [ -n "$COOKIES" ]; then
    echo "$COOKIES"
else
    echo "(no Set-Cookie headers)"
fi

echo ""
echo "=== CSP Mining: domains in Content-Security-Policy ==="
CSP="$(echo "$HEADERS" | grep -i '^content-security-policy:' || true)"
if [ -n "$CSP" ]; then
    echo "$CSP" | grep -oE '(\*\.)?([a-zA-Z0-9][-a-zA-Z0-9]*\.)+[a-zA-Z]{2,}' | sort -u
    echo ""
    echo "-> Match these domains against references/csp-mining.md"
else
    echo "(no Content-Security-Policy header)"
fi

echo ""
echo "=== Next steps ==="
echo "L3: fetch $URL/robots.txt"
echo "L4: nslookup -type=MX/TXT/NS on the domain"
echo "L5: fetch the HTML and match against references/signatures-platforms.md + signatures-services.md"
