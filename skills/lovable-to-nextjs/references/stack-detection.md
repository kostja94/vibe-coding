# Stack Detection & Route Mapping

## 1. Detection Commands

Run these checks in the project root to determine which Lovable stack is in use.

| Check | Command | Stack A (TanStack Start) | Stack B (Vite + React Router) |
|-------|---------|--------------------------|-------------------------------|
| Config file | `Test-Path app.config.ts` | ✅ exists | ❌ absent |
| Config file | `Test-Path vite.config.ts` | ❌ absent | ✅ exists |
| Route directory | `Test-Path src/routes` | ✅ exists | ❌ absent |
| Pages directory | `Test-Path src/pages` | ❌ absent | ✅ may exist |
| Router package | `grep "@tanstack/react-router" package.json` | ✅ found | ❌ absent |
| Router package | `grep "react-router-dom" package.json` | ❌ absent | ✅ found |
| Entry file | `Test-Path src/router.tsx` or `Test-Path src/routeTree.gen.ts` | ✅ exists | ❌ absent |
| Entry file | `Test-Path src/App.tsx` with `<Routes>` | ❌ absent | ✅ exists |

**Quick one-liner detection:**

```powershell
if (Test-Path app.config.ts) { "Stack A: TanStack Start" } elseif (Test-Path vite.config.ts) { "Stack B: Vite + React Router" } else { "Unknown stack" }
```

## 2. Stack Profiles

### Stack A: TanStack Start

```
app.config.ts          # TanStack Start config
src/router.tsx         # Router definition (createRouter)
src/routeTree.gen.ts   # Auto-generated route tree
src/routes/            # File-based routing directory
  __root.tsx           # Root layout
  index.tsx            # Home page
  about.tsx            # /about
  legal.privacy.tsx    # /legal/privacy
  use-cases.$slug.tsx  # /use-cases/:slug (dynamic)
```

- Uses `@tanstack/react-router` and `@tanstack/start`
- File-based routing via `src/routes/` with dot-notation for nesting
- `__root.tsx` defines the outermost layout
- Dynamic segments use `$param` syntax
- Route exports: `component`, `loader`, `head`

### Stack B: Vite + React Router

```
vite.config.ts         # Vite config
src/main.tsx           # Entry point, renders <App />
src/App.tsx            # Contains <BrowserRouter> + <Routes>
src/pages/             # Page components (optional convention)
  Index.tsx
  About.tsx
  VoiceChangerDynamic.tsx  # uses useParams()
```

- Uses `react-router-dom` (v6+)
- Route definitions are imperative in `App.tsx` or a router config
- PascalCase file names common (Index.tsx, About.tsx)
- Dynamic segments use `:param` syntax in `<Route path=":slug">`
- Layouts use `<Outlet>` wrapper components

## 3. Route Mapping Rules

| Lovable Pattern | Next.js App Router Pattern | Example |
|-----------------|---------------------------|---------|
| `index.tsx` / `Index.tsx` | `page.tsx` | `src/routes/index.tsx` → `app/page.tsx` |
| `about.tsx` / `About.tsx` | `about/page.tsx` | `src/routes/about.tsx` → `app/about/page.tsx` |
| `legal.privacy.tsx` | `legal/privacy/page.tsx` | Dot notation → nested directory |
| `use-cases.$slug.tsx` | `use-cases/[slug]/page.tsx` | `$param` → `[param]` |
| `VoiceChangerDynamic.tsx` with `useParams()` | `[slug]/page.tsx` (or appropriate dynamic segment) | Infer from Route component usage |
| `__root.tsx` / `App.tsx` outer layout | `layout.tsx` | Root layout → `app/layout.tsx` |
| `blog.$postId.tsx` | `blog/[postId]/page.tsx` | Named dynamic segment |
| `_auth.login.tsx` (layout group) | `(auth)/login/page.tsx` | Underscore prefix → route group |
| `_auth._layout.tsx` | `(auth)/layout.tsx` | Layout route group |

