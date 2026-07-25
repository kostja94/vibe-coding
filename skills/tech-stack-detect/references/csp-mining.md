# CSP Mining: Third-Party Services from Content-Security-Policy

The `Content-Security-Policy` header is a **free technology roster**. A strict CSP must explicitly whitelist every external domain the page loads scripts, styles, images, fonts, WebSocket connections, and API calls from — so it inadvertently becomes a comprehensive list of the site's third-party dependencies.

**Method**: Scan each CSP directive (`script-src`, `connect-src`, `img-src`, `font-src`, `media-src`, `frame-src`, `worker-src`). Match domains to the table below — confidence **High** (CSP is authoritative). CSP may reveal MORE services than HTML — `connect-src` lists backend API domains invisible in the DOM.

| CSP Domain Pattern | Service | Category |
|--------------------|---------|----------|
| `*.sentry.io` | Sentry | Error Monitoring |
| `datadoghq.com` | Datadog | Monitoring / RUM |
| `va.vercel-scripts.com` | Vercel Analytics | Analytics |
| `static.cloudflareinsights.com` | Cloudflare Analytics | Analytics |
| `googletagmanager.com` / `google-analytics.com` | Google Analytics / GTM | Analytics |
| `plausible.io` | Plausible | Privacy Analytics |
| `usefathom.com` | Fathom | Privacy Analytics |
| `clarity.ms` | Microsoft Clarity | Session Replay |
| `hotjar.com` | Hotjar | Session Replay |
| `logrocket.io` | LogRocket | Session Replay |
| `posthog.com` / `app.posthog.com` | PostHog | Product Analytics |
| `amplitude.com` | Amplitude | Product Analytics |
| `mxpnl.com` | Mixpanel | Product Analytics |
| `segment.com` | Segment | CDP / Analytics |
| `intercomcdn.com` / `intercom.io` | Intercom | Customer Support |
| `crisp.chat` | Crisp | Customer Support |
| `zendesk.com` | Zendesk | Customer Support |
| `hs-scripts.com` / `hubspot.com` | HubSpot | Marketing / CRM |
| `licdn.com` / `linkedin.com` | LinkedIn | Social / Ads |
| `facebook.net` / `facebook.com` | Meta / Facebook | Social / Ads |
| `ads-twitter.com` / `twitter.com` | Twitter / X | Social / Ads |
| `stripe.com` / `stripe.network` | Stripe | Payment |
| `paypal.com` / `paypalobjects.com` | PayPal | Payment |
| `paddle.com` | Paddle | Payment (MoR) |
| `lemonsqueezy.com` | Lemon Squeezy | Payment (MoR) |
| `clerk.com` / `clerk.dev` | Clerk | Auth |
| `auth0.com` | Auth0 | Auth |
| `workos.com` | WorkOS | Auth / SSO |
| `supabase.co` | Supabase | Backend / Storage |
| `firebaseio.com` / `firestore.googleapis.com` | Firebase | Backend |
| `algolia.net` / `algolianet.com` | Algolia | Search |
| `contentful.com` / `ctfassets.net` | Contentful | Headless CMS |
| `sanity.io` / `cdn.sanity.io` | Sanity | Headless CMS |
| `amazonaws.com` / `r2.dev` / `vercel-storage.com` | File Storage (S3 / R2 / Vercel Blob) | Storage |
| `pusher.com` (wss://) | Pusher | Realtime / WebSocket |
| `twilio.com` | Twilio | Communications |
| `clearbit.com` | Clearbit | Data Enrichment |
| `youtube.com` / `vimeo.com` | YouTube / Vimeo | Video |
| `fonts.googleapis.com` / `gstatic.com` | Google Fonts | Fonts |
| `typekit.net` | Adobe Fonts / Typekit | Fonts |
| `gravatar.com` | Gravatar | Avatars |
| `github.io` / `githubusercontent.com` | GitHub | Assets |
| `codesandbox.io` | CodeSandbox | Embeds |
| `unpkg.com` / `jsdelivr.net` | CDN (generic) | Asset Delivery |
