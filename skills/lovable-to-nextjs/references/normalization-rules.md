# Vibe Coding Normalization Rules

Seven categories of normalization rules. Each rule follows the format: **Problem | Rule | Action | Detection Command**.

---

## 1. Color Normalization

### Rule 1.1: Extract Repeated Hardcoded Colors

| Field | Value |
|-------|-------|
| **Problem** | Hardcoded hex colors scattered across components make theme changes impossible |
| **Rule** | Any hex/hsl/rgb color value appearing ≥3 times across the project must be extracted to a CSS custom property |
| **Action** | Add `--color-<name>: <value>` to `globals.css` `:root` block; replace all instances with `var(--color-<name>)` |
| **Detection** | `rg "#[0-9a-fA-F]{3,8}" --type tsx -c \| sort -rn \| awk "\$1 >= 3"` or `rg "hsl\(" --type tsx -c \| sort -rn` |

### Rule 1.2: Semantic Color Tokens

| Field | Value |
|-------|-------|
| **Problem** | Direct color usage in component files lacks semantic meaning |
| **Rule** | Colors used in UI contexts must use semantic tokens: `--color-primary`, `--color-secondary`, `--color-accent`, `--color-muted`, `--color-destructive`, `--color-background`, `--color-foreground`, `--color-border` |
| **Action** | Map extracted hex values to semantic tokens; update Tailwind config to reference CSS variables |
| **Detection** | `rg "bg-\[#|text-\[#|border-\[#" --type tsx` |

### Rule 1.3: Tailwind Config Alignment

| Field | Value |
|-------|-------|
| **Problem** | Tailwind config defines colors that duplicate CSS variables |
| **Rule** | Tailwind `colors` config must reference CSS custom properties, never raw hex |
| **Action** | Replace `primary: "#6366f1"` with `primary: "hsl(var(--primary))"` in Tailwind config |
| **Detection** | `rg '"#[0-9a-fA-F]{6}"' tailwind.config.ts` |

---

## 2. Component Normalization

### Rule 2.1: Maximum Component Size

| Field | Value |
|-------|-------|
| **Problem** | Oversized components are hard to read, test, and reuse |
| **Rule** | Components >300 lines must be split into smaller sub-components |
| **Action** | Extract logical sections into named sub-components in the same file, then consider moving to separate files |
| **Detection** | `Get-ChildItem -Recurse -Filter *.tsx \| Where-Object { (Get-Content $_.FullName).Count -gt 300 }` |

### Rule 2.2: Mandatory Sub-directory for Large Components

| Field | Value |
|-------|-------|
| **Problem** | Components >500 lines need supporting files (sub-components, hooks, utils) |
| **Rule** | Components >500 lines must be reorganized into a sub-directory with an index file |
| **Action** | Create `ComponentName/index.tsx`, `ComponentName/SubPart.tsx`, `ComponentName/useComponentLogic.ts`, etc. |
| **Detection** | `Get-ChildItem -Recurse -Filter *.tsx \| Where-Object { (Get-Content $_.FullName).Count -gt 500 }` |

### Rule 2.3: No Inline Styles

| Field | Value |
|-------|-------|
| **Problem** | `style={{ }}` props bypass the design system and are hard to override |
| **Rule** | All inline `style` attributes must be removed and replaced with Tailwind classes or CSS custom properties |
| **Action** | Convert `style={{ color: "#fff" }}` to `className="text-white"` or `className="text-[var(--color-foreground)]"` |
| **Detection** | `rg "style={{" --type tsx` |

### Rule 2.4: Flat Directory Reorganization

| Field | Value |
|-------|-------|
| **Problem** | A flat `components/` folder with 20+ files is unmaintainable |
| **Rule** | Components must be organized into categorized sub-directories (see Directory Normalization) |
| **Action** | Move files into `ui/`, `layout/`, `sections/`, `shared/` sub-directories |
| **Detection** | `(Get-ChildItem src\components -Filter *.tsx).Count -gt 20` |

---

## 3. Type Normalization

### Rule 3.1: No `any` Types

| Field | Value |
|-------|-------|
| **Problem** | `: any` disables type safety and hides bugs |
| **Rule** | All `: any` annotations must be replaced with proper types |
| **Action** | Replace with specific interfaces, `unknown` + type guards, or generic constraints |
| **Detection** | `rg ": any" --type tsx --type ts` |

### Rule 3.2: Props Must Have Interfaces

| Field | Value |
|-------|-------|
| **Problem** | Inline prop types in function signatures are hard to reuse and document |
| **Rule** | Every component accepting props must define a named `interface` or `type` above the component |
| **Action** | Extract `function Card({ title, description }: { title: string; description: string })` into `interface CardProps { title: string; description: string }` |
| **Detection** | `rg "function \w+\(\{.*\}: \{" --type tsx` (inline destructured typed props) |