### Mapping Algorithm

```
1. Replace dots (.) with directory separators (/)
2. Replace $param with [param]
3. Replace underscore-prefixed segments (_name) with route groups (name)
4. Strip __root → root layout.tsx
5. Rename the final file to page.tsx (or layout.tsx for layout routes)
```

## 4. Enumerating All Routes

### Stack A (TanStack Start)

```powershell
# List all route files
Get-ChildItem -Path src\routes -Recurse -Filter *.tsx | ForEach-Object {
  $relative = $_.FullName.Replace((Resolve-Path src\routes).Path + "\", "")
  $routePath = $relative -replace "\.tsx$", "" -replace "\.", "/" -replace "\$", ":"
  Write-Output "$routePath -> $_"
}
```

Alternatively, parse `src/routeTree.gen.ts` for the canonical route list.

### Stack B (Vite + React Router)

```powershell
# Extract Route definitions from App.tsx or router config
Select-String -Path src\App.tsx -Pattern '<Route\s+path="([^"]*)"'
```

Or list all files in `src/pages/`:

```powershell
Get-ChildItem -Path src\pages -Recurse -Filter *.tsx | ForEach-Object {
  Write-Output $_.Name
}
```

## 5. Route Mapping Table Template

Fill this table for every project migration:

| # | Original URL | Next.js File Path | Static/Dynamic | Notes |
|---|-------------|-------------------|----------------|-------|
| 1 | `/` | `app/page.tsx` | Static | Home page |
| 2 | `/about` | `app/about/page.tsx` | Static | |
| 3 | `/legal/privacy` | `app/legal/privacy/page.tsx` | Static | |
| 4 | `/use-cases/:slug` | `app/use-cases/[slug]/page.tsx` | Dynamic | `params.slug` synchronous in React 19 |
| 5 | `/blog/:postId` | `app/blog/[postId]/page.tsx` | Dynamic | May need `generateStaticParams` |
| 6 | (layout) | `app/layout.tsx` | — | Root layout from `__root.tsx` |
| 7 | (layout) | `app/(auth)/layout.tsx` | — | Auth layout group |

## 6. Dynamic Route Handling in Next.js 16 (React 19)

**Critical:** In Next.js 16 with React 19, `params` and `searchParams` are **synchronous objects**, NOT Promises.

### Page Component

```tsx
// ✅ Correct — Next.js 16 / React 19
export default function Page({ params }: { params: { slug: string } }) {
  return <div>{params.slug}</div>;
}

// ❌ Wrong — legacy Next.js 15 async style
export default async function Page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return <div>{slug}</div>;
}
```

### generateMetadata

```tsx
// ✅ Correct — synchronous params
export function generateMetadata({ params }: { params: { slug: string } }) {
  return { title: `${params.slug} | Brand` };
}

// ❌ Wrong — do not await params
export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  // ...
}
```

### generateStaticParams

```tsx
// ✅ Correct — still returns array of param objects
export async function generateStaticParams() {
  const slugs = await fetchSlugs();
  return slugs.map((slug) => ({ slug }));
}
```

### Client Components with useParams

```tsx
"use client";
import { useParams } from "next/navigation";

export default function DynamicClient() {
  const params = useParams(); // { slug: string } — synchronous
  return <div>{params.slug}</div>;
}
```

### Summary

| API | Next.js 15 | Next.js 16 (React 19) |
|-----|------------|----------------------|
| Page `params` | `Promise<{ slug: string }>` | `{ slug: string }` (sync) |
| Page `searchParams` | `Promise<{ q: string }>` | `{ q: string }` (sync) |
| `generateMetadata` params | `Promise` | Synchronous |
| `useParams()` | Synchronous | Synchronous (unchanged) |
| `useSearchParams()` | Synchronous | Synchronous (unchanged) |
