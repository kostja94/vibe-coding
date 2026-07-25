# Third-Party Service Signatures — L5 HTML Source

Third-party service detection: marketing, analytics, chat, auth, payment, compliance, monitoring, and other SaaS integrations. Consult these tables while interpreting Layer 5 raw HTML output.

For platforms (frameworks, CMS, ecommerce), see [signatures-platforms.md](signatures-platforms.md). For L1-L4 and L6-L8, see [signatures.md](signatures.md).

## Table of Contents

- [Marketing & Advertising](#marketing--advertising)
- [Live Chat](#live-chat)
- [Social Auth](#social-auth)
- [Cookie Compliance](#cookie-compliance)
- [Payment](#payment)
- [Social Pixels](#social-pixels)
- [Security & CAPTCHA](#security--captcha)
- [Error Monitoring & APM](#error-monitoring--apm)
- [A/B Testing & Feature Flags](#ab-testing--feature-flags)
- [Analytics & Session Replay](#analytics--session-replay)
- [Marketing Automation (Extended)](#marketing-automation-extended)
- [Search](#search)
- [Forms & Scheduling](#forms--scheduling)
- [Comments & Community](#comments--community)
- [Maps & Video](#maps--video)
- [Image CDN](#image-cdn)
- [Reviews & Loyalty](#reviews--loyalty)
- [Headless CMS](#headless-cms)
- [Accessibility](#accessibility)
- [CRM & LMS](#crm--lms)
- [Docs & Status](#docs--status)
- [Communication (Email/SMS)](#communication-emailsms)
- [Finance & Banking](#finance--banking)
- [Subscription & Billing](#subscription--billing)
- [Affiliate & Referral](#affiliate--referral)
- [Shipping & Tax](#shipping--tax)
- [Recruiting & HR](#recruiting--hr)
- [Legal & Terms](#legal--terms)
- [Consent Management](#consent-management)
- [Tag Management](#tag-management)
- [CDN & Hosting](#cdn--hosting)
- [Database & Backend](#database--backend)
- [Authentication (Extended)](#authentication-extended)
- [Multilingual](#multilingual)
- [Surveys & Feedback](#surveys--feedback)
- [Changelog & Roadmap](#changelog--roadmap)
- [Documentation](#documentation)
- [Uptime & Monitoring](#uptime--monitoring)
- [Community & Forums](#community--forums)
- [Video & Screen Recording](#video--screen-recording)
- [3D & Animation](#3d--animation)
- [Code & Design Embeds](#code--design-embeds)
- [Events & Donations](#events--donations)
- [Web3 & Crypto](#web3--crypto)

---

## Marketing & Advertising

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `connect.facebook.net` / `fbq(` | Facebook Pixel | **High** |
| `mc4wp` / `list-manage.com` | MailChimp | **High** |
| `static.klaviyo.com` / `klaviyo` refs | Klaviyo | **High** |
| `onesignal.com` / `OneSignal` | OneSignal | **High** |
| `sibautomation` / `sendinblue` refs | Sendinblue (Brevo) | **High** |
| `munchkin.marketo.net` / `Munchkin` | Marketo | **High** |
| `matomo` / `piwik` refs | Matomo | **High** |
| `googlesyndication.com` / `adsbygoogle` | Google AdSense | **High** |
| `googletagservices.com` / `GPT` | Google Ad Manager | **High** |
| `cdn.taboola.com` | Taboola | **High** |
| `widgets.outbrain.com` | Outbrain | **High** |

## Live Chat

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `embed.tawk.to` | tawk.to | **High** |
| `code.tidio.co` | Tidio | **High** |
| `static.zdassets.com` / `zopim` | Zendesk Chat | **High** |
| `wa.me` / `api.whatsapp.com` | WhatsApp Business | **High** |
| `secure.livechatinc.com` | LiveChat | **High** |
| `olark.com` / `olark` refs | Olark | **High** |
| `smartsupp` / `smartsuppchat` | Smartsupp | **High** |

## Social Auth

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `connect.facebook.net` SDK / `window.FB` | Facebook Login | **High** |
| `accounts.google.com/gsi/client` | Google Sign-in | **High** |
| `appleid.cdn.apple.com` | Apple Sign-in | **High** |
| `okta.com` / `okta-signin` refs | Okta | **High** |
| `github.com/login/oauth` | GitHub Login | **High** |
| `discord.com/oauth2` | Discord Login | **High** |

## Cookie Compliance

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `cdn.cookielaw.org` / `optanon` | OneTrust | **High** |
| `consent.cookiebot.com` / `Cookiebot` | Cookiebot | **High** |
| `trustarc.com` / `truste` refs | TrustArc | **High** |
| `cdn.iubenda.com` | Iubenda | **High** |
| `cookieyes` / `CookieYes` refs | CookieYes | **High** |
| `complianz` / `cmplz` refs | Complianz | **High** |
| `osano` / `Osano` refs | Osano | **High** |

## Payment

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `ApplePaySession` / `apple-pay` refs | Apple Pay | **High** |
| `pay.google.com` / `GooglePay` | Google Pay | **High** |
| `shop.app` / `ShopPay` | Shop Pay | **High** |
| `afterpay` / `Afterpay` refs | Afterpay | **High** |
| `klarna` / `Klarna` refs | Klarna | **High** |
| `squareup.com` / `SqPaymentForm` / `square` refs | Square | **High** |
| `adyen` / `AdyenCheckout` refs | Adyen | **High** |
| `checkout.com` / `Checkout` refs | Checkout.com | **High** |
| `mollie` / `Mollie` refs | Mollie | **High** |
| `razorpay` / `Razorpay` refs | Razorpay | **High** |

## Social Pixels

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `analytics.tiktok.com` / `ttq(` | TikTok Pixel | **High** |
| `snap.licdn.com` / `linkedin.com/insight` | LinkedIn Insight Tag | **High** |
| `static.ads-twitter.com` / `twq(` | Twitter/X Pixel | **High** |
| `sc-static.net` / `snaptr(` | Snapchat Pixel | **High** |
| `ct.pinterest.com` / `pintrk(` | Pinterest Tag | **High** |
| `metric.yandex.ru` / `mc.yandex` / `ym(` | Yandex Metrica | **High** |

## Security & CAPTCHA

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `google.com/recaptcha` / `grecaptcha` | reCAPTCHA | **High** |
| `hcaptcha.com` / `hcaptcha` | hCaptcha | **High** |
| `challenges.cloudflare.com` / `turnstile` | Cloudflare Turnstile | **High** |

## Error Monitoring & APM

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `rollbar.com` / `Rollbar` refs | Rollbar | **High** |
| `bugsnag` / `Bugsnag` refs | Bugsnag | **High** |
| `newrelic` / `nr-data.net` / `newrelic.com` | New Relic | **High** |
| `dynatrace` / `dynatrace.com` refs | Dynatrace | **High** |
| `appdynamics` / `AppDynamics` refs | AppDynamics | **High** |

## A/B Testing & Feature Flags

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `optimizely` / `optimizely.com` refs | Optimizely | **High** |
| `vwo` / `visualwebsiteoptimizer` refs | VWO | **High** |
| `launchdarkly` / `LaunchDarkly` refs | LaunchDarkly | **High** |
| `split.io` refs | Split.io | **High** |
| `statsig` / `Statsig` refs | Statsig | **High** |

## Analytics & Session Replay

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `heap` / `heapanalytics` refs | Heap | **High** |
| `fullstory` / `FullStory` refs | FullStory | **High** |
| `smartlook` refs | Smartlook | **High** |
| `mouseflow` refs | Mouseflow | **High** |
| `crazyegg` refs | Crazy Egg | **High** |
| `luckyorange` refs | Lucky Orange | **High** |

## Marketing Automation (Extended)

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `activecampaign` refs | ActiveCampaign | **High** |
| `convertkit` / `ck.page` refs | ConvertKit | **High** |
| `getresponse` refs | GetResponse | **High** |
| `drip` / `getdrip` refs | Drip | **High** |
| `customer.io` refs | Customer.io | **High** |
| `braze` / `braze.com` refs | Braze | **High** |
| `iterable` / `iterable.com` refs | Iterable | **High** |

## Search

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `algolia.net` / `algolianet.com` / `algoliasearch` | Algolia | **High** |
| `typesense` refs | Typesense | **High** |
| `meilisearch` refs | Meilisearch | **High** |
| `swiftype` refs | Swiftype | **High** |
| `klevu` refs | Klevu | **High** |
| `searchspring` refs | Searchspring | **High** |

## Forms & Scheduling

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `typeform.com` / `typeform-embed` | Typeform | **High** |
| `jotform.com` | JotForm | **High** |
| `gravityforms` / `gform` refs | Gravity Forms | **High** |
| `calendly.com` | Calendly | **High** |
| `cal.com` refs | Cal.com | **High** |
| `tally.so` / `tally` refs | Tally | **High** |
| `fillout.com` refs | Fillout | **High** |

## Comments & Community

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `disqus.com` / `disqus_thread` | Disqus | **High** |
| `giscus` refs | Giscus | **High** |
| `utteranc.es` | Utterances | **High** |
| `discourse` / `Discourse` refs | Discourse | **High** |
| `hyvor.com` / `hyvortalk` | Hyvor Talk | **High** |

## Maps & Video

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `maps.googleapis.com` / `maps.google.com` | Google Maps | **High** |
| `mapbox.com` / `mapbox-gl` | Mapbox | **High** |
| `leaflet` / `leaflet.js` | Leaflet | **High** |
| `wistia.com` / `wistia.net` | Wistia | **High** |
| `jwplayer` / `jwplatform` | JW Player | **High** |
| `youtube.com/embed` / `youtube-nocookie.com` | YouTube embed | **High** |
| `player.vimeo.com` | Vimeo embed | **High** |

## Image CDN

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `cloudinary.com` / `res.cloudinary.com` | Cloudinary | **High** |
| `imgix.net` | Imgix | **High** |
| `imagekit.io` | ImageKit | **High** |

## Reviews & Loyalty

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `trustpilot.com` / `widget.trustpilot.com` | Trustpilot | **High** |
| `yotpo.com` / `staticw2.yotpo.com` | Yotpo | **High** |
| `judge.me` refs | Judge.me | **High** |
| `smile.io` refs | Smile.io | **High** |
| `okendo` / `okendo.io` refs | Okendo | **High** |
| `loox` / `loox.io` refs | Loox | **High** |

## Headless CMS

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `contentful.com` / `ctfassets.net` | Contentful | **High** |
| `sanity.io` / `cdn.sanity.io` | Sanity | **High** |
| `strapi` / `Strapi` refs | Strapi | **High** |
| `prismic.io` / `prismic` refs | Prismic | **High** |
| `datocms` / `dato` refs | DatoCMS | **High** |

## Accessibility

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `accessibe` / `acsb` refs | accessiBe | **High** |
| `userway` refs | UserWay | **High** |

## CRM & LMS

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `salesforce` / `force.com` refs | Salesforce | **High** |
| `zoho` / `zohopages` refs | Zoho | **High** |
| `moodle` / `Moodle` refs | Moodle | **High** |
| `teachable` refs | Teachable | **High** |
| `learndash` refs | LearnDash | **High** |
| `kajabi` refs | Kajabi | **High** |

## Docs & Status

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `gitbook` refs | GitBook | **High** |
| `readme.io` / `readme` refs | ReadMe | **High** |
| `statuspage.io` refs | Statuspage | **High** |

## Communication (Email/SMS)

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `sendgrid` / `sendgrid.net` | SendGrid | **High** |
| `mailgun` / `mailgun.org` | Mailgun | **High** |
| `postmark` / `postmarkapp` | Postmark | **High** |
| `amazonaws.com/ses` / `amazonses` | Amazon SES | **High** |
| `twilio` / `twilio.com` | Twilio | **High** |
| `messagebird` | MessageBird | **High** |
| `resend` / `resend.com` | Resend | **High** |

## Finance & Banking

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `plaid` / `plaid.com` | Plaid | **High** |

## Subscription & Billing

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `recharge` / `rechargepayments` | Recharge | **High** |
| `chargebee` | Chargebee | **High** |
| `recurly` | Recurly | **High** |

## Affiliate & Referral

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `impact.com` / `impactradius` | Impact | **High** |
| `partnerstack` | PartnerStack | **High** |
| `shareasale` | ShareASale | **High** |
| `referralcandy` | ReferralCandy | **High** |
| `friendbuy` | Friendbuy | **High** |

## Shipping & Tax

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `shipstation` | ShipStation | **High** |
| `aftership` | AfterShip | **High** |
| `taxjar` | TaxJar | **High** |
| `avalara` | Avalara | **High** |

## Recruiting & HR

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `greenhouse` / `greenhouse.io` | Greenhouse | **High** |
| `lever` / `lever.co` | Lever | **High** |
| `workable` | Workable | **High** |

## Legal & Terms

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `termly` / `termly.io` | Termly | **High** |
| `termsfeed` | TermsFeed | **High** |

## Consent Management

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `didomi` / `didomi.io` | Didomi | **High** |
| `usercentrics` | Usercentrics | **High** |

## Tag Management

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `tealium` / `tealiumiq` | Tealium | **High** |
| `adobe.com/launch` / `assets.adobedtm.com` | Adobe Launch | **High** |

## CDN & Hosting

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `keycdn` | KeyCDN | **High** |
| `bunnycdn` / `b-cdn.net` | BunnyCDN | **High** |
| `render.com` / `onrender.com` | Render | **High** |
| `railway.app` | Railway | **High** |
| `pages.dev` | Cloudflare Pages | **High** |
| `amplifyapp.com` | AWS Amplify | **High** |

## Database & Backend

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `planetscale` | PlanetScale | **High** |
| `neon.tech` / `neon` refs | Neon | **High** |
| `convex` / `convex.dev` | Convex | **High** |
| `appwrite` | Appwrite | **High** |

## Authentication (Extended)

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `magic.link` / `Magic` | Magic.link | **High** |
| `stytch` | Stytch | **High** |
| `descope` | Descope | **High** |
| `kinde` | Kinde | **High** |

## Multilingual

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `weglot` / `weglot.com` | Weglot | **High** |

## Surveys & Feedback

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `survicate` | Survicate | **High** |
| `qualaroo` | Qualaroo | **High** |

## Changelog & Roadmap

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `beamer` / `getbeamer` | Beamer | **High** |
| `announcekit` | AnnounceKit | **High** |
| `canny` / `canny.io` | Canny | **High** |
| `productboard` | Productboard | **High** |

## Documentation

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `mintlify` / `mintlify.com` | Mintlify | **High** |
| `docusaurus` | Docusaurus | **High** |
| `stoplight` | Stoplight | **High** |

## Uptime & Monitoring

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `uptimerobot` | UptimeRobot | **High** |
| `pingdom` | Pingdom | **High** |
| `betterstack` / `betterstack.com` | Better Stack | **High** |
| `instatus` | Instatus | **High** |

## Community & Forums

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `circle.so` / `circle` refs | Circle | **High** |
| `xenforo` | XenForo | **High** |

## Video & Screen Recording

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `loom.com` / `loom` refs | Loom | **High** |
| `vidyard` | Vidyard | **High** |

## 3D & Animation

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `spline` / `spline.design` | Spline | **High** |
| `rive` / `rive.app` | Rive | **High** |
| `sketchfab` | Sketchfab | **High** |

## Code & Design Embeds

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `codesandbox.io` | CodeSandbox | **High** |
| `stackblitz` | StackBlitz | **High** |
| `figma.com/embed` | Figma embed | **High** |
| `spotify.com/embed` / `open.spotify.com` | Spotify embed | **High** |

## Events & Donations

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `eventbrite` / `eventbrite.com` | Eventbrite | **High** |
| `lu.ma` / `luma` refs | Luma | **High** |
| `donorbox` | Donorbox | **High** |

## Web3 & Crypto

| Pattern | Indicates | Confidence |
|---------|-----------|:---:|
| `walletconnect` / `WalletConnect` | WalletConnect | **High** |
| `coinbase.com/commerce` / `CoinbaseCommerce` | Coinbase Commerce | **High** |
| `bitpay` / `BitPay` | BitPay | **High** |