### Rule 3.3: Data Functions Must Have Return Types

| Field | Value |
|-------|-------|
| **Problem** | API fetchers and data transformers without return types propagate `any` |
| **Rule** | Every `async function` that fetches or transforms data must declare a return type |
| **Action** | Add `: Promise<DataType>` or `: DataType` return annotations |
| **Detection** | `rg "async function" --type ts --type tsx | Where-Object { $_ -notmatch ": Promise" }` |

---

## 4. Directory Normalization

### Standard Directory Structure

```
src/
  components/
    ui/           # shadcn/ui primitives: Button, Card, Dialog, Input, etc.
    layout/       # Navigation, Footer, Layout, Sidebar, Header
    sections/     # Page-level composable sections: Hero, FeatureGrid, PricingTable, FAQ, CTA, Testimonials
    shared/       # Cross-cutting reusable: Logo, SocialLinks, ThemeToggle, Breadcrumbs
  data/           # Static data files: navigation.ts, pricing.ts, features.ts, faq.ts
  types/          # Shared TypeScript interfaces: index.ts, api.ts, models.ts
  hooks/          # Custom React hooks: useMediaQuery, useScrollPosition
  lib/            # Utility functions: utils.ts, cn(), formatters, validators
  app/            # Next.js App Router pages and layouts
```

### Rule 4.1: shadcn/ui Isolation

| Field | Value |
|-------|-------|
| **Problem** | shadcn components mixed with business components cause confusion during updates |
| **Rule** | All shadcn/ui components must live in `components/ui/` and never be modified beyond theming |
| **Action** | Move any shadcn component found outside `ui/` into `ui/`; business wrappers go in `shared/` or `sections/` |
| **Detection** | `rg "from \"@radix-ui" src\components\ -l | Where-Object { $_ -notmatch "ui[/\\]" }` |

### Rule 4.2: Section Components

| Field | Value |
|-------|-------|
| **Problem** | Page-level sections (Hero, Features, Pricing) mixed with atomic components |
| **Rule** | Components that represent a full page section must live in `components/sections/` |
| **Action** | Identify components rendered directly inside page files as top-level blocks; move to `sections/` |
| **Detection** | `rg "import.*Hero|import.*Feature|import.*Pricing|import.*FAQ|import.*CTA|import.*Testimonial" --type tsx -l` |

### Rule 4.3: Static Data Extraction

| Field | Value |
|-------|-------|
| **Problem** | Large data arrays inline in components bloat bundle size and reduce readability |
| **Rule** | Data arrays >20 entries or >50 lines must be extracted to `data/` directory |
| **Action** | Move to `data/features.ts`, `data/pricing.ts`, etc.; import from component |
| **Detection** | `rg "const \w+ = \[" --type tsx -A 5 | Where-Object { (rg -c).Count -gt 50 }` |

---

## 5. SEO Normalization

### Rule 5.1: Page Title & Description

| Field | Value |
|-------|-------|
| **Problem** | Pages without `<title>` or meta description are invisible to search engines |
| **Rule** | Every page must export `metadata` with at minimum `title` and `description` |
| **Action** | Add `export const metadata: Metadata = { title: "...", description: "..." }` to each page |
| **Detection** | `Get-ChildItem app -Recurse -Filter page.tsx | ForEach-Object { $c = Get-Content $_.FullName -Raw; if ($c -notmatch "export const metadata|export default function generateMetadata") { Write-Output $_.FullName } }` |

### Rule 5.2: Open Graph Tags

| Field | Value |
|-------|-------|
| **Problem** | Missing OG tags result in poor social media previews |
| **Rule** | Every page must include `openGraph` in metadata with `title`, `description`, `images`, `url` |
| **Action** | Add `openGraph: { title, description, images: ["/og.png"], url }` to each page's metadata |
| **Detection** | `rg "openGraph" app\ -l --type tsx --type ts | Compare-object (Get-ChildItem app -Recurse -Filter page.tsx) -PassThru` |

### Rule 5.3: Canonical URL

| Field | Value |
|-------|-------|
| **Problem** | Duplicate content across domains damages SEO ranking |
| **Rule** | Every page must specify `alternates.canonical` in metadata |
| **Action** | Add `alternates: { canonical: \`https://domain.com${pathname}\` }` |
| **Detection** | `rg "canonical" app\ --type tsx --type ts -l` |

### Rule 5.4: JSON-LD Structured Data

| Field | Value |
|-------|-------|
| **Problem** | Missing structured data loses rich search result eligibility |
| **Rule** | Enterprise/product pages need `Organization` or `Product` schema; FAQ sections need `FAQPage`; deep pages need `BreadcrumbList` |
| **Action** | Add `<script type="application/ld+json">` with appropriate schema; see `seo-templates.md` |
| **Detection** | `rg "application/ld\+json" app\ -l` |

