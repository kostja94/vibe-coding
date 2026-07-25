# Deployment & Acceptance Checklist

## 1. next.config.ts Full Template

```ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "images.unsplash.com",
      },
      {
        protocol: "https",
        hostname: "*.cdn.example.com",
      },
      {
        protocol: "https",
        hostname: "lovable.dev",
        pathname: "/uploads/**",
      },
    ],
  },

  async headers() {
    return [
      {
        source: "/(.*)",
        headers: [
          {
            key: "X-Frame-Options",
            value: "DENY",
          },
          {
            key: "X-Content-Type-Options",
            value: "nosniff",
          },
          {
            key: "Referrer-Policy",
            value: "strict-origin-when-cross-origin",
          },
          {
            key: "Permissions-Policy",
            value: "camera=(), microphone=(), geolocation=()",
          },
        ],
      },
      {
        source: "/_next/static/(.*)",
        headers: [
          {
            key: "X-Robots-Tag",
            value: "noindex",
          },
        ],
      },
    ];
  },
};

export default nextConfig;
```

---

## 2. Vercel Deployment Steps

### Step 1: Import Repository

1. Go to [vercel.com/new](https://vercel.com/new)
2. Click **Import Git Repository**
3. Select the migrated Next.js repository
4. Click **Import**

### Step 2: Configure Project

| Setting | Value |
|---------|-------|
| Framework Preset | **Next.js** |
| Root Directory | `.` (or sub-directory if monorepo) |
| Build Command | `next build` (auto-detected) |
| Output Directory | `.next` (auto-detected) |
| Install Command | `npm install` (auto-detected) |

### Step 3: Environment Variables

Add all required environment variables in the Vercel dashboard under **Settings → Environment Variables**:

| Key | Value | Environment |
|-----|-------|-------------|
| `NEXT_PUBLIC_SITE_URL` | `https://yourdomain.com` | Production |
| `NEXT_PUBLIC_API_URL` | `https://api.yourdomain.com` | Production, Preview, Development |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | (your key) | Production, Preview, Development |
| `SUPABASE_SERVICE_ROLE_KEY` | (your key) | Production (server-only) |

### Step 4: Deploy

1. Set **Production Branch** to `main`
2. Click **Deploy**
3. Wait for build to complete
4. Verify the deployment URL

### Step 5: Custom Domain

1. Go to **Settings → Domains**
2. Add your production domain
3. Update DNS records at your registrar:
   - **A record**: `76.76.21.21` (Vercel)
   - **CNAME**: `cname.vercel-dns.com` (for subdomains)
4. Wait for SSL certificate provisioning

---

## 3. Environment Variables Table

| Variable | Required | Scope | Description |
|----------|----------|-------|-------------|
| `NEXT_PUBLIC_SITE_URL` | ✅ | Client + Server | Full production URL (e.g., `https://yourdomain.com`). Used for `metadataBase`, canonical URLs, OG URLs, sitemap. |
| `NEXT_PUBLIC_API_URL` | If applicable | Client + Server | Backend API base URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | If using Supabase | Client + Server | Supabase anonymous key for client-side auth |
| `SUPABASE_SERVICE_ROLE_KEY` | If using Supabase | Server only | Supabase service role key — **NEVER** expose client-side |
| `NEXT_PUBLIC_GA_ID` | Optional | Client + Server | Google Analytics measurement ID |
| `NEXT_PUBLIC_STRIPE_KEY` | If using Stripe | Client + Server | Stripe publishable key |
| `LOVABLE_API_KEY` | If AI tool pages | Server only | Lovable API key for AI-powered features; server-only, no `NEXT_PUBLIC_` prefix |

### Variable Migration Checklist

- [ ] All `VITE_*` variables renamed to `NEXT_PUBLIC_*` (client-exposed) or stripped of prefix (server-only)
- [ ] `NEXT_PUBLIC_SITE_URL` added and set to production URL
- [ ] `import.meta.env.VITE_*` references replaced with `process.env.NEXT_PUBLIC_*`
- [ ] No `NEXT_PUBLIC_` prefixed variables contain secrets
- [ ] All server-only secrets lack the `NEXT_PUBLIC_` prefix
- [ ] `.env.local` created for local development
- [ ] `.env.example` created with all required variables (no real values)

---

## 4. DNS / Production Routing Notes

### Option A: Direct Domain (Recommended)

Point your main domain to Vercel:

```
yourdomain.com    →  A record    →  76.76.21.21
www.yourdomain.com → CNAME      →  cname.vercel-dns.com
```

### Option B: Subdomain with Rewrite

If the main domain serves a different app and the Next.js site lives on a subdomain:

```
app.yourdomain.com → CNAME → cname.vercel-dns.com
```

### Option C: Path-based Rewrite (Advanced)

If the Next.js app must serve under a path of an existing domain (e.g., `yourdomain.com/app/`), configure rewrites in `next.config.ts`:

```ts
const nextConfig: NextConfig = {
  basePath: "/app",
  async redirects() {
    return [
      {
        source: "/",
        destination: "/app",
        permanent: false,
      },
    ];
  },
};
```

### SSL

- Vercel provisions SSL certificates automatically
- Force HTTPS in Vercel dashboard: **Settings → Domains → Enable HTTPS Enforcement**
- HSTS can be added via security headers in `next.config.ts`

---

## 5. Full Acceptance Checklist

### Local Validation

- [ ] `npm run build` completes with zero errors
- [ ] `npm run build` has zero TypeScript errors
- [ ] `npm run lint` passes (no new warnings)
- [ ] All pages render correctly in `npm run dev`
- [ ] All dynamic routes work (visit at least one dynamic URL)
- [ ] 404 page renders for invalid routes
- [ ] No `console.error` or `console.warn` in browser for any page
- [ ] No broken internal links (all `<Link href>` resolve)
- [ ] All images load correctly (no 404s for `/images/`, `/og.png`, etc.)
- [ ] Fonts load with `display: swap` (no FOIT)
- [ ] Mobile responsive layout works on all pages
- [ ] Dark/light mode toggle works (if applicable)
- [ ] Forms submit successfully (if applicable)
- [ ] No `VITE_*` environment variable references remain in code
- [ ] No `import.meta.env` references remain in code

### SEO

- [ ] Every page exports `metadata` or `generateMetadata`
- [ ] Every page has a unique `<title>` (via metadata)
- [ ] Every page has a meta description (150-160 characters)
- [ ] Every page has `alternates.canonical` set
- [ ] Every page has Open Graph tags (title, description, image)
- [ ] Root layout has `metadataBase` set from `NEXT_PUBLIC_SITE_URL`
- [ ] Root layout title template uses `%s | BRAND_NAME`
- [ ] `app/robots.ts` exists and is correct
- [ ] `app/sitemap.ts` exists and covers all routes
- [ ] JSON-LD schemas present where applicable (Organization, WebSite, Product, FAQ, Breadcrumb, Article)
- [ ] Semantic HTML used: `<nav>`, `<main>`, `<footer>`, `<section>`, `<article>`, `<header>`
- [ ] All `<img>` tags have `alt` attributes
- [ ] OG image (`/og.png`) exists in `public/` and is 1200x630

### Cleanup

- [ ] All `react-router-dom` imports removed
- [ ] All `@tanstack/react-router` imports removed
- [ ] All `react-helmet-async` imports removed
- [ ] `react-router-dom` removed from `package.json`
- [ ] `@tanstack/react-router` removed from `package.json`
- [ ] `react-helmet-async` removed from `package.json`
- [ ] `vite.config.ts` deleted (no longer needed)
- [ ] `app.config.ts` deleted (if TanStack Start)
- [ ] `src/routeTree.gen.ts` deleted
- [ ] Old `src/routes/` directory deleted after migration
- [ ] Old `src/pages/` directory deleted after migration
- [ ] `index.html` deleted (Next.js uses `app/layout.tsx`)
- [ ] Unused CSS files removed
- [ ] Unused dependencies removed from `package.json`
- [ ] No `.js` files that should be `.ts`/`.tsx`

### Deployment

- [ ] Vercel project created and linked to repository
- [ ] Framework preset set to Next.js
- [ ] Root directory correctly set
- [ ] All environment variables added in Vercel dashboard
- [ ] Production branch set to `main`
- [ ] Custom domain configured
- [ ] DNS records updated
- [ ] SSL certificate provisioned
- [ ] Deployment succeeds on Vercel
- [ ] Production URL loads correctly
- [ ] All pages accessible on production URL
- [ ] `sitemap.xml` accessible at `/sitemap.xml`
- [ ] `robots.txt` accessible at `/robots.txt`

### Security

- [ ] Security headers present: `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`, `Permissions-Policy`
- [ ] `X-Robots-Tag: noindex` set for `/_next/static/*`
- [ ] No secrets in client-exposed code (no `NEXT_PUBLIC_` vars with secret values)
- [ ] No API keys hardcoded in source code
- [ ] `.env.local` in `.gitignore`
- [ ] CORS configured properly for API routes (if any)
- [ ] Rate limiting considered for form submissions
- [ ] Content Security Policy headers considered (optional, advanced)

### Normalization Audit

- [ ] No hardcoded hex colors repeated ≥3 times (all extracted to CSS tokens)
- [ ] No components >300 lines (all split)
- [ ] No components >500 lines without sub-directory
- [ ] No inline `style={{ }}` attributes
- [ ] Components organized into `ui/`, `layout/`, `sections/`, `shared/`
- [ ] No `: any` type annotations
- [ ] All component props have named interfaces
- [ ] All data functions have return type annotations
- [ ] Static data extracted to `data/` directory
- [ ] Custom hooks in `hooks/` directory
- [ ] Utilities in `lib/` directory
- [ ] Types in `types/` directory
- [ ] All images use `next/image` `<Image>` component
- [ ] All images have `width`, `height`, `alt`
- [ ] Hero images have `priority` prop
- [ ] Non-hero images have `loading="lazy"` (default in next/image)
- [ ] All fonts use `next/font` with `display: "swap"`
- [ ] Tailwind config references CSS custom properties (not raw hex)
- [ ] Repeated Tailwind class combinations extracted to `@utility` or component
- [ ] External image domains registered in `next.config.ts` `remotePatterns`
