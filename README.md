# Vibe Coding Resources: AI Builder Web Stacks & Lovable → Next.js

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/kostja94/vibe-coding?style=social)](https://github.com/kostja94/vibe-coding/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/kostja94/vibe-coding)](https://github.com/kostja94/vibe-coding/commits/main)

**What this repository is:** A **bilingual**, **maintainer-curated** reference for **vibe coding** and **AI app builders** that ship **browser-based websites and web apps**—default React / Vite / Next.js stacks by product, plus a structured guide to **export Lovable to Next.js**, **SEO**, and **dual-Git-repository** workflows. Sources are vendor docs and reputable public write-ups; your **exported `package.json`** is always the technical source of truth.

**By [@kostja94](https://github.com/kostja94)** · Bilingual **[简体中文](README.zh-CN.md)** · Pair with **[marketing-skills](https://github.com/kostja94/marketing-skills)** for agent-ready SEO playbooks · zyjstc@gmail.com

---

## Table of contents

- [Who this is for](#who-this-is-for)
- [What’s included](#whats-included)
- [Quick navigation](#quick-navigation)
- [FAQ](#faq)
- [Scope, limits, freshness](#scope-limits-freshness)
- [Related projects](#related-projects)

---

## Who this is for?

| If you… | Why open this repo |
|--------|--------------------|
| Choose or compare **Lovable**, **v0**, **Bolt**, **Replit Agent**, **Base44**, or similar builders | Want a **single table** of **declared vs export-time** stacks (React, Vite, Next.js, Tailwind, shadcn/ui, etc.). |
| Run **SSR / SEO / social previews** against a **Lovable-linked Vite SPA** | Need paths: **stay on SPA**, **prerender/CDN**, or **migrate to Next.js** plus **dual-repo** safety with **Vercel**. |
| Maintain **marketing or product sites** alongside **AI-generated codebases** | Want cross-links to reusable **technical SEO + page** guidance (below). |

---

## What’s included?

| Document | Topics |
|----------|--------|
| [Product frontend stack reference (EN)](docs/en/vibe-coding-product-frontend-stack.md) | International and regional builders, **browser-only scope**, citations to official FAQs and docs—**Next.js**, **React**, **Vite**, **Tailwind**, **Framer**, **Firebase Studio**, CloudBase AI, etc. |
| [Migrate Lovable to Next.js — migration & SEO (EN)](docs/en/convertlovabletonextjs.md) | **Repo A vs Repo B**, **App Router**, **Metadata API**, checklists, **official URL reference list** only. |
| Same two guides in **[中文](README.zh-CN.md)** | Mirrors under `docs/zh/` ([产品前端技术栈](docs/zh/Vibe-Coding产品前端技术栈.md), [迁移至 Next.js](docs/zh/迁移Lovable至Nextjs.md)). |

---

## Quick navigation

| Goal | English | 中文 |
|------|---------|------|
| **Stack comparison** across AI builders | [vibe-coding-product-frontend-stack.md](docs/en/vibe-coding-product-frontend-stack.md) | [Vibe-Coding产品前端技术栈.md](docs/zh/Vibe-Coding产品前端技术栈.md) |
| **Lovable → Next.js**, SEO & dual repo | [convertlovabletonextjs.md](docs/en/convertlovabletonextjs.md) | [迁移Lovable至Nextjs.md](docs/zh/迁移Lovable至Nextjs.md) |

---

## FAQ

### What is “vibe coding” in this repo?

Here it means **using conversational / agentic tools** to generate and iterate **web frontends** (and adjacent full-stack glue) aimed at products you open in a **browser**. This repo **does not** focus on native iOS/Android or mini-program-first stacks (those are labeled out-of-scope where relevant).

### Does this replace official documentation?

**No.** It **summarizes and links** authoritative sources. When a vendor silently changes starters, **`package.json` and configs win**—treat tables as orientation, not warranties.

### I only need SEO and page templates—not stack tables.

Use **[marketing-skills](https://github.com/kostja94/marketing-skills)** (160+ Markdown skills): `seo-strategy`, `title-tag`, `meta-description`, `schema-markup`, `landing-page-generator`, `github`, and more—install via `npx skills add kostja94/marketing-skills`.

### How stable are the bilingual files?

Chinese and English **mirror the same structure** where possible so you can diff or paste into agents. Heading-level anchors may differ slightly with localization.

---

## Scope, limits, freshness

- **In scope:** SSG / SPA / SSR **web** and PWA-facing web delivery paths **where** stacks are documented or inferred from credible public material.
- **Out of scope (by design):** Deep backend-per-vendor internals, unofficial migration SaaS catalogs, closed **prerender vendor** pitches (the Next.js migration doc follows that policy internally).
- **Last curated:** see each markdown header (`整理日期` / “Last curated”); **PRs/Issues** welcome when upstream templates change.

---

## Related projects

| Repo | Role |
|------|------|
| [marketing-skills](https://github.com/kostja94/marketing-skills) | Agent-oriented **SEO, content, pages, GEO, GitHub-parasite** skills—pairs well after you pick Next vs Vite. |

**Partnerships:** Shipping a vibe-coding product or agent that should bundle SEO skills? **[Email](mailto:zyjstc@gmail.com)**.

---

**MIT License** — see [LICENSE](LICENSE). Facts can change quickly; cite vendor docs when it matters.

If this repo saved you research time, a **star** helps others discover it—thank you.
