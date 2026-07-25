# Code Rewrite Rules: Lovable → Next.js 16

## 1. Navigation Replacements

### 1.1 react-router-dom Link → next/link

```diff
- import { Link } from "react-router-dom";
+ import Link from "next/link";

- <Link to="/about">About</Link>
+ <Link href="/about">About</Link>

- <Link to={`/use-cases/${slug}`}>Case</Link>
+ <Link href={`/use-cases/${slug}`}>Case</Link>
```

### 1.2 @tanstack/react-router Link → next/link

```diff
- import { Link, createLink } from "@tanstack/react-router";
+ import Link from "next/link";

- <Link to="/about">About</Link>
+ <Link href="/about">About</Link>

- <Link to="/use-cases/$slug" params={{ slug: "voice" }}>Voice</Link>
+ <Link href="/use-cases/voice">Voice</Link>
```

### 1.3 useNavigate → useRouter

```diff
- import { useNavigate } from "react-router-dom";
+ import { useRouter } from "next/navigation";

- const navigate = useNavigate();
- navigate("/dashboard");
+ const router = useRouter();
+ router.push("/dashboard");

- navigate(-1);
+ router.back();
```

```diff
- import { useNavigate } from "@tanstack/react-router";
+ import { useRouter } from "next/navigation";

- const navigate = useNavigate();
- navigate({ to: "/dashboard" });
+ const router = useRouter();
+ router.push("/dashboard");
```

### 1.4 useParams

```diff
- import { useParams } from "react-router-dom";
+ import { useParams } from "next/navigation";

- const { slug } = useParams();
+ const { slug } = useParams();
```

**Server Component alternative:**

```diff
- const { slug } = useParams();
+ export default function Page({ params }: { params: { slug: string } }) {
+   // params.slug is synchronous in Next.js 16 / React 19
+   return <div>{params.slug}</div>;
+ }
```

### 1.5 Outlet → children

```diff
- import { Outlet } from "react-router-dom";
  // In layout components:
- <Outlet />
+ {children}

// Layout signature changes:
- function Layout() { return <div><Outlet /></div>; }
+ export default function Layout({ children }: { children: React.ReactNode }) {
+   return <div>{children}</div>;
+ }
```

---

## 2. SEO Replacements

### 2.1 react-helmet-async → Metadata API

```diff
- import { Helmet } from "react-helmet-async";
-
- <Helmet>
-   <title>About Us | Brand</title>
-   <meta name="description" content="Learn about our company" />
-   <meta property="og:title" content="About Us | Brand" />
-   <meta property="og:description" content="Learn about our company" />
-   <meta property="og:image" content="/og-about.png" />
- </Helmet>

+ import type { Metadata } from "next";
+
+ export const metadata: Metadata = {
+   title: "About Us | Brand",
+   description: "Learn about our company",
+   openGraph: {
+     title: "About Us | Brand",
+     description: "Learn about our company",
+     images: ["/og-about.png"],
+   },
+ };
```

### 2.2 TanStack head() → Metadata API

```diff
- // src/routes/about.tsx
- import { createFileRoute } from "@tanstack/react-router";
-
- export const Route = createFileRoute("/about")({
-   head: () => ({
-     meta: [
-       { title: "About Us | Brand" },
-       { name: "description", content: "Learn about us" },
-     ],
-   }),
-   component: AboutPage,
- });

+ // app/about/page.tsx
+ import type { Metadata } from "next";
+
+ export const metadata: Metadata = {
+   title: "About Us | Brand",
+   description: "Learn about us",
+ };
+
+ export default function AboutPage() {
+   return <div>About content</div>;
+ }
```

### 2.3 Dynamic page metadata (Next.js 16 / React 19 synchronous params)

```tsx
import type { Metadata } from "next";

export function generateMetadata({ params }: { params: { slug: string } }): Metadata {
  return {
    title: `${params.slug} | Brand`,
    description: `Learn about ${params.slug}`,
    openGraph: {
      title: `${params.slug} | Brand`,
      description: `Learn about ${params.slug}`,
    },
  };
}

export default function Page({ params }: { params: { slug: string } }) {
  return <div>{params.slug}</div>;
}
```

---

## 3. RSC / Client Boundary Rules

### 3.1 Default: Server Component

Every `.tsx` file in `app/` is a **Server Component** by default. No directive needed.

### 3.2 When to Add "use client"

Add `"use client"` as the **first line** of the file when the component uses any of:

| Trigger | Example |
|---------|---------|
| React hooks | `useState`, `useEffect`, `useRef`, `useReducer`, `useCallback`, `useMemo`, `useContext` |
| Event handlers | `onClick`, `onChange`, `onSubmit`, `onKeyDown` |
| Browser APIs | `window`, `document`, `localStorage`, `navigator` |
| Radix UI portals | `Dialog`, `DropdownMenu`, `Popover`, `Tooltip` (render portals) |
| Carousels | Any carousel library with touch/drag interactions |
| framer-motion | `motion.div`, `AnimatePresence`, `useAnimation` |
| Navigation hooks | `useSearchParams()`, `usePathname()`, `useRouter()` |
| Third-party client libs | Any library that accesses `window` on import |

### 3.3 shadcn/ui Components

All shadcn/ui components require `"use client"` because they use Radix UI primitives internally.

```tsx
"use client";

import { Button } from "@/components/ui/button";
// ...
```

### 3.4 Server Action Pattern

When a Server Component needs interactivity, extract the interactive part into a Client Component:

```tsx
// app/about/page.tsx (Server Component — NO "use client")
import { ContactForm } from "@/components/shared/ContactForm";

export const metadata: Metadata = { title: "About" };

export default function AboutPage() {
  return (
    <main>
      <h1>About Us</h1>
      <ContactForm /> {/* Client Component */}
    </main>
  );
}
```

```tsx
// components/shared/ContactForm.tsx
"use client";

import { useState } from "react";

export function ContactForm() {
  const [email, setEmail] = useState("");
  // ...
}
```

---

## 4. Font Migration

### 4.1 Google Fonts → next/font/google

```diff
- <link rel="preconnect" href="https://fonts.googleapis.com" />
- <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
- <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />

+ import { Inter } from "next/font/google";
+
+ const inter = Inter({
+   subsets: ["latin"],
+   display: "swap",
+   variable: "--font-inter",
+ });
```

Apply to root layout:

```tsx
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={inter.variable}>
      <body>{children}</body>
    </html>
  );
}
```

### 4.2 @font-face → next/font/local

```diff
- @font-face {
-   font-family: "BrandFont";
-   src: url("/fonts/brand-font.woff2") format("woff2");
-   font-weight: 400;
-   font-style: normal;
-   font-display: swap;
- }

+ import localFont from "next/font/local";
+
+ const brandFont = localFont({
+   src: "../../public/fonts/brand-font.woff2",
+   display: "swap",
+   variable: "--font-brand",
+ });
```

### 4.3 Font Rules

- **Always** set `display: "swap"` — no exceptions
- Use `variable` option to expose as CSS custom property
- Apply `className={font.variable}` on `<html>` or parent element
- Use `font-family: var(--font-inter)` in Tailwind config or CSS

---

## 5. Image Migration

### 5.1 <img> → next/image

```diff
- <img src="/hero.png" alt="Hero" />
+ import Image from "next/image";
+
+ <Image src="/hero.png" alt="Hero" width={1200} height={630} />
```

```diff
- <img src={logoUrl} alt="Logo" className="w-12 h-12" />
+ <Image src={logoUrl} alt="Logo" width={48} height={48} className="w-12 h-12" />
```

### 5.2 Required Attributes

| Attribute | Required | Notes |
|-----------|----------|-------|
| `src` | ✅ | Local path or external URL |
| `alt` | ✅ | Descriptive alt text; empty string `""` for decorative |
| `width` | ✅ | Pixel value (or use `fill` for responsive) |
| `height` | ✅ | Pixel value (or use `fill` for responsive) |
| `priority` | For LCP | Hero/above-fold images |
| `loading` | Default lazy | `"lazy"` by default; set `priority` for eager |

### 5.3 CDN / External Domains

Any external image domain must be registered in `next.config.ts`:

```ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      { protocol: "https", hostname: "images.unsplash.com" },
      { protocol: "https", hostname: "*.cdn.example.com" },
      { protocol: "https", hostname: "lovable.dev", pathname: "/uploads/**" },
    ],
  },
};

export default nextConfig;
```

---

## 6. Environment Variable Mapping

### 6.1 Client-Exposed Variables

