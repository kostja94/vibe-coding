# Report Template

Produce the final tech stack report using this exact structure.

```markdown
# Tech Stack Report: [URL]

**Detection date**: YYYY-MM-DD
**Layers used**: L1–L7 (L8 if SSL checked)

## Stack Summary

| Category | Technology | Version | Confidence | Detected By |
|----------|-----------|---------|------------|-------------|
| Framework | Next.js | 15.5 | High | L1(header) + L5(marker) + L6(globals) |
| Frontend | React | 19.2 | Medium | L5(root pattern) + L6(scriptSrc) |
| CSS | Tailwind CSS | 4.x | High | L5(utility classes) |
| CMS | WordPress | 6.x | High | L5(wp-content) + L2(cookie) |
| Ecommerce | WooCommerce | — | High | L5(plugin path) + L6(globals) |
| Page Builder | Elementor | — | High | L5(class) + L6(globals) |
| CDN | CloudFront | — | High | L1(header) |
| Hosting | Vercel | — | High | L1(header) |
| Web Server | nginx | — | Medium | L1(header) |
| Analytics | GA4 | — | High | L2(cookie) + L5(gtag) |
| Marketing Automation | MailChimp | — | High | L5(script) + L6(globals) |
| Advertising | Google AdSense | — | High | L5(script) |
| Cookie Compliance | OneTrust | — | High | L5(script) + L2(cookie) |
| Live Chat | Intercom | — | High | L5(script) + L6(globals) |
| Social Auth | Google Sign-in | — | High | L5(script) + L6(globals) |
| Social Pixel | TikTok Pixel | — | High | L5(script) + L6(globals) |
| Security | reCAPTCHA | — | High | L5(script) + L6(globals) |
| Error Monitoring | Sentry | — | High | L5(script) + L6(globals) |
| A/B Testing | Optimizely | — | High | L5(script) + L2(cookie) |
| Session Replay | FullStory | — | High | L5(script) + L6(globals) |
| Search | Algolia | — | High | L5(script) + L6(globals) |
| Forms | Typeform | — | High | L5(script) + L6(globals) |
| Scheduling | Calendly | — | High | L5(script) + L6(globals) |
| Comments | Disqus | — | High | L5(script) + L6(globals) |
| Maps | Google Maps | — | High | L5(script) + L6(globals) |
| Video | YouTube embed | — | High | L5(iframe) + L6(globals) |
| Image CDN | Cloudinary | — | High | L5(url pattern) |
| Reviews | Trustpilot | — | High | L5(script) + L6(globals) |
| Headless CMS | Contentful | — | High | L5(url pattern) + L6(globals) |
| Accessibility | accessiBe | — | High | L5(script) + L6(globals) |
| CRM | Salesforce | — | High | L5(script) |
| LMS | Moodle | — | High | L5(marker) |
| Docs | GitBook | — | High | L5(marker) |
| Status Page | Statuspage | — | High | L5(marker) |
| AI Builder | Lovable | — | High | L1(header) + L5(path) |
| Communication | SendGrid | — | High | L5(script) + L6(globals) |
| Finance | Plaid | — | High | L5(script) + L6(globals) |
| Subscription | Recharge | — | High | L5(script) + L6(globals) |
| Affiliate | Impact | — | High | L5(script) |
| Shipping | ShipStation | — | High | L5(script) |
| Tax | TaxJar | — | High | L5(script) |
| Recruiting | Greenhouse | — | High | L5(script) |
| Legal | Termly | — | High | L5(script) |
| Consent | Didomi | — | High | L5(script) |
| Tag Manager | Tealium | — | High | L5(script) + L6(globals) |
| Backend | Supabase | — | High | L7(network) + L6(globals) |
| Multilingual | Weglot | — | High | L5(script) + L6(globals) |
| Survey | Survicate | — | High | L5(script) |
| Changelog | Beamer | — | High | L5(script) |
| Uptime | UptimeRobot | — | High | L5(script) |
| Web3 | WalletConnect | — | High | L5(script) + L6(globals) |
| Email | Google Workspace | — | High | L4(MX) |
| Auth | NextAuth.js | — | Medium | L6(script pattern) |
| Payment | Stripe | — | High | L2(cookie) + L6(global) |
| Build Tool | Turbopack | — | Medium | L6(script analysis) |

## Details

### Layer 1 — HTTP Headers
[Raw header output]

### CSP Mining — Third-Party Services
[CSP domains matched to services: Sentry, Vercel Analytics, Intercom, ...]

### Layer 2 — Cookies
[Relevant cookies found]

### Layer 3 — robots.txt
[Key patterns found, or "no distinctive patterns"]

### Layer 4 — DNS Records
[MX / TXT / NS findings]

### Layer 5 — HTML + Meta Tags
[Framework markers + meta tags found]

### Layer 6 — JS Globals & Versions
[Raw JSON output from browser_evaluate]

### Layer 7 — Network Requests
[API patterns found, chunk analysis]

### Layer 8 — SSL Certificate (if checked)
[Issuer CN, validity dates]
```

## Confidence Rules

- **High**: Confirmed by 2+ independent layers (e.g., L1 header + L5 HTML marker + L2 cookie)
- **Medium**: Single strong signal (e.g., L5 HTML marker only)
- **Low**: Circumstantial (e.g., CSS classes pattern but no JS confirmation)

If a layer was skipped (e.g., no browser tool for L6/L7), state it explicitly in the report — do not fabricate findings for skipped layers.
