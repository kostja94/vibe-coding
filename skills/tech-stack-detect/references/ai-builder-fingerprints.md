# Vibe Coding & AI Builder Platform Fingerprint Report

Data source: [enthec/webappanalyzer](https://github.com/enthec/webappanalyzer) (Wappalyzer open-source fingerprint DB) + live HTTP header analysis.

## Platform Classification

This report distinguishes three categories:

| Category | Definition | Examples |
|---|---|---|
| **Vibe Coding** | AI generates real code (React/Next.js/etc.), user iterates via chat, deploys to standard hosting | Lovable, v0, Bolt.new, Replit Agent |
| **AI IDE** | AI-assisted editor, outputs standard code, user deploys independently | Cursor, Windsurf, Claude Code |
| **Traditional CMS / Page Builder** | Visual drag-and-drop or template-based, not code-first | Framer, Webflow, Wix, Squarespace, Elementor, Bubble |

The focus of this report is **Vibe Coding** and **AI IDE** platforms.

---

## Wappalyzer Category 112 — AI Builder

Wappalyzer added category `112` for AI Builder platforms. Current coverage:

| Platform | Cat 112? | Has fingerprint? | Classification | Notes |
|---|---|---|---|---|
| Lovable | Yes (51, 112) | Yes | Vibe Coding | Full fingerprint available |
| Cursor | Yes (112) | DNS TXT only | AI IDE | No website fingerprint |
| Windsurf | Yes (112) | DNS TXT only | AI IDE | No website fingerprint |
| v0 by Vercel | No | None | Vibe Coding | Not in Wappalyzer DB at all |
| Bolt.new | No | None | Vibe Coding | Not in Wappalyzer DB at all |
| Replit | No (cat 47) | Headers only | Vibe Coding | Classified as PaaS |

---

## Vibe Coding Platforms — Full Fingerprint Detail

### Lovable

**Classification:** Vibe Coding (AI generates React/Next.js code, deploys to Vercel)
**Wappalyzer category:** 51 (Page Builder), 112 (AI Builder)

**Wappalyzer DB fingerprints:**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| `cookies: { "lovable-preview-mode": "" }` | L2 | No (auto-injected) | High |
| `dns: TXT "lovable_verification="` | L4 | Yes (can delete DNS record) | High (custom domains only) |
| `dom: link[href*='/lovable-uploads/']` | L5 | No (CDN storage path, embedded in HTML) | **Very High** |
| `js: { "LOV_SELECTOR_SCRIPT_VERSION": "^[\\d\\.]+$" }` | L6 | Mostly no (editor script) | High |
| `meta: { "author": "lovable" }` | L5 | Yes (can edit) | Medium |
| `scriptSrc: ["\\.lovable\\.app/"]` | L5 | Yes (custom domain removes) | Medium |

**Additional signals from live header analysis (not in Wappalyzer DB):**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| `x-lov-locale` response header | L1 | No (CDN-level injection) | **Very High** |
| `x-serving-backend: app` response header | L1 | No | **Very High** |
| `x-browser-engine` response header | L1 | No | **Very High** |
| `data-dpl-id` attribute on `<html>` tag | L5 | Theoretically yes, nobody does | High |
| `rs_visitor_id` cookie (RudderStack) | L2 | No (auto-injected) | High |
| Default favicon = Lovable logo | L5 | Yes (can replace) | Medium |
| "Made with Lovable" badge in bottom-right corner | L5/L6 | Yes (can remove) | Low |
| Default domain `*.lovable.app` | URL | N/A | **Very High** |

**Best detection strategy:** `/lovable-uploads/` path in HTML (L5) + `x-lov-locale` header (L1). Any 2 signals = confirmed.

---

### v0 by Vercel

**Classification:** Vibe Coding (AI generates React/Next.js + shadcn/ui code, deploys to Vercel)
**Wappalyzer status:** Not in fingerprint DB.

**Available signals from live analysis:**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| Deploys on Vercel (`X-Vercel-Id`, `X-Vercel-Cache`) | L1 | No, but not unique to v0 | Low |
| `vusercontent.net` in CSP or resources | L1/L5 | No (if present) | Medium |
| Code uses shadcn/ui (`data-radix-*` attributes) | L5/L6 | No, but not unique to v0 | Low |
| No custom CSS architecture (pure Tailwind utility classes) | L5 | N/A | Low (heuristic) |
| Default domain `*.v0.app` / `*.v0.dev` | URL | N/A | **Very High** |

**Assessment:** v0 produces standard Next.js + Tailwind + shadcn/ui code. On default subdomains, trivially detectable. On custom domains, **nearly impossible** to distinguish from a human-written Next.js + shadcn project. `vusercontent.net` is the strongest custom-domain signal but may not always appear in production builds.

---

### Bolt.new (StackBlitz)

**Classification:** Vibe Coding (AI generates full-stack code, deploys to StackBlitz/Bolt Cloud)
**Wappalyzer status:** Not in fingerprint DB.

**Available signals from live analysis:**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| Default domain `*.bolt.new` | URL | N/A | **Very High** |
| `ajs_anonymous_id` / `ajs_session_id` cookies (Segment) | L2 | No (auto-injected) | Low (Segment is common) |
| StackBlitz WebContainer service worker | L5 | Mostly yes | Low |

**Assessment:** Bolt generates clean code with minimal fingerprint. Default domain is the only reliable signal. On custom domains, **effectively undetectable.**

---

### Replit / Replit Agent

**Classification:** Vibe Coding (AI Agent mode generates full-stack code, deploys to Replit infrastructure)
**Wappalyzer category:** 47 (PaaS)

**Wappalyzer DB fingerprints:**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| `headers: { "expect-ct": "\\.repl\\.it/" }` | L1 | No | High |
| `headers: { "replit-cluster": "" }` | L1 | No | High |

**Additional signals:**

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| Default domain `*.repl.co` / `*.replit.app` | URL | N/A | **Very High** |

**Assessment:** Default domain trivially detectable. Custom domains have the `replit-cluster` header signal, making it **Medium** difficulty.

---

## AI IDE Platforms — Full Fingerprint Detail

### Cursor

**Classification:** AI IDE (code editor with AI, user deploys independently)
**Wappalyzer category:** 112 (AI Builder)

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| `dns: TXT "cursor-domain-verification"` | L4 | Yes (can delete DNS record) | Low — only proves domain ownership for Cursor services, NOT that the site was built with Cursor |

**Assessment:** Cursor is an IDE. It produces standard code with zero fingerprint. The DNS TXT record only indicates the domain owner uses Cursor services (e.g., logged in with Cursor), not that the website was built by Cursor. **Effectively undetectable as a website builder.**

---

### Windsurf (formerly Codeium)

**Classification:** AI IDE (code editor with AI, user deploys independently)
**Wappalyzer category:** 112 (AI Builder)

| Signal | Layer | User-removable | Reliability |
|---|---|---|---|
| `dns: TXT "windsurf-verification="` | L4 | Yes (can delete DNS record) | Low — same as Cursor, proves domain ownership only |

**Assessment:** Same as Cursor — IDE output is standard code. **Effectively undetectable as a website builder.**

---

### Claude Code / GitHub Copilot / Other AI coding assistants

**Classification:** AI IDE / AI coding assistant

**Assessment:** These tools produce standard code. No fingerprint is left in the deployed website. **Fundamentally undetectable.** This is the same problem as identifying which text editor wrote a document — the output format doesn't encode information about the authoring tool.

---

## Other AI-Powered Website Builders (for reference)

These are NOT vibe coding tools but do use AI in their builder workflow. Included for completeness.

| Platform | Type | Key Fingerprint | Detectability |
|---|---|---|---|
| Hostinger Horizons | AI Page Builder | `X-Powered-By: Hostinger Horizons` header + `meta generator` | **Very High** |
| Gamma | AI Presentation/Website | `gamma_visitor_id` cookie + `gammaSiteAnimationsInitialized` JS global | **High** |
| Durable | AI Website Builder | `cdn.durable.co` script src | **High** |
| ZipWP | AI WordPress Builder | `app.zipwp.com` script src (requires WordPress) | **High** |

---

## Summary: Vibe Coding Detection Difficulty

| Platform | Default domain | Custom domain | Overall | Key signal |
|---|---|---|---|---|
| **Lovable** | Trivially | **Yes** | **High** | `/lovable-uploads/` + `x-lov-locale` header |
| **v0** | Trivially | **Barely** | **Low** | `vusercontent.net` (unreliable) |
| **Bolt.new** | Trivially | **No** | **Very Low** | None on custom domains |
| **Replit** | Trivially | **Barely** | **Medium** | `replit-cluster` header |
| **Cursor** | N/A (IDE) | **No** | **Undetectable** | DNS TXT proves ownership only |
| **Windsurf** | N/A (IDE) | **No** | **Undetectable** | DNS TXT proves ownership only |
| **Claude Code** | N/A (IDE) | **No** | **Undetectable** | No fingerprint at all |

**Core insight:** Vibe coding platforms that also host the deployment (Lovable, Replit) leave fingerprints at the CDN/hosting layer. Platforms where code is exported and deployed independently (v0 on custom domain, Bolt on custom domain) are nearly indistinguishable from human-written code. AI IDEs (Cursor, Windsurf, Claude Code) are fundamentally undetectable — they are authoring tools, not hosting platforms.

---

## Heuristic: AI-Generated Code Indicators (Low Confidence)

When traditional fingerprint layers find nothing distinctive but the site shows ALL of these patterns simultaneously, flag as "possibly AI-generated" with Low confidence:

- Next.js App Router + Tailwind CSS + shadcn/ui (Radix UI attributes) + no custom CSS architecture
- Vercel hosting + no WordPress/CMS/legacy framework detected
- Extremely clean, uniform component structure with no code comments
- All components follow identical naming and structure conventions

This heuristic produces many false positives and should never be reported above Low confidence.