| Lovable (VITE_*) | Next.js (NEXT_PUBLIC_*) | Notes |
|-------------------|------------------------|-------|
| `VITE_API_URL` | `NEXT_PUBLIC_API_URL` | Client-side API base URL |
| `VITE_STRIPE_KEY` | `NEXT_PUBLIC_STRIPE_KEY` | Public Stripe publishable key |
| `VITE_GA_ID` | `NEXT_PUBLIC_GA_ID` | Google Analytics measurement ID |
| `VITE_APP_NAME` | `NEXT_PUBLIC_APP_NAME` | Application display name |

### 6.2 Server-Only / Removed Variables

| Lovable Variable | Next.js Handling | Notes |
|-----------------|------------------|-------|
| `VITE_SUPABASE_URL` | Remove or move to server-only | Supabase URL is not needed client-side in Next.js; use server actions |
| `VITE_SUPABASE_ANON_KEY` | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | If client-side auth is needed |
| `VITE_SUPABASE_SERVICE_KEY` | `SUPABASE_SERVICE_ROLE_KEY` | Server-only, NO `NEXT_PUBLIC_` prefix |

### 6.3 New Variables

| Variable | Purpose |
|----------|---------|
| `NEXT_PUBLIC_SITE_URL` | Full production URL for `metadataBase`, canonical URLs, OG URLs |

### 6.4 Migration Rules

1. Rename `VITE_*` → `NEXT_PUBLIC_*` for client-exposed vars
2. Strip `NEXT_PUBLIC_` prefix for server-only secrets
3. Add `NEXT_PUBLIC_SITE_URL` if not present
4. Remove any `VITE_` variables no longer needed
5. Update all `import.meta.env.VITE_*` → `process.env.NEXT_PUBLIC_*`

```diff
- const apiUrl = import.meta.env.VITE_API_URL;
+ const apiUrl = process.env.NEXT_PUBLIC_API_URL;
```

---

## 7. Next.js 16 / React 19 Specifics

### 7.1 Synchronous params (Critical)

In Next.js 16 with React 19, `params` is a **plain synchronous object**:

```tsx
// ✅ Next.js 16 / React 19
export default function Page({ params }: { params: { slug: string } }) {
  return <h1>{params.slug}</h1>;
}

// ✅ generateMetadata is also synchronous
export function generateMetadata({ params }: { params: { slug: string } }): Metadata {
  return { title: params.slug };
}

// ❌ DO NOT do this (Next.js 15 pattern)
export default async function Page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  // ...
}
```

### 7.2 Synchronous searchParams

```tsx
// ✅ Next.js 16
export default function Page({ searchParams }: { searchParams: { q?: string } }) {
  return <div>Search: {searchParams.q}</div>;
}

// ❌ Next.js 15 pattern — do not await
export default async function Page({ searchParams }: { searchParams: Promise<{ q: string }> }) {
  const { q } = await searchParams;
}
```

### 7.3 React Compiler

Next.js 16 enables the React Compiler by default. Implications:

- No need for manual `useMemo` / `useCallback` in most cases
- The compiler auto-memoizes component renders
- `key` props on list items are still required
- Can be disabled in `next.config.ts` if issues arise: `experimental: { reactCompiler: false }`

### 7.4 Actions Pattern

Server Actions replace API routes for form submissions and mutations:

```tsx
// app/actions.ts
"use server";

export async function submitContact(formData: FormData) {
  const email = formData.get("email") as string;
  // Process...
}
```

```tsx
// components/shared/ContactForm.tsx
"use client";

import { submitContact } from "@/app/actions";

export function ContactForm() {
  return (
    <form action={submitContact}>
      <input name="email" type="email" required />
      <button type="submit">Submit</button>
    </form>
  );
}
```

### 7.5 Migration Summary Table

| Lovable Pattern | Next.js 16 Pattern |
|----------------|-------------------|
| `import.meta.env.VITE_*` | `process.env.NEXT_PUBLIC_*` |
| `useState` + `useEffect` for data | Server Components + async |
| `useLoaderData()` | Direct async in Server Component |
| `<Helmet>` | `export const metadata` |
| `head()` (TanStack) | `export const metadata` / `generateMetadata` |
| `useNavigate()` | `useRouter().push()` |
| `<Link to="">` | `<Link href="">` |
| `<Outlet />` | `{children}` in layout |
| `useParams()` (client) | `useParams()` from `next/navigation` |
| Route params (server) | `{ params }` prop (synchronous) |
| `VITE_*` env vars | `NEXT_PUBLIC_*` / server-only |
| `<img>` | `<Image>` from `next/image` |
| Google Fonts `<link>` | `next/font/google` |
| `@font-face` | `next/font/local` |
