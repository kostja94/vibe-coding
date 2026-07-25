// detect-js-globals.js — L6 JS Globals + Version Extraction
// Usage: run this entire file's content with browser_evaluate after browser_navigate + browser_wait.
// Returns a JSON string with framework versions, globals, CMS, analytics, payment, auth, PWA, and build tool signals.
//
// If the result is too large for one evaluation, split into two calls:
//   1. versions + framework + cms
//   2. analytics + payment + auth + pwa + build

JSON.stringify({
  // === Framework Versions ===
  versions: {
    react: (() => { try { const m = document.querySelector('script[src*="react-dom."]')?.src?.match(/react-dom[.@](\d+\.\d+\.\d+)/); return m?.[1] || window.React?.version || null; } catch(e) { return null; } })(),
    next: (() => { try { const d = document.getElementById('__NEXT_DATA__'); if (d) { const j = JSON.parse(d.textContent); return j.buildId || null; } return null; } catch(e) { return null; } })(),
    vue: window.__VUE__?.version || window.__vue_app__?.version || null,
    angular: (() => { const el = document.querySelector('[ng-version]'); return el?.getAttribute('ng-version') || null; })(),
    jquery: window.jQuery?.fn?.jquery || null,
    alpine: window.Alpine?.version || null,
    htmx: window.htmx?.version || null
  },

  // === Framework Globals ===
  framework: [
    { name: 'NextJS', detected: !!document.getElementById('__next') },
    { name: 'Nuxt', detected: !!document.getElementById('__nuxt') },
    { name: 'Gatsby', detected: !!document.getElementById('___gatsby') },
    { name: 'React', detected: !!(document.getElementById('root') || document.getElementById('__next') || document.querySelector('[data-reactroot]')) },
    { name: 'Vue', detected: !!document.querySelector('[data-v-]') },
    { name: 'Angular', detected: !!document.querySelector('[_nghost-]') },
    { name: 'Svelte', detected: !!document.querySelector('[class*="svelte-"]') },
    { name: 'jQuery', detected: !!window.jQuery },
    { name: 'AlpineJS', detected: !!window.Alpine },
    { name: 'HTMX', detected: !!window.htmx },
    { name: 'Stimulus', detected: !!window.Stimulus },
    { name: 'Livewire', detected: !!window.Livewire },
    { name: 'SolidJS', detected: !!(window.SolidJS || window._$) }
  ],

  // === CMS & E-Commerce ===
  cms: [
    { name: 'WordPress', detected: !!document.querySelector('[class*="wp-"]') || !!document.querySelector('link[href*="wp-content"]') },
    { name: 'Shopify', detected: !!window.Shopify },
    { name: 'Webflow', detected: !!window.Webflow },
    { name: 'Squarespace', detected: !!window.Static?.SQUARESPACE_CONTEXT },
    { name: 'Wix', detected: !!window.wixBiSession },
    { name: 'Drupal', detected: !!window.Drupal },
    { name: 'Ghost', detected: !!document.querySelector('meta[name="generator"][content*="Ghost"]') },
    { name: 'Joomla', detected: !!document.querySelector('meta[name="generator"][content*="Joomla"]') },
    { name: 'TYPO3', detected: !!document.querySelector('meta[name="generator"][content*="TYPO3"]') },
    { name: 'Blogger', detected: !!document.querySelector('meta[name="generator"][content*="Blogger"]') },
    { name: 'Weebly', detected: !!document.querySelector('meta[name="generator"][content*="Weebly"]') }
  ],

  // === Ecommerce ===
  ecommerce: [
    { name: 'WooCommerce', detected: !!window.wc_add_to_cart_params || !!window.woocommerce_params },
    { name: 'Shopify', detected: !!window.Shopify },
    { name: 'BigCommerce', detected: !!window.stencil },
    { name: 'Magento', detected: !!window.Mage || !!document.querySelector('script[src*="/mage/"]') },
    { name: 'PrestaShop', detected: !!window.prestashop },
    { name: 'Ecwid', detected: !!window.Ecwid },
    { name: 'Snipcart', detected: !!window.Snipcart },
    { name: 'Shopware', detected: !!window.Shopware }
  ],

  // === Marketing & Advertising ===
  marketing: [
    { name: 'Facebook Pixel', detected: !!window.fbq },
    { name: 'MailChimp', detected: !!window.mc4wp || !!document.querySelector('script[src*="list-manage.com"]') },
    { name: 'Klaviyo', detected: !!window.klaviyo },
    { name: 'OneSignal', detected: !!window.OneSignal },
    { name: 'Marketo', detected: !!window.Munchkin },
    { name: 'Matomo', detected: !!window._paq },
    { name: 'Google AdSense', detected: !!window.adsbygoogle },
    { name: 'Google Ad Manager', detected: !!window.googletag?.pubads },
    { name: 'Taboola', detected: !!window._taboola },
    { name: 'Outbrain', detected: !!window.OBR }
  ],

  // === Social Auth ===
  socialAuth: [
    { name: 'Facebook Login', detected: !!window.FB || !!document.querySelector('script[src*="connect.facebook.net"]') },
    { name: 'Google Sign-in', detected: !!window.google?.accounts?.id || !!document.querySelector('script[src*="accounts.google.com/gsi"]') },
    { name: 'Apple Sign-in', detected: !!window.AppleID || !!document.querySelector('script[src*="appleid.cdn.apple.com"]') },
    { name: 'Okta', detected: !!window.OktaSignIn }
  ],

  // === Page Builders ===
  pageBuilders: [
    { name: 'Elementor', detected: !!window.elementorFrontend || !!document.querySelector('[class*="elementor-"]') },
    { name: 'Divi', detected: !!window.ET_Builder || !!document.querySelector('[class*="et_pb_"]') },
    { name: 'WPBakery', detected: !!document.querySelector('[class*="vc_row"]') },
    { name: 'Beaver Builder', detected: !!document.querySelector('[class*="fl-builder"]') }
  ],

  // === Cookie Compliance ===
  cookieCompliance: [
    { name: 'OneTrust', detected: !!window.OnetrustActiveGroups || !!window.OneTrust || !!document.querySelector('script[src*="cookielaw.org"]') },
    { name: 'Cookiebot', detected: !!window.Cookiebot || !!document.querySelector('script[src*="cookiebot.com"]') },
    { name: 'TrustArc', detected: !!window.truste || !!document.querySelector('script[src*="trustarc"]') },
    { name: 'Iubenda', detected: !!window._iub || !!document.querySelector('script[src*="iubenda"]') },
    { name: 'CookieYes', detected: !!window.cookieyes },
    { name: 'Complianz', detected: !!window.cmplz },
    { name: 'Osano', detected: !!window.Osano }
  ],

  // === JS Libraries ===
  jsLibraries: [
    { name: 'GSAP', detected: !!window.gsap },
    { name: 'Lodash/Underscore', detected: !!window._?.VERSION },
    { name: 'D3.js', detected: !!window.d3 },
    { name: 'Chart.js', detected: !!window.Chart },
    { name: 'Three.js', detected: !!window.THREE },
    { name: 'Moment.js', detected: !!window.moment },
    { name: 'Axios', detected: !!window.axios },
    { name: 'Backbone.js', detected: !!window.Backbone },
    { name: 'Emotion', detected: !!window.emotion }
  ],

  // === Live Chat (extended) ===
  liveChat: [
    { name: 'tawk.to', detected: !!window.Tawk_API },
    { name: 'Tidio', detected: !!window.tidioChatApi },
    { name: 'Zendesk Chat', detected: !!window.zE || !!window.$zopim },
    { name: 'LiveChat', detected: !!window.LiveChatWidget || !!window.LC_API }
  ],

  // === Social Pixels ===
  socialPixels: [
    { name: 'TikTok Pixel', detected: !!window.ttq },
    { name: 'LinkedIn Insight', detected: !!window._linkedin_data_partner_ids || !!window.lintrk },
    { name: 'Twitter/X Pixel', detected: !!window.twq },
    { name: 'Snapchat Pixel', detected: !!window.snaptr },
    { name: 'Pinterest Tag', detected: !!window.pintrk },
    { name: 'Yandex Metrica', detected: !!window.ym }
  ],

  // === Security & CAPTCHA ===
  security: [
    { name: 'reCAPTCHA', detected: !!window.grecaptcha || !!document.querySelector('script[src*="recaptcha"]') },
    { name: 'hCaptcha', detected: !!window.hcaptcha || !!document.querySelector('script[src*="hcaptcha"]') },
    { name: 'Cloudflare Turnstile', detected: !!window.turnstile || !!document.querySelector('script[src*="turnstile"]') }
  ],

  // === Error Monitoring & APM ===
  errorMonitoring: [
    { name: 'Rollbar', detected: !!window.Rollbar },
    { name: 'Bugsnag', detected: !!window.Bugsnag },
    { name: 'New Relic', detected: !!window.newrelic },
    { name: 'Dynatrace', detected: !!window.dtrum },
    { name: 'AppDynamics', detected: !!window.ADRUM }
  ],

  // === A/B Testing & Feature Flags ===
  abTesting: [
    { name: 'Optimizely', detected: !!window.optimizely },
    { name: 'VWO', detected: !!window.VWO || !!window._vwo },
    { name: 'LaunchDarkly', detected: !!window.LDClient },
    { name: 'Split.io', detected: !!window.splitio },
    { name: 'Statsig', detected: !!window.Statsig }
  ],

  // === Analytics & Session Replay (extended) ===
  analyticsExtended: [
    { name: 'Heap', detected: !!window.heap },
    { name: 'FullStory', detected: !!window.FS },
    { name: 'Smartlook', detected: !!window.smartlook },
    { name: 'Mouseflow', detected: !!window.mouseflow },
    { name: 'Crazy Egg', detected: !!window.CE2 },
    { name: 'Lucky Orange', detected: !!window.__lo_site_id }
  ],

  // === Marketing Automation (extended) ===
  marketingExtended: [
    { name: 'ActiveCampaign', detected: !!window.vgo || !!document.querySelector('script[src*="activecampaign"]') },
    { name: 'ConvertKit', detected: !!document.querySelector('script[src*="convertkit"]') },
    { name: 'GetResponse', detected: !!window.GrTracking },
    { name: 'Drip', detected: !!window._dcq }
  ],

  // === Search ===
  search: [
    { name: 'Algolia', detected: !!window.algoliasearch },
    { name: 'Typesense', detected: !!window.Typesense },
    { name: 'Meilisearch', detected: !!window.MeiliSearch },
    { name: 'Swiftype', detected: !!window.Swiftype }
  ],

  // === Forms & Scheduling ===
  forms: [
    { name: 'Typeform', detected: !!window.tf || !!document.querySelector('script[src*="typeform"]') },
    { name: 'JotForm', detected: !!window.JotForm },
    { name: 'Calendly', detected: !!window.Calendly },
    { name: 'Cal.com', detected: !!window.Cal }
  ],

  // === Comments & Community ===
  comments: [
    { name: 'Disqus', detected: !!window.DISQUS },
    { name: 'Giscus', detected: !!document.querySelector('script[src*="giscus"]') },
    { name: 'Utterances', detected: !!document.querySelector('script[src*="utteranc.es"]') },
    { name: 'Discourse', detected: !!window.Discourse }
  ],

  // === Maps ===
  maps: [
    { name: 'Google Maps', detected: !!window.google?.maps },
    { name: 'Mapbox', detected: !!window.mapboxgl },
    { name: 'Leaflet', detected: !!window.L?.map }
  ],

  // === Video ===
  video: [
    { name: 'Wistia', detected: !!window.Wistia },
    { name: 'JW Player', detected: !!window.jwplayer },
    { name: 'Brightcove', detected: !!window.bc },
    { name: 'Mux', detected: !!window.mux },
    { name: 'YouTube', detected: !!window.YT },
    { name: 'Vimeo', detected: !!window.Vimeo }
  ],

  // === Image CDN ===
  imageCDN: [
    { name: 'Cloudinary', detected: !!window.cloudinary },
    { name: 'Imgix', detected: !!window.imgix },
    { name: 'ImageKit', detected: !!window.ImageKit }
  ],

  // === Reviews & Loyalty ===
  reviews: [
    { name: 'Trustpilot', detected: !!window.Trustpilot },
    { name: 'Yotpo', detected: !!window.yotpo },
    { name: 'Judge.me', detected: !!window.judgeme },
    { name: 'Smile.io', detected: !!window.Smile }
  ],

  // === Headless CMS ===
  headlessCMS: [
    { name: 'Contentful', detected: !!window.contentful },
    { name: 'Sanity', detected: !!window.sanity },
    { name: 'Strapi', detected: !!window.strapi },
    { name: 'Prismic', detected: !!window.Prismic }
  ],

  // === Accessibility ===
  accessibility: [
    { name: 'accessiBe', detected: !!window.acsbJS },
    { name: 'UserWay', detected: !!window.UserWay }
  ],

  // === Vibe Coding / AI Builders ===
  vibeCoding: [
    { name: 'Lovable', detected: !!window.LOV_SELECTOR_SCRIPT_VERSION },
    { name: 'Gamma', detected: !!window.gammaSiteAnimationsInitialized }
  ],

  // === Communication (Email/SMS) ===
  communication: [
    { name: 'SendGrid', detected: !!window.sendgrid },
    { name: 'Mailgun', detected: !!window.mailgun },
    { name: 'Postmark', detected: !!window.Postmark },
    { name: 'Twilio', detected: !!window.Twilio },
    { name: 'MessageBird', detected: !!window.MessageBird }
  ],

  // === Finance & Banking ===
  finance: [
    { name: 'Plaid', detected: !!window.Plaid }
  ],

  // === Subscription & Billing ===
  subscription: [
    { name: 'Recharge', detected: !!window.ReCharge },
    { name: 'Chargebee', detected: !!window.Chargebee },
    { name: 'Recurly', detected: !!window.Recurly }
  ],

  // === Affiliate & Referral ===
  affiliate: [
    { name: 'Impact', detected: !!window.Impact },
    { name: 'PartnerStack', detected: !!window.PartnerStack },
    { name: 'ReferralCandy', detected: !!window.ReferralCandy },
    { name: 'Friendbuy', detected: !!window.Friendbuy }
  ],

  // === Shipping & Tax ===
  shippingTax: [
    { name: 'ShipStation', detected: !!window.ShipStation },
    { name: 'AfterShip', detected: !!window.AfterShip },
    { name: 'TaxJar', detected: !!window.TaxJar },
    { name: 'Avalara', detected: !!window.Avalara }
  ],

  // === Recruiting & HR ===
  recruiting: [
    { name: 'Greenhouse', detected: !!window.Greenhouse },
    { name: 'Lever', detected: !!window.Lever },
    { name: 'Workable', detected: !!window.Workable }
  ],

  // === Legal & Consent ===
  legalConsent: [
    { name: 'Termly', detected: !!window.Termly },
    { name: 'Didomi', detected: !!window.Didomi },
    { name: 'Usercentrics', detected: !!window.Usercentrics }
  ],

  // === Tag Management ===
  tagManagement: [
    { name: 'Tealium', detected: !!window.tealium },
    { name: 'Adobe Launch', detected: !!window._satellite }
  ],

  // === Database & Backend ===
  databaseBackend: [
    { name: 'Convex', detected: !!window.Convex },
    { name: 'Appwrite', detected: !!window.Appwrite }
  ],

  // === Authentication (Extended) ===
  authExtended: [
    { name: 'Magic.link', detected: !!window.Magic },
    { name: 'Stytch', detected: !!window.Stytch },
    { name: 'Descope', detected: !!window.Descope },
    { name: 'Kinde', detected: !!window.Kinde }
  ],

  // === Multilingual ===
  multilingual: [
    { name: 'Weglot', detected: !!window.Weglot }
  ],

  // === Surveys & Feedback ===
  surveys: [
    { name: 'Survicate', detected: !!window.Survicate },
    { name: 'Qualaroo', detected: !!window.Qualaroo }
  ],

  // === Changelog & Roadmap ===
  changelog: [
    { name: 'Beamer', detected: !!window.Beamer },
    { name: 'AnnounceKit', detected: !!window.AnnounceKit },
    { name: 'Canny', detected: !!window.Canny },
    { name: 'Productboard', detected: !!window.Productboard }
  ],

  // === Uptime & Monitoring ===
  uptimeMonitoring: [
    { name: 'UptimeRobot', detected: !!window.UptimeRobot },
    { name: 'Pingdom', detected: !!window.Pingdom },
    { name: 'Better Stack', detected: !!window.BetterStack },
    { name: 'Instatus', detected: !!window.Instatus }
  ],

  // === Community & Forums ===
  communityForums: [
    { name: 'Circle', detected: !!window.Circle },
    { name: 'XenForo', detected: !!window.XenForo }
  ],

  // === Video & Screen Recording ===
  videoRecording: [
    { name: 'Loom', detected: !!window.Loom },
    { name: 'Vidyard', detected: !!window.Vidyard }
  ],

  // === 3D & Animation ===
  threeDAnimation: [
    { name: 'Spline', detected: !!window.Spline },
    { name: 'Rive', detected: !!window.Rive },
    { name: 'Sketchfab', detected: !!window.Sketchfab }
  ],

  // === Code & Design Embeds ===
  codeDesignEmbeds: [
    { name: 'CodeSandbox', detected: !!window.CodeSandbox },
    { name: 'StackBlitz', detected: !!window.StackBlitz },
    { name: 'Figma', detected: !!window.Figma }
  ],

  // === Events & Donations ===
  eventsDonations: [
    { name: 'Eventbrite', detected: !!window.Eventbrite },
    { name: 'Luma', detected: !!window.Luma },
    { name: 'Donorbox', detected: !!window.Donorbox }
  ],

  // === Web3 & Crypto ===
  web3Crypto: [
    { name: 'WalletConnect', detected: !!window.WalletConnect },
    { name: 'Coinbase Commerce', detected: !!window.CoinbaseCommerce },
    { name: 'BitPay', detected: !!window.BitPay }
  ],

  // === Analytics & Marketing ===
  analytics: [
    { name: 'Google Analytics 4', detected: !!(document.querySelector('script[src*="gtag/js"]')?.src?.includes('G-')) },
    { name: 'Google Tag Manager', detected: !!(document.querySelector('script[src*="gtm.js"]')) },
    { name: 'Plausible', detected: !!document.querySelector('script[src*="plausible.io"]') },
    { name: 'Fathom', detected: !!document.querySelector('script[src*="usefathom.com"]') },
    { name: 'Cloudflare Analytics', detected: !!document.querySelector('script[src*="cloudflareinsights.com"]') },
    { name: 'Microsoft Clarity', detected: !!window.clarity },
    { name: 'Hotjar', detected: !!window.hj },
    { name: 'Intercom', detected: !!window.Intercom },
    { name: 'HubSpot', detected: !!window._hsq },
    { name: 'Sentry', detected: !!window.__SENTRY__ },
    { name: 'Datadog RUM', detected: !!window.DD_RUM },
    { name: 'LogRocket', detected: !!window.LogRocket },
    { name: 'PostHog', detected: !!window.posthog },
    { name: 'Amplitude', detected: !!(window.amplitude?.getInstance) },
    { name: 'Mixpanel', detected: !!window.mixpanel?.init },
    { name: 'Segment', detected: !!window.analytics?.initialized },
    { name: 'Crisp', detected: !!window.$crisp },
    { name: 'Drift', detected: !!window.drift }
  ],

  // === Payment ===
  payment: [
    { name: 'Stripe', detected: !!window.Stripe },
    { name: 'PayPal', detected: !!document.querySelector('script[src*="paypal.com"]') },
    { name: 'Braintree', detected: !!window.braintree },
    { name: 'Paddle', detected: !!document.querySelector('script[src*="paddle.com"]') },
    { name: 'LemonSqueezy', detected: !!document.querySelector('script[src*="lemonsqueezy.com"]') },
    { name: 'Apple Pay', detected: !!window.ApplePaySession },
    { name: 'Google Pay', detected: !!window.google?.payments || !!document.querySelector('script[src*="pay.google.com"]') },
    { name: 'Shop Pay', detected: !!window.ShopPay },
    { name: 'Afterpay', detected: !!window.Afterpay },
    { name: 'Klarna', detected: !!window.Klarna },
    { name: 'Square', detected: !!window.SqPaymentForm || !!window.Square },
    { name: 'Adyen', detected: !!window.AdyenCheckout },
    { name: 'Checkout.com', detected: !!window.Checkout },
    { name: 'Mollie', detected: !!window.Mollie },
    { name: 'Razorpay', detected: !!window.Razorpay }
  ],

  // === Auth ===
  auth: [
    { name: 'NextAuth.js', detected: !!document.querySelector('script[src*="/api/auth/"]') },
    { name: 'Auth0', detected: !!document.querySelector('script[src*="auth0.com"]') || !!window.auth0 },
    { name: 'Clerk', detected: !!document.querySelector('script[src*="clerk."]') || !!window.Clerk },
    { name: 'Supabase Auth', detected: !!document.querySelector('script[src*="supabase.co"]') },
    { name: 'Firebase Auth', detected: !!document.querySelector('script[src*="firebase"]') },
    { name: 'WorkOS', detected: !!document.querySelector('script[src*="workos.com"]') }
  ],

  // === PWA ===
  pwa: {
    manifest: document.querySelector('link[rel="manifest"]')?.href || null,
    serviceWorker: !!navigator.serviceWorker?.controller?.scriptURL,
    appleMobile: !!document.querySelector('meta[name="apple-mobile-web-app-capable"][content="yes"]')
  },

  // === Build Tool ===
  build: [
    { name: 'Webpack', detected: !!(document.querySelector('script')?.textContent?.includes('webpack')) },
    { name: 'Vite', detected: !!(document.querySelector('script[type="module"][src*="/assets/"]')) },
    { name: 'Turbopack', detected: !!(document.querySelector('script[src*="/_next/static/"]') && !document.querySelector('script')?.textContent?.includes('webpack')) },
    { name: 'esbuild', detected: !!(document.querySelector('script')?.textContent?.includes('esbuild')) }
  ]
})
