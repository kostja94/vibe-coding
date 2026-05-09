# Vibe Coding: Product Frontend Stack Reference (Websites & Web Apps)

**[简体中文](../zh/Vibe-Coding产品前端技术栈.md)**

This guide **only covers building websites and web products accessed in a browser** (including SSG, SPA, SSR, and web PWAs). It **does not cover** native mobile apps (iOS/Android), mini programs (WeChat, Douyin, etc.), React Native / Expo mobile shells; if a product’s positioning focuses on those, it is **moved out of the main tables** or **labeled out of scope**.

This document **curates public materials and vendor documentation**. Default templates and recommended stacks change; before you ship, follow each product’s **current docs** and the generated **`package.json`**.

**Last curated:** 2026-05-01; **scope revision:** 2026-05-01 (narrowed to web)

**Next steps:** If you've already picked Lovable and need SSR / SEO, the companion guide covers the full migration path: [Convert Lovable to Next.js](./convert-lovable-to-nextjs.md).

---

## At-a-glance (web frontend focus)

Tables below list paths that deliver **something that runs in a browser** or can be exported as **web projects**. We distinguish **standard web/exportable repos** vs **hosted / closed repos with no disclosed default frontend**.

### A. Global: conversational / agent → browser product (or exportable web repos)

| Product | Typical / default frontend stack | Stack “fixed”? |
|---------|-----------------------------------|----------------|
| **Lovable** | React + TypeScript + **Vite** + Tailwind + **shadcn/ui** + Radix UI; routing often **React Router** | **Mostly fixed** (official FAQ) |
| **v0** (Vercel) | **Next.js** (App Router) + React + Tailwind + **shadcn/ui** | **Next by default** (full-stack docs) |
| **Replit Agent** | Often **React + Vite (+ Tailwind / shadcn)** for **web** | **Not fixed** (officially: any framework; for websites only you should pin Next/Vite SPA in prompts) |
| **Bolt.new** | **Chosen per prompt**; supports **Vite / Next.js / Astro** etc. runnable on StackBlitz; starters often **React + Vite** | **Varies by project** |
| **MeDo** | Articles & site examples: **React + Vite + Tailwind** (incl. v4 notes) | **Verify on export** |
| **Base44** | **React + React Router + Vite + Tailwind + shadcn/ui** | **Documented as fixed** |
| **Atoms** | Messaging emphasizes full‑stack delivery; integrations often **Supabase / Stripe / GitHub export**; **default web scaffold not enumerated on site** | **Check exported repo** |
| **Trickle** | Official blog: **React + Tailwind CSS** used “behind the scenes” (user-facing wording) | **Somewhat fixed pairing** |
| **Tempo Labs** | YC profile: **React**, **optimized for Vite and Tailwind**; SaaS template docs include **Next.js + Supabase** etc. | **React core**; templates may use Next |
| **Create.xyz** | Circulating system‑prompt excerpts require **React + Tailwind** components (platform-internal assembly) | **Generation favors React/Tailwind** |
| **Firebase Studio** (App Prototyping agent) | Docs: prototype & ship **Next.js** web apps (Firebase App Hosting) | **Next for agent path** |
| **Firebase Studio** (templates) | **Web only:** templates include **React, Next.js, Vue, Angular, Svelte, Astro** etc. (mobile templates exist elsewhere, not expanded here) | **Depends on template** |
| **Framer** (sites) | Product is **React**-based visual site building; AI assists within Framer/React runtime | **Framer/React** |

### B. China / regional (web, H5, cloud-hosted websites)

| Product | Stack / public info (web framing) | Notes |
|---------|-----------------------------------|-------|
| **MIAODA (Baidu)** | **Public per-stack specs for generic “sites / H5” are unclear** in official materials; third parties often pitch zero/low-code loops | Messaging **also includes mini programs**; **this doc only files “browser-rendered pages produced on the platform”**; **do not equate** overseas MeDo’s React+Vite story |
| **Tencent CloudBase AI Toolkit / MCP** | Official MCP/docs: web apps integrating **React, Vue, Next.js**; tutorials often demo **React + cloud functions** | Cloud suite **supports mini programs**; **here we only cite web engineering bits** |

