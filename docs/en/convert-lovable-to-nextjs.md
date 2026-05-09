# Convert Lovable to Next.js: Migration & SEO Guide

**[简体中文](../zh/迁移Lovable至Nextjs.md)**

This guide **curates public materials and search findings**; it is not procurement or legal advice. Capabilities and UIs follow **current Lovable / Next.js / hosting** documentation.

**Scope:** Web apps produced from [Lovable](https://lovable.dev/)—by default **React + Vite + TypeScript + Tailwind + shadcn/ui**, **not** Next.js out of the box.

---

## How to read this guide

| Reader | Suggested order |
|--------|-----------------|
| **Making a call** (stay on Lovable / prerender / move to Next) | **Section 1** → Section 4 (comparison) → Section 5 (paths) |
| **Already moving to Next**—Git & production | Section 3 (export) → **Section 6 (dual repos + Vercel)** → Section 7 (backend & QA) |
| **Non‑engineers**: why Lovable, how handoff works | Section 2 |

**Definitions:** **Repo A** = the **React+Vite** Git repo bound to Lovable. **Repo B** = standalone **Next.js** repo (e.g. `project-nextjs`).

---

## 1. Fast decisions

| Primary goal | Recommended path | Details |
|--------------|------------------|---------|
| **Ship demos quickly**, iterate on copy & interaction **inside Lovable** | Stay on Lovable (**Vite SPA default**) | §2 (platform strengths) + §3 (export & GitHub sync) |
| **Search/social bots need readable HTML**, no framework switch yet | **Prerender/DNS‑style SaaS or self-hosted**—evaluate vendors yourself | §5.1 |
| **Strong SEO conventions**, hybrid rendering, deep Vercel-style pipelines | **Migrate to Next.js** (technical paths §5.2) | §§4–6 |
| **Must align with mono-main site + shared CI/CD** (Next/Nuxt etc.) | Let **canonical stack decide**—React favors Next; Vue often needs **rewrite or isolation** | End of §4 |
| **Internal tooling, minimal public SEO risk** | Keep Lovable SPA, maintain sane routing/meta habits | — |

---

## 2. Lovable: positioning & audiences

**Why teams pick it:**

- **Chat + multi-file agent edits**: idea → clickable prototype fast for **PMF pages, landing shells, small full‑stack POCs**.
- **Default Tailwind + shadcn/ui + Radix**: consistent UI outputs; patterns reduce generic “AI slop” feel.
- **Visual Edits (official):** tweak DOM/Tailwind classes in preview with **two‑way sync** to source—great for **design/PM refinement** without deep local setup. (Links §8)

**How non‑engineers bridge to prod:** Design/content/growth often ship **without local toolchains**; merging into **same domain + design system + release train** triggers **framework moves or rewrites**—see **§4 motivation** & **§6 dual-repo model**.

---

## 3. Facts: official stack, Next support, export

Align on **default delivery** before debating migration:

| Question | Public Lovable answer |
|----------|------------------------|
| **Default frontend** | React + Vite + TypeScript + Tailwind + shadcn/ui + Radix (FAQ) |
| **Default Next?** | **No** |
| **When Next is needed** | (1) **export then migrate**; (2) ask for Next in chat—**may** work **per project** |

**GitHub sync:**

| Item | Notes |
|------|------|
| **Sync** | Connect GitHub; **secrets stay out of repo**, configure locally/CI yourself |
| **Code ownership** | Production React/TS belongs to user (see Code Export FAQ) |

**Links:** [Next.js support FAQ](https://lovable.dev/faq/capabilities/tech-stack/lovable-nextjs-support) · [Tech stack](https://lovable.dev/faq/capabilities/tech-stack) · [Code export](https://lovable.dev/faq/code-export/export-project-code)

---

## 4. Why migrate to Next.js?

Lovable still yields a **maintainable React codebase**; **Next.js** adds a **full-stack React framework** (App Router emphasis). The move is rarely “replace React”—it’s adopting **ops & publishing patterns** common for public sites while staying in the **same mental model**.

### 4.1 Technical comparison (typical Vite SPA vs Next)

| Dimension | Lovable default (Vite, CSR-heavy) | Next (App Router) upside |
|-----------|-----------------------------------|---------------------------|
| **SEO / share cards** | First response often **thin HTML + bundle**; main content after JS | Per-route **SSR/SSG/ISR**; **Metadata API** for title, canonical, OG |
| **First paint & data** | Client-side **waterfalls** (`useEffect` fetch chains) | Fetch on **server/build**; `next/image`, `next/font` optimizations |
| **Production engineering** | DIY prerender/CDN/header glue | **Unified builds, routing idioms, ISR, middleware, route-level loading/error** |
| **Collaboration** | SPA mindset | **Server vs Client Components**, `app/` filesystem routes, nested layouts |

**Official deep dive:** SPA→Next semantics start with [Migrating from Create React App](https://nextjs.org/docs/app/guides/migrating/from-create-react-app); App Router hub: [Next.js App docs](https://nextjs.org/docs/app).

### 4.2 Org/process drivers (not only SEO)

Most migrations respond to **escaping the “island prototype repo”** for **mainline product pipelines**.

| Need | Meaning |
|------|---------|
| **Monorepo / design system** | Shared tokens/components—avoid dual themes |
| **Shared code review / previews** | Non-dev pages must become **reviewable PRs** |
| **Main site already React + Next** | **React+Vite → Next** is same ecosystem |
| **Main site Vue+Nuxt / other** | **No magic merge**—expect **rewrite, iframe/micro-frontend, or subdomain** |

**Verdict:** Migrating to Next is a **product + SEO + org pipeline** decision—not framework hype.

---

## 5. Paths: prerender vs three Next strategies

### 5.1 Stay on framework: prerender/DNS (middle ground)

**When:** You need **crawler-readable HTML** first, **no repo split yet**. Pattern: serve **rendered HTML** to crawlers / low-JS clients; real users keep SPA. **Not a Lovable-native feature**—evaluate vendors, ToS, bot handling, SLA. §8 **excludes** commercial prerender links.

### 5.2 Routes A–C (framework change decided)

| Route | What to do | Caveats |
|-------|------------|---------|
| **A** | Demand **Next.js + App Router** inside Lovable chat | May fight model strengths (Vite + RR); **verify build & routing** |
| **B** | Third-party **CLI/hosted migrators** (commercial) | **Not** official Lovable/Vercel—due diligence on security/billing; §8 **omits** links |
| **C** | **Manual migration** (team or Cursor-class agents) | Highest control; mapping table below |

**Manual migration (C) cheat sheet:**

| Area | Direction |
|------|-----------|
| Routing | React Router → `app/` **filesystem routes** |
| Navigation | `next/link`, `useRouter`, `usePathname` |
| RSC | Browser APIs/hooks inside **`"use client"`** islands |
| Data | `useEffect` chains → Server Components / Route Handlers / client caches |
| Env vars | `VITE_*` → `NEXT_PUBLIC_*` / server-only names |
| Build | `vite.config` → `next.config`; align `public/` conventions |

API details live in §8 links ([CRA→Next](https://nextjs.org/docs/app/guides/migrating/from-create-react-app), [Layouts & Pages](https://nextjs.org/docs/app/getting-started/layouts-and-pages)).

---

## 6. Playbook: dual-repo Git · local agents · Vercel

**Assumes** you picked **A–C** in §5 and need a **local Next repo** (usually **manual C**). Goal: **don’t brick Repo A** while Lovable stays usable.

### 6.1 Why dual repos

| Principle | Explanation |
|-----------|-------------|
| **Don’t rewrite Lovable’s remote** | Force-pushing / diverging default branch can **desync platform vs GitHub** or break **Visual Edits** |
| **Repo B owns Next** | e.g. `project-nextjs`—same product intent, different architecture |
| **Single repo later** | If Lovable write-back no longer matters, consider **one repo / multiple remotes**—guide still models **two repos** |

### 6.2 Steps (in order)

1. **In Lovable:** ship project + **connect GitHub** → **Repo A** (matches §3 export FAQ). Configure non-secret runtime env in your environments only.
2. **Locally:** `git clone` **Repo A** → confirm **Vite runs**. Don’t poison Lovable’s default branch with Next-only work—use **feature branches** or **separate working trees** before cutting Next.
3. Follow §5 until `next build` passes; **agents** can batch route/`"use client"` refactors—**humans** sign off critical flows vs design.
4. **Create empty GitHub Repo B** → from Next root: `git remote add origin <RepoB>` (or `git remote rename origin lovable` then add new `origin`). **Push only Repo B.** **Never** `git push --force` Lovable-bound Repo A by mistake.
5. **Vercel:** import **Repo B**, framework **Next.js**, env/branch policy per team. ([Deploying](https://nextjs.org/docs/app/getting-started/deploying))

### 6.3 Long-term Lovable ⇄ Next alignment (manual)

- **Product contract:** who owns route/copy changes to avoid perpetual drift.
- **Engineering:** periodic diffs on **route maps & hero pages**; small fixes via cherry-pick or hand port. **No official “dual build same source”.**
- **Converge:** when Lovable editing ends, promote **Repo B** to source of truth or fold into company monorepo.

---

## 7. Backend, env vars, launch QA

### 7.1 Backend bindings (Lovable Cloud / Supabase)

Swapping frontend repos **does not move** databases, auth users, storage, edge functions. Typical work: confirm **same Supabase project** (or migration plan) → refresh **client env** (URL, anon key) → run **migrations** → migrate data/files → extend **OAuth / magic link redirect URLs** for production Next + Vercel preview domains.

### 7.2 Checklist (Next + dual repo launch)

**Config**

- [ ] Split `NEXT_PUBLIC_*` vs **server-only** secrets; nothing sensitive in git  
- [ ] Supabase / third-party auth **redirect & site URLs** cover prod + previews  
- [ ] CORS (if custom API) whitelists new frontends  

**Frontend & SEO**

- [ ] `pnpm build` / `npm run build` clean; no prod-only async errors  
- [ ] Critical flows validated **against new routes** vs old SPA  
- [ ] Route-level **metadata** (title, description, canonical, OG) spot-check  
- [ ] Remote patterns for `next/image`, fonts, layout CLS sanity pass  

**Collaboration**

- [ ] Team knows **Repo A remains Lovable source of truth** (if platform still used); don’t push Next-only overhauls there

---

## 8. References (official URLs only)

This table lists **Lovable** and **Next.js (Vercel docs)** exclusively—no third-party tutorials, paid migrators, or prerender vendors.

| Topic | URL |
|------|-----|
| Lovable tech stack FAQ | https://lovable.dev/faq/capabilities/tech-stack |
| Lovable Next.js support | https://lovable.dev/faq/capabilities/tech-stack/lovable-nextjs-support |
| Lovable code export | https://lovable.dev/faq/code-export/export-project-code |
| Lovable blog — Visual Edits intro | https://lovable.dev/blog/introducing-visual-edits |
| Lovable blog — Visual Edits deep dive | https://lovable.dev/blog/visual-edits |
| Lovable docs — Visual edits | https://docs.lovable.dev/features/design |
| Next.js App Router | https://nextjs.org/docs/app |
| Layouts & Pages | https://nextjs.org/docs/app/getting-started/layouts-and-pages |
| Server & Client Components | https://nextjs.org/docs/app/getting-started/server-and-client-components |
| Metadata & OG | https://nextjs.org/docs/app/getting-started/metadata-and-og-images |
| Image | https://nextjs.org/docs/app/getting-started/images |
| Font | https://nextjs.org/docs/app/getting-started/fonts |
| Migrate from CRA | https://nextjs.org/docs/app/guides/migrating/from-create-react-app |
| Deploying | https://nextjs.org/docs/app/getting-started/deploying |

---

**Cross-link:** platform comparison & default stack matrix—[`vibe-coding-product-frontend-stack.md`](./vibe-coding-product-frontend-stack.md).
