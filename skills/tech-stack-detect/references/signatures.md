# Detection Signatures Reference

Pattern-matching tables for the 8 detection layers. Consult the relevant section while interpreting each layer's raw output.

**File organization:**

| File | Content |
|------|---------|
| **This file** | L1-L4 (headers / cookies / robots.txt / DNS) + L6-L8 (JS groups / network / SSL) |
| [signatures-platforms.md](signatures-platforms.md) | L5 platforms: frameworks, CMS, ecommerce, page builders, AI builders, WP plugins |
| [signatures-services.md](signatures-services.md) | L5 third-party services: marketing, analytics, chat, payment, compliance, etc. |
| [csp-mining.md](csp-mining.md) | CSP domain → service mapping |
| [ai-builder-fingerprints.md](ai-builder-fingerprints.md) | AI builder / vibe-coding platform fingerprints |

## Table of Contents

- [Layer 1: HTTP Response Headers](#layer-1-http-response-headers)
- [Layer 2: Cookies](#layer-2-cookies)
- [Layer 3: robots.txt](#layer-3-robotstxt)
- [Layer 4: DNS Records](#layer-4-dns-records)
- [Layer 5: HTML Source + Meta Tags](#layer-5-html-source--meta-tags)
- [Layer 6: JS Globals + Version Extraction](#layer-6-js-globals--version-extraction)
- [Layer 7: Network Request Analysis](#layer-7-network-request-analysis)
- [Layer 8: SSL/TLS Certificate](#layer-8-ssltls-certificate)

---

## Layer 1: HTTP Response Headers

| Header | Indicates |
|--------|-----------|
| `X-Powered-By: Next.js` | Next.js |
| `X-Powered-By: Express` | Express.js |
| `X-Powered-By: PHP/x.x` | PHP (with version) |
| `Server: nginx` | Nginx |
| `Server: Caddy` | Caddy |
| `Server: cloudflare` | Cloudflare CDN |
| `Via: 1.1 ...cloudfront...` | AWS CloudFront |
| `X-Vercel-Id` / `X-Vercel-Cache` / `x-matched-path` | Deployed on Vercel |
| `CF-Ray` / `CF-Cache-Status` | Deployed on Cloudflare |
| `X-NF-Request-ID` / `x-nf-deploy-id` | Deployed on Netlify |
| `X-Amz-Cf-Pop` | AWS CloudFront |
| `fly-request-id` | Fly.io |
| `Vary: rsc` / `next-router-state-tree` | Next.js App Router |
| `Strict-Transport-Security` | HTTPS enforcement |
| `X-Generator: Drupal` | Drupal |
| `X-AspNet-Version` / `X-AspNetMvc-Version` | ASP.NET (with version) |
| `X-Powered-By: ASP.NET` | ASP.NET |
| `Server: Apache` | Apache |
| `Server: LiteSpeed` | LiteSpeed |
| `Server: Microsoft-IIS/x.x` | IIS (with version) |
| `Server: openresty` | OpenResty (nginx + Lua) |
| `Server: gunicorn` / `Server: uvicorn` | Python WSGI/ASGI server |
| `X-Drupal-Cache` / `X-Drupal-Dynamic-Cache` | Drupal |
| `X-Ghost-Cache-Status` | Ghost |
| `X-Shopify-Stage` / `X-ShopId` / `X-ShardId` | Shopify |
| `X-Wix-Request-Id` / `X-Wix-Server` | Wix |
| `X-Served-By: cache-*` | Fastly |
| `X-Varnish` / `Via: ... varnish` | Varnish cache |
| `Akamai-Origin-Hop` / `X-Akamai-Transformed` | Akamai |
| `X-Powered-By: WP Engine` | WP Engine (managed WordPress) |
| `X-Kinsta-Cache` | Kinsta (managed WordPress) |
| `X-LiteSpeed-Cache` | LiteSpeed Cache |
| `X-Mod-Pagespeed` / `X-Page-Speed` | mod_pagespeed |
| `X-Powered-By: PleskLin` / `X-Powered-By: PleskWin` | Plesk |
| `x-lov-locale` / `x-serving-backend: app` / `x-browser-engine` | Lovable (AI builder) |
| `replit-cluster` | Replit (AI builder) |

For `Content-Security-Policy` mining, see [csp-mining.md](csp-mining.md).

---

## Layer 2: Cookies

| Cookie Pattern | Technology | Confidence |
|---------------|-----------|:---:|
| `wp-settings-` | WordPress | **High** |
| `wordpress_logged_in_` | WordPress (authenticated) | **High** |
| `_shopify_` | Shopify | **High** |
| `PHPSESSID` | PHP | **High** |
| `JSESSIONID` | Java / Tomcat | **High** |
| `laravel_session` | Laravel | **High** |
| `connect.sid` | Express.js (express-session) | **High** |
| `ssr-caching` | Wix | **High** |
| `__cf_bm` | Cloudflare Bot Management | **High** |
| `_cfuvid` | Cloudflare | **High** |
| `__stripe_mid` | Stripe | **High** |
| `_ga` / `_gid` / `_gat` | Google Analytics | **High** |
| `intercom-session-` | Intercom | **High** |
| `amplitude_id_` | Amplitude | **High** |
| `mp_` | Mixpanel | **High** |
| `ajs_` | Segment | **High** |
| `_hj` | Hotjar | **High** |
| `_ga_` | Google Analytics 4 | **High** |
| `.AspNetCore.` | ASP.NET Core | **High** |
| `ASP.NET_SessionId` | ASP.NET | **High** |
| `csrftoken` | Django | **High** |
| `SSESS` (prefix) | Drupal session | **High** |
| `wp_woocommerce_` / `woocommerce_items_in_cart` | WooCommerce | **High** |
| `_shopify_y` / `_shopify_s` | Shopify | **High** |
| `CRAFT_CSRF_TOKEN` | Craft CMS | **High** |
| `OptanonConsent` / `OptanonAlertBoxClosed` | OneTrust | **High** |
| `CookieConsent` | Cookiebot | **High** |
| `_fbp` / `_fbc` | Facebook Pixel | **High** |
| `hubspotutk` / `__hssc` / `__hssrc` / `__hstc` | HubSpot | **High** |
| `_gcl_au` | Google Ads | **High** |
| `_clck` / `_clsk` | Microsoft Clarity | **High** |
| `_uetsid` / `_uetvid` | Microsoft Advertising | **High** |
| `_pin_unauth` | Pinterest Tag | **High** |
| `_pk_id` / `_pk_ses` | Matomo | **High** |
| `mailchimp_landing_site` | MailChimp | **High** |
| `BIGipServer` (prefix) | F5 BIG-IP load balancer | **High** |
| `AWSALB` / `AWSALBCORS` | AWS Application Load Balancer | **High** |
| `_mkto_trk` | Marketo | **High** |
| `_ttp` | TikTok Pixel | **High** |
| `_scid` | Snapchat Pixel | **High** |
| `lidc` / `li_sugr` | LinkedIn | **High** |
| `_ym_uid` / `_ym_d` | Yandex Metrica | **High** |
| `optimizelyEndUserId` | Optimizely | **High** |
| `_vwo_uuid` / `_vwo_ds` | VWO | **High** |
| `_hp2_` (prefix) | Heap | **High** |
| `fs_uid` | FullStory | **High** |
| `nlbi_` / `visid_incap_` / `incap_ses_` (prefix) | Imperva Incapsula | **High** |
| `_abck` / `ak_bmsc` / `bm_sz` | Akamai Bot Manager | **High** |
| `dtCookie` / `dtSa` / `dtPC` | Dynatrace | **High** |
| `ADRUM_` (prefix) | AppDynamics | **High** |
| `NSC_` (prefix) | Citrix NetScaler | **High** |
| `sib_cuid` | Sendinblue (Brevo) | **High** |
| `lovable-preview-mode` | Lovable (AI builder) | **High** |
| `rs_visitor_id` | Lovable (RudderStack analytics) | **High** |
| `_csrf` | CSRF middleware (generic) | Medium |

---

## Layer 3: robots.txt

| Pattern | Technology |
|---------|-----------|
| `Disallow: /wp-admin/` | WordPress |
| `Disallow: /admin/` | Django / Laravel / generic |
| `Disallow: /_next/` | Next.js |
| `Disallow: /_nuxt/` | Nuxt.js |
| `Disallow: /api/` | API-first architecture |
| `Sitemap:` any URL | Site has sitemap — valuable for further analysis |
| `User-agent: GPTBot` | Blocking AI crawlers |
| `Disallow: /ghost/` | Ghost |
| `Disallow: /typo3/` | TYPO3 |
| `Disallow: /administrator/` | Joomla |
| `Disallow: /user/login` / `Disallow: /node/` | Drupal |
| `Disallow: /catalogsearch/` / `Disallow: /customer/` | Magento |

---

## Layer 4: DNS Records

### MX Patterns

| MX Pattern | Service |
|-----------|---------|
| `aspmx.l.google.com` | Google Workspace |
| `mail.protection.outlook.com` | Microsoft 365 |
| `route1.mx.cloudflare.net` | Cloudflare Email Routing |
| `mxbiz*.qq.com` | 腾讯企业邮箱 |

### TXT Patterns

| TXT Pattern | Service |
|-------------|---------|
| `google-site-verification=` | Google Search Console |
| `v=spf1 include:_spf.google.com` | Google Workspace |
| `MS=ms` | Microsoft 365 |
| `stripe-verification=` | Stripe |
| `facebook-domain-verification=` | Meta / Facebook |
| `atlassian-domain-verification=` | Atlassian |
| `lovable_verification=` | Lovable (custom domain verification) |
| `cursor-domain-verification` | Cursor services (proves domain ownership only, NOT that the site was AI-built) |
| `windsurf-verification=` | Windsurf services (proves domain ownership only, NOT that the site was AI-built) |

### NS Patterns

| NS Pattern | Service |
|-----------|---------|
| `*.ns.cloudflare.com` | Cloudflare DNS |
| `ns-*.awsdns-*.com` | AWS Route 53 |
| `dns1.p01.nsone.net` | Heroku |
| `*.domaincontrol.com` | GoDaddy |
| `*.registrar-servers.com` | Namecheap |

---

## Layer 5: HTML Source + Meta Tags

L5 signature tables are split into two files by category:

- **Platforms** (frameworks, CMS, ecommerce, page builders, AI builders, WP plugins): [signatures-platforms.md](signatures-platforms.md)
- **Third-party services** (marketing, analytics, chat, auth, payment, compliance, monitoring, etc.): [signatures-services.md](signatures-services.md)

---

## Layer 6: JS Globals + Version Extraction

The detection script lives at [scripts/detect-js-globals.js](../scripts/detect-js-globals.js). Read that file and run its entire content with `browser_evaluate` after `browser_navigate` + `browser_wait`.

It returns a JSON string with these groups:

| Group | What it detects |
|-------|-----------------|
| `versions` | React / Next / Vue / Angular / jQuery / Alpine / HTMX version numbers |
| `framework` | Framework globals (Next.js, Nuxt, Gatsby, Vue, Svelte, SolidJS, ...) |
| `cms` | WordPress, Shopify, Webflow, Squarespace, Wix, Drupal, Ghost, Joomla, TYPO3, Blogger, Weebly |
| `ecommerce` | WooCommerce, Shopify, BigCommerce, Magento, PrestaShop, Ecwid, Snipcart, Shopware |
| `marketing` | Facebook Pixel, MailChimp, Klaviyo, OneSignal, Marketo, Matomo, AdSense, Ad Manager, Taboola, Outbrain |
| `analytics` | GA4, GTM, Plausible, Clarity, Hotjar, PostHog, Sentry, ... |
| `socialAuth` | Facebook Login, Google Sign-in, Apple Sign-in, Okta |
| `pageBuilders` | Elementor, Divi, WPBakery, Beaver Builder |
| `cookieCompliance` | OneTrust, Cookiebot, TrustArc, Iubenda, CookieYes, Complianz, Osano |
| `jsLibraries` | GSAP, Lodash, D3, Chart.js, Three.js, Moment, Axios, Backbone, Emotion |
| `liveChat` | tawk.to, Tidio, Zendesk Chat, LiveChat |
| `socialPixels` | TikTok, LinkedIn Insight, Twitter/X, Snapchat, Pinterest, Yandex Metrica |
| `security` | reCAPTCHA, hCaptcha, Cloudflare Turnstile |
| `errorMonitoring` | Rollbar, Bugsnag, New Relic, Dynatrace, AppDynamics |
| `abTesting` | Optimizely, VWO, LaunchDarkly, Split.io, Statsig |
| `analyticsExtended` | Heap, FullStory, Smartlook, Mouseflow, Crazy Egg, Lucky Orange |
| `marketingExtended` | ActiveCampaign, ConvertKit, GetResponse, Drip |
| `search` | Algolia, Typesense, Meilisearch, Swiftype |
| `forms` | Typeform, JotForm, Calendly, Cal.com |
| `comments` | Disqus, Giscus, Utterances, Discourse |
| `maps` | Google Maps, Mapbox, Leaflet |
| `video` | Wistia, JW Player, Brightcove, Mux, YouTube, Vimeo |
| `imageCDN` | Cloudinary, Imgix, ImageKit |
| `reviews` | Trustpilot, Yotpo, Judge.me, Smile.io |
| `headlessCMS` | Contentful, Sanity, Strapi, Prismic |
| `accessibility` | accessiBe, UserWay |
| `vibeCoding` | Lovable, Gamma |
| `communication` | SendGrid, Mailgun, Postmark, Twilio, MessageBird |
| `finance` | Plaid |
| `subscription` | Recharge, Chargebee, Recurly |
| `affiliate` | Impact, PartnerStack, ReferralCandy, Friendbuy |
| `shippingTax` | ShipStation, AfterShip, TaxJar, Avalara |
| `recruiting` | Greenhouse, Lever, Workable |
| `legalConsent` | Termly, Didomi, Usercentrics |
| `tagManagement` | Tealium, Adobe Launch |
| `databaseBackend` | Convex, Appwrite |
| `authExtended` | Magic.link, Stytch, Descope, Kinde |
| `multilingual` | Weglot |
| `surveys` | Survicate, Qualaroo |
| `changelog` | Beamer, AnnounceKit, Canny, Productboard |
| `uptimeMonitoring` | UptimeRobot, Pingdom, Better Stack, Instatus |
| `communityForums` | Circle, XenForo |
| `videoRecording` | Loom, Vidyard |
| `threeDAnimation` | Spline, Rive, Sketchfab |
| `codeDesignEmbeds` | CodeSandbox, StackBlitz, Figma |
| `eventsDonations` | Eventbrite, Luma, Donorbox |
| `web3Crypto` | WalletConnect, Coinbase Commerce, BitPay |
| `payment` | Stripe, PayPal, Braintree, Paddle, LemonSqueezy, Apple Pay, Google Pay, Shop Pay, Afterpay, Klarna, Square, Adyen, Checkout.com, Mollie, Razorpay |
| `auth` | NextAuth.js, Auth0, Clerk, Supabase Auth, Firebase Auth, WorkOS |
| `pwa` + `build` | Manifest / service worker; Webpack / Vite / Turbopack / esbuild hints |

If the result is too large, split into two evaluations: first `versions` + `framework` + `cms` + `ecommerce`, then the remaining groups.

---

## Layer 7: Network Request Analysis

| Pattern | Indicates |
|---------|-----------|
| `/_next/static/chunks/app/` | Next.js App Router (detect version from chunk hash pattern) |
| `/_next/static/chunks/pages/` | Next.js Pages Router |
| `/api/trpc/` | tRPC backend |
| `/graphql` | GraphQL endpoint |
| `supabase.co` | Supabase |
| `firebaseio.com` | Firebase Realtime Database |
| `cdn.amplitude.com` | Amplitude |
| `sentry.io/api/` | Sentry error tracking |
| `api.stripe.com` | Stripe |
| `clerk.dev` / `clerk.com` | Clerk Auth |
| `*.algolia.net` | Algolia Search |
| `*.algolianet.com` | Algolia |
| `*.sanity.io` / `*.contentful.com` | Headless CMS |
| `*.storj.io` / `*.supabase.co/storage` | File storage |
| `vitals.vercel-insights.com` | Vercel Analytics |
| `*.splitbee.io` | Splitbee Analytics |
| `lovable-uploads` | Lovable (storage path) |
| `vusercontent.net` | v0 by Vercel (template assets, unreliable) |

---

## Layer 8: SSL/TLS Certificate

| Issuer CN Pattern | Platform |
|-------------------|----------|
| `Let's Encrypt` | Self-hosted / VPS (generic) |
| `Amazon` | AWS Certificate Manager |
| `Cloudflare Inc` | Cloudflare proxy |
| `Google Trust Services` | GCP |
| `DigiCert` | Enterprise (large orgs) |