### Rule 5.5: Semantic HTML

| Field | Value |
|-------|-------|
| **Problem** | All-`<div>` markup is inaccessible and hurts SEO |
| **Rule** | Use `<nav>`, `<main>`, `<footer>`, `<section>`, `<article>`, `<header>`, `<aside>` semantically |
| **Action** | Replace navigation `<div>` with `<nav>`, page content wrapper with `<main>`, etc. |
| **Detection** | `rg "<div" app\ --type tsx -c | sort -rn | Select-Object -First 10` |

---

## 6. CSS Normalization

### Rule 6.1: Extract Repeated Tailwind Class Combinations

| Field | Value |
|-------|-------|
| **Problem** | Identical 5+ class combinations repeated across components |
| **Rule** | Tailwind class strings repeated ≥3 times must be extracted to `@utility` or a shared component |
| **Action** | Add `@utility btn-primary { @apply bg-primary text-primary-foreground px-4 py-2 rounded-md; }` in globals.css, or create a wrapper component |
| **Detection** | Manual review or: `rg "className=\"[^\"]{50,}" --type tsx -o | sort | uniq -c | sort -rn | awk "$1 >= 3"` |

### Rule 6.2: Arbitrary Value Tokenization

| Field | Value |
|-------|-------|
| **Problem** | `text-[#1a1a2e]` or `p-[23px]` arbitrary values scattered across files |
| **Rule** | Arbitrary values repeated ≥3 times must become CSS tokens or Tailwind config extensions |
| **Action** | Add to Tailwind config: `fontSize: { brand: "var(--font-size-brand)" }` or add CSS custom property |
| **Detection** | `rg "\[[0-9]+px\]|\[#[0-9a-fA-F]+\]" --type tsx -o | sort | uniq -c | sort -rn | awk "$1 >= 3"` |

### Rule 6.3: Unused CSS Cleanup

| Field | Value |
|-------|-------|
| **Problem** | Migrated projects carry dead CSS from Lovable |
| **Rule** | All unused CSS classes and import-only stylesheets must be removed |
| **Action** | Run PurgeCSS or manual audit; remove empty CSS files |
| **Detection** | `npx purgecss --css src/**/*.css --content src/**/*.tsx --out removed-report` |

### Rule 6.4: @apply Guidance

| Field | Value |
|-------|-------|
| **Problem** | Overuse of `@apply` creates hidden dependencies and reduces Tailwind's utility |
| **Rule** | `@apply` is acceptable only in `globals.css` `@utility` definitions; never inside component-level CSS modules or `<style>` blocks |
| **Action** | Move `@apply` usage to `globals.css` `@utility` or replace with className composition |
| **Detection** | `rg "@apply" src\ --type css` |

---

## 7. Performance Normalization

### Rule 7.1: Image Requirements

| Field | Value |
|-------|-------|
| **Problem** | Images without dimensions cause CLS; missing alt text fails accessibility |
| **Rule** | Every `<img>` or `<Image>` must have `width`, `height`, `loading`, and `alt` attributes |
| **Action** | Add missing attributes; for `next/image`, `width`/`height` are required for static imports |
| **Detection** | `rg "<img" --type tsx -l | ForEach-Object { rg "<img(?![^>]*(width|height|alt))" $_ }` |

### Rule 7.2: Hero Image Priority

| Field | Value |
|-------|-------|
| **Problem** | Hero/LCP images loading lazily increase LCP time |
| **Rule** | Hero images (above the fold, LCP candidate) must have `fetchpriority="high"` (or `priority` prop on `next/image`) |
| **Action** | Add `priority` to `next/image` for hero images; add `fetchpriority="high"` to `<img>` |
| **Detection** | `rg "className.*hero|className.*banner|id.*hero" --type tsx -l` then check images in those components |

### Rule 7.3: Lazy Loading Non-Hero

| Field | Value |
|-------|-------|
| **Problem** | Below-fold images loaded eagerly waste bandwidth |
| **Rule** | All non-hero images must have `loading="lazy"` (default in `next/image`; explicit for `<img>`) |
| **Action** | Add `loading="lazy"` to `<img>` elements below the fold |
| **Detection** | `rg "<img" --type tsx | Where-Object { $_ -notmatch "loading=" -and $_ -notmatch "priority" }` |

### Rule 7.4: Font Display

| Field | Value |
|-------|-------|
| **Problem** | Custom fonts causing FOIT (Flash of Invisible Text) |
| **Rule** | All font declarations must use `font-display: swap` |
| **Action** | In `next/font/google` or `next/font/local`, always set `display: "swap"` |
| **Detection** | `rg "next/font" --type tsx --type ts | Where-Object { $_ -notmatch "display" }` |