### C. Design / site-builder angle (prototype & deliverables, not identical to full‑stack agent builders)

These tools are widely used for “app screen” mocks; **this article only cares about technology described when outputs land as browser sites / web exports**.

| Product | Typical coded deliverable | Notes |
|---------|---------------------------|-------|
| **Google Stitch** (Galileo-style path) | Third-party summaries often cite **HTML/CSS + Tailwind**, Figma export; full React project depends on **current Stitch export** | **UI kickoff + export**, unlike Lovable’s “full GitHub repo” path |
| **Uizard** | **Visual screens** first, then manual/plugin handoff to design & code | Strong at **UI sketching**, weaker at “one backend box” |
| **Webflow AI / Framer AI** | Each ecosystem’s runtime (Framer:**React** stack); Webflow: **CMS + HTML/CSS export rules** are complex | **Strong site/CMS/motion**, not the same archetype as “one prompt generates Supabase CRUD” |
| **Magic Patterns, Relume Sites, Banani**, etc. | Reviews describe **React + TypeScript + Tailwind**‑style exports (verify Export copy on vendor sites) | Differentiated from hosted full‑stack builders in main tables |

### D. Out of scope (not the browser‑website storyline)

Listed because public narratives emphasize **mobile on-device**, **mini program hosts**, or **hybrid-first** delivery—they **fail the “websites/web apps in browsers only” criterion** here:

| Name | Brief reason |
|------|--------------|
| **Alibaba “灵光” Flash App** | Media describes **running on-phone** emphasis; focus is **not** “export repo you host anywhere on the web” ([NetEase excerpt](https://www.163.com/dy/article/KQV7RV41051180F7.html)) |
| **Pure mini-program or “mini program first” stacks** | Runtime is WeChat et al.—not comparable to standalone browser sites |

For RN / mini programs / hybrid playbooks, add a dedicated doc—don’t mash them into the web‑only matrices.

---

## Per-product notes

### Lovable

- **Frontend:** React, TypeScript, **Vite**, Tailwind, **shadcn/ui**, Radix UI.
- **Routing:** Often React Router (open boilerplates + vendor descriptions align).
- **Backend/data:** Frequently pairs with Supabase etc. (full‑stack territory, beyond pure frontend).

**Sources:** [Lovable FAQ — What tech stacks does Lovable know?](https://lovable.dev/faq/capabilities/tech-stack/lovable-tech-stack)

**Further reading (migrate / SEO / dual repos):** see [`convert-lovable-to-nextjs.md`](./convert-lovable-to-nextjs.md).

---

### v0 (Vercel)

- **Default:** Next.js (App Router, RSC-capable stack).
- **UI:** Typical output is React + Tailwind **+ shadcn/ui**.
- **Notes:** Vendor docs stress **Next.js default for full-stack apps**; you can request alternatives, **Next tends to work best**.

**Sources:**  
- [v0 Docs — Full-stack apps](https://v0.dev/docs/full-stack-apps)  
- [Vercel Blog — How v0 is building SEO-optimized sites by default](https://vercel.com/blog/how-v0-is-building-seo-optimized-sites-by-default)

---

### Replit (Agent / Build)

- **Web framing:** Agents can scaffold **sites in arbitrary frameworks**, but publicly visible demos skew **React + Vite (+ Tailwind / shadcn)**. Name **SPA, Next**, or **static-only** upfront to steer away from non-web tooling.
- **Scope:** Vendor also advertises mobile paths—**ignored here**.

**Sources:**  
- [Replit — Agent on any framework](https://blog.replit.com/agent-on-any-framework)  
- [Replit — 2025 in Review](https://blog.replit.com/2025-replit-in-review)

---

### Bolt.new (StackBlitz WebContainers)

- **Positioning:** Browser-based Node/npm + AI orchestration; install deps / pick scaffold in chat.
- **Frontend:** **No single mandated stack**; FAQ says mainstream JS stacks that run on StackBlitz generally apply. Docs/readme cite **Vite, Next.js**, etc.
- **Common starters:** Community templates such as **React + Vite** (`bolt-vite-react`).

**Sources:**  
- [stackblitz/bolt.new README](https://github.com/stackblitz/bolt.new/blob/main/README.md)  
- [Bolt.new — Vite React starter](https://bolt.new/~/bolt-vite-react)

---

### MeDo

- **Public stance (web):** Builder writeups on DEV describe **React + Vite + Tailwind** web projects hosted/iterated on platform; site examples include the same combo. Other hosting shapes **not expanded here**.
- **Caveat:** Backend/plugins follow platform backend; **browser side** is whatever you export/preview.

**Sources:**  
- [DEV — MeDo hackathon log](https://dev.to/vineetnegi0101/i-built-a-60-second-reflection-app-that-paints-you-a-watercolor-keepsake-day-2-of-the-50k-medo-5065)  
- [MeDo marketing examples](https://medo.dev/)

---

### Base44 (documentation shape similar to Lovable)

- **Frontend (official docs):** **React + React Router + Vite + Tailwind + shadcn/ui**.  
**Source:** [Base44 — App Code Introduction](https://docs.base44.com/developers/app-code/overview/introduction)

---

### Trickle (trickle.so)

- **Public wording:** Blog *Why Vibe Coding Works* states *“Trickle uses **Tailwind CSS and React** behind the scenes”*; users describe needs in natural language.
- **Positioning:** All-in-one hosting, sites, forms/data, built-in AI—different from “export everything to GitHub” tools.

**Source:** [Trickle — Why Vibe Coding Works](https://trickle.so/blog/why-vibe-coding-works-a-guide-for-developers)

---

### Atoms (atoms.dev)

- **Browser side:** Use cases describe **usable websites & web apps** with Supabase, export, hosting; framework/bundler **comes from exported `package.json`**.
- **Disambiguation:** Not “Atomic.io” or other Atomic brands.

**Sources:**  
- [Atoms — App & website builder](https://atoms.dev/usecases/app-and-website-builder)

---

### Tempo Labs (tempo.new)

- **Core web stack:** YC profile describes a **React** visual editor **optimized for Vite and Tailwind**; Mintlify docs show **Next.js + Supabase + Polar** guides. **Same brand also advertises Expo—out of scope here.**

**Sources:**  
- [Y Combinator — Tempo company page](https://www.ycombinator.com/companies/tempo-2)  
- [Tempo docs — Next.js + Supabase + Polar](https://tempolabsinc.mintlify.app/Next.jsSupabasePolar)

---

### Create.xyz

- **Generation constraints:** Circulating prompt snippets require **React + Tailwind** function components with hooks (third-party leak; may change).

**Source:** [Create.xyz — shared generation rules excerpt](https://create.xyz/share/d51a6165-642a-4f30-a614-2a1ddf91ab74)

---

### Google Firebase Studio

- **App Prototyping agent:** Docs say it **generates and ships Next.js** web apps (other frameworks flagged planned).
- **General template studio (web subset):** **React, Next.js, Vue, Angular, Svelte, Astro** etc.; Android/Flutter templates **not enumerated here**.

**Sources:**  
- [Firebase — App Prototyping agent](https://firebase.google.com/docs/studio/get-started-ai)  
- [Firebase Studio templates](https://firebase.google.com/docs/studio/get-started-template)

---

### Tencent CloudBase AI Toolkit / MCP

- **Web:** Docs cite **React, Vue, Next.js** integrations; console/tutorials often demo **React + cloud functions**.

**Sources:**  
- [CloudBase AI toolkit](https://docs.cloudbase.net/ai/cloudbase-ai-toolkit)  
- [Dev guide — web apps](https://docs.cloudbase.net/ai/cloudbase-ai-toolkit/development)

---

### Baidu MIAODA

- **This doc:** Only **browser‑reachable marketing/H5/site-style deliveries**; mini program hosts **not detailed row-by-row**.
- **Third-party gist:** Dialogue + GUI, multi‑agent narratives, hosted on Baidu Intelligent Cloud.
- **Source transparency:** Frequently described as **no or weak full source downloads** vs GitHub‑style repos.
- **Web stack specifics:** No unified vendor whitepaper found—**do not apply** overseas MeDo React+Vite assumptions.

**Source (aggregator, non-authoritative):** [MIAODA landing copy](https://www.2090ai.com/miaoda)

---

## Extension: Same class, stack depends **on your repo** (still “web” relevant)

Agents **below don’t dictate** a canonical SPA scaffold for everyone—they mutate whatever **Next/Vite SPA/Astro repo** you open. **Listed** because they’re common **for iterating owned web repos**.

- **GitHub Spark, Copilot Workspace, Cursor, Windsurf**, etc.—IDE/agent + **your web repo**.
- **Vercel deploy** aligns with delivering **sites** but is orthogonal to **how each builder authors its own SaaS**.

---

## Usage tips

1. **Treat generated code as truth:** read `package.json`, `vite.config.*`, `next.config.*`.
2. **Bolt / Replit‑style shells:** bullet your stack in prompt one (e.g. “Next 14 App Router + TS + Tailwind + shadcn”) to reduce random mixing.
3. **SSR / SEO-heavy sites:** prioritize **Next.js** (aligned with v0, Vercel, Firebase Studio prototyping). **SPA / admin dashboards** skew **React + Vite**.
4. **China-hosted “app factory” narratives:** verify **whether you can export a portable web codebase** vs “finished H5/shared link”—many narratives emphasize packaged apps rather than repo handoff.
5. **Black‑box disclosures:** Never assume overseas sibling stacks apply when the table explicitly says undisclosed.


## References (URLs, curated)

| Topic | Link |
|------|------|
| Lovable stack FAQ | https://lovable.dev/faq/capabilities/tech-stack/lovable-tech-stack |
| v0 full‑stack docs | https://v0.dev/docs/full-stack-apps |
| Replit — any framework | https://blog.replit.com/agent-on-any-framework |
| Bolt README | https://github.com/stackblitz/bolt.new/blob/main/README.md |
| MeDo builder log | https://dev.to/vineetnegi0101/i-built-a-60-second-reflection-app-that-paints-you-a-watercolor-keepsake-day-2-of-the-50k-medo-5065 |
| Base44 front-end stack | https://docs.base44.com/developers/app-code/overview/introduction |
| Trickle React + Tailwind | https://trickle.so/blog/why-vibe-coding-works-a-guide-for-developers |
| Atoms builder case | https://atoms.dev/usecases/app-and-website-builder |
| Tempo (YC) | https://www.ycombinator.com/companies/tempo-2 |
| Tempo Next + Supabase | https://tempolabsinc.mintlify.app/Next.jsSupabasePolar |
| Create.xyz prompt excerpt | https://create.xyz/share/d51a6165-642a-4f30-a614-2a1ddf91ab74 |
| Firebase prototyping | https://firebase.google.com/docs/studio/get-started-ai |
| Firebase templates | https://firebase.google.com/docs/studio/get-started-template |
| CloudBase AI toolkit | https://docs.cloudbase.net/ai/cloudbase-ai-toolkit |
| CloudBase dev guide | https://docs.cloudbase.net/ai/cloudbase-ai-toolkit/development |
| “灵光” article (§D scope note) | https://www.163.com/dy/article/KQV7RV41051180F7.html |
