# Vibe Coding Agent Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/kostja94/vibe-coding?style=social)](https://github.com/kostja94/vibe-coding/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/kostja94/vibe-coding)](https://github.com/kostja94/vibe-coding/commits/main)

Markdown skill library for AI agents — detect live tech stacks, migrate Lovable projects to **Next.js 16 App Router**, and compile design themes into CSS tokens. Works with **Cursor**, **Claude Code**, **OpenClaw**, **Lovable**, **v0**, **Bolt**, and any platform that reads Agent Skills markdown.

**By [@kostja94](https://github.com/kostja94)** · Pair with **[marketing-skills](https://github.com/kostja94/marketing-skills)** for post-migration SEO · zyjstc@gmail.com

---

## Quick Start

```bash
# Install specific skills (recommended — pick 1–2 per task)
npx skills add kostja94/vibe-coding --skill lovable-to-nextjs

# Install all three
npx skills add kostja94/vibe-coding --skill lovable-to-nextjs tech-stack-detect theme-switch

# List available
npx skills add kostja94/vibe-coding --list
```

**Note:** The CLI installs **skills only** (flat layout into `.cursor/skills/`). It does **not** copy bundled `scripts/` or full `references/` trees. Need PowerShell/Bash helpers? Use [Clone + copy](#installation) below.

**Platforms:** Cursor, Claude Code, OpenClaw, Lovable, v0, Bolt — native install or copy to `.cursor/skills/`, `.claude/skills/`, or `.agents/skills/`.

---

## What are Skills?

Skills are **markdown workflows** (`SKILL.md` + `references/` + optional `scripts/`) that teach an agent how to execute a focused task. Add them to your project; the agent picks the right skill from your prompt and follows phased steps with validation gates.

**This repo = vibe coding engineering** (detect stacks, migrate frameworks, design tokens). **Human guides → [Alignify](https://alignify.co/). Post-migration SEO → [marketing-skills](https://github.com/kostja94/marketing-skills).

---

## Use Cases

| Scenario | Skills |
|----------|--------|
| "What tech stack does this site use?" / competitor URL | `tech-stack-detect` |
| "Is this built with Lovable?" / AI builder fingerprint | `tech-stack-detect` |
| Migrate Lovable (Vite / TanStack Start) → Next.js for production SEO | `lovable-to-nextjs` |
| Normalize hardcoded colors → design tokens during migration | `lovable-to-nextjs` → optional `theme-switch` |
| Switch visual style / "make it look like Stripe" / new project theme | `theme-switch` |
| After migration: title tags, schema, sitemap, landing pages | [marketing-skills](https://github.com/kostja94/marketing-skills) |

**Partnership:** Building a vibe coding product or AI agent pipeline? [Contact](mailto:zyjstc@gmail.com) to integrate.

[![Star History Chart](https://api.star-history.com/image?repos=kostja94/vibe-coding&type=Date)](https://star-history.com/#kostja94/vibe-coding)

**Found this useful?** A star or share helps others discover it — thank you.

---

## Installation

| Method | When |
|--------|------|
| **CLI** | Fast install; skills only, flat layout |
| **Clone + copy** | Full tree with `scripts/` and `references/`: `cp -r vibe-coding/skills/* ~/.cursor/skills/` |
| **Git submodule** | Pin version in a team repo: `git submodule add https://github.com/kostja94/vibe-coding.git .cursor/vibe-coding` |

**Skill directories** ([Agent Skills spec](https://agentskills.io/specification)): `.agents/skills/`, `.cursor/skills/`, `.claude/skills/`, `~/.cursor/skills/`.

```bash
git clone https://github.com/kostja94/vibe-coding.git
cp -r vibe-coding/skills/* ~/.cursor/skills/
```

---

## Usage

Ask your agent — it picks the right skill. Examples:

| You say | Skill |
|---------|-------|
| "What stack is this site?" / paste a URL | `tech-stack-detect` |
| "Analyze competitor technology" / "what is this built with?" | `tech-stack-detect` |
| "Migrate Lovable to Next.js" / "convert Vite to App Router" | `lovable-to-nextjs` |
| "Move this Lovable project to production SEO" | `lovable-to-nextjs` |
| "Switch to brutalist" / "change design style" / "换个风格" | `theme-switch` |
| "Make it look like Stripe" / "what styles are trending?" | `theme-switch` |
| "Add schema markup" / "fix meta description" / "create sitemap" | [marketing-skills](https://github.com/kostja94/marketing-skills) |

---

## Skills Overview

**3 skills** — each self-contained under `skills/<name>/`. Read `SKILL.md` for the full pipeline.

| Skill | Scope |
|-------|-------|
| **lovable-to-nextjs** | Lovable repo → **Next.js 16** App Router · Phase 0–9 with gates · same-repo `feature/nextjs-migration` branch · router/SEO/normalization rewrite |
| **tech-stack-detect** | Any URL → 8-layer analysis (headers, cookies, DNS, HTML, JS globals, network) · confidence-rated report · AI builder fingerprints |
| **theme-switch** | 12 built-in themes → shadcn/Tailwind-aligned `:root` CSS variables · reference URL extraction · trend discovery |

### lovable-to-nextjs

| Aspect | Detail |
|--------|--------|
| **Input** | Lovable export: Vite + React Router or TanStack Start |
| **Output** | Next.js 16 / React 19 · migrated routes · Metadata API · sitemap/robots |
| **Scripts** | `detect-lovable-stack.ps1`, `quality-diagnostic.ps1`, `validate-migration.ps1` |
| **Optional calls** | Phase 0.7 → `tech-stack-detect` · Phase 1.4 → `theme-switch` |

### tech-stack-detect

| Aspect | Detail |
|--------|--------|
| **Layers** | L1 headers → L2 cookies → L3 robots.txt → L4 DNS → L5 HTML → L6 JS globals → L7 network → L8 SSL |
| **Scripts** | `detect-quick.ps1` / `detect-quick.sh`, `detect-js-globals.js` |
| **References** | `signatures*.md`, `ai-builder-fingerprints.md`, `report-template.md` |

### theme-switch

| Aspect | Detail |
|--------|--------|
| **Themes** | Brutalist, Neubrutalism, Minimal, Startup SaaS, Magazine, Glassmorphism, Dark Console, Cyberpunk, Bento Grid, Notion-core, Corporate, Fashion Luxury |
| **Output** | `:root` block for `index.css` / `globals.css` — swap tokens, keep components |
| **Scripts** | `validate-tokens.ps1` |

**Workflow:** `lovable-to-nextjs` orchestrates; say **"skip intro"** or **"just do it"** on repeat runs to jump straight to Phase 0.

```
                    +---------------------------+
                    |   tech-stack-detect       |
                    |   URL · competitor ·      |
                    |   AI builder fingerprint  |
                    +-------------+-------------+
                                  |
                                  v
                    +---------------------------+
                    |   lovable-to-nextjs       |
                    |   Phase 0–9 · same repo   |
                    |   validation gates        |
                    +-------------+-------------+
                                  |
              +-------------------+-------------------+
              v                                       v
   +--------------------+                 +--------------------+
   |   theme-switch     |                 |  marketing-skills  |
   |   optional ·       |                 |  title · schema ·  |
   |   design tokens    |                 |  sitemap · pages   |
   +--------------------+                 +--------------------+
```

---

## Repository Layout

```
skills/
├── lovable-to-nextjs/
│   ├── SKILL.md
│   ├── references/     # code-rewrite, seo-templates, deployment, normalization, stack-detection
│   └── scripts/        # detect, diagnostic, validate (PowerShell)
├── tech-stack-detect/
│   ├── SKILL.md
│   ├── references/     # signatures, ai-builder-fingerprints, report-template
│   └── scripts/        # detect-quick.ps1/.sh, detect-js-globals.js
└── theme-switch/
    ├── SKILL.md
    ├── references/     # themes/, css-output-schema, quality-gates
    └── scripts/        # validate-tokens.ps1
```

---

## Tips

| Tip | Action |
|-----|--------|
| **Detect before migrate** | Run `tech-stack-detect` on the live URL to confirm Lovable fingerprints and hosting |
| **Skip intro** | Say `"skip intro"` or `"just do it"` → agent starts at Phase 0 |
| **Don't stop at migration** | Chain [marketing-skills](https://github.com/kostja94/marketing-skills) for SEO infrastructure |
| **Need scripts** | CLI install is flat — clone repo if you want `scripts/` on disk |

---

## Security

- **SKILL bodies** are markdown instructions — review before use.
- **`scripts/`** includes **PowerShell and Bash** helpers — audit before running in your environment.
- **`tech-stack-detect`** sends HTTP/DNS requests to target URLs — only analyze URLs you are permitted to probe.
- **No bundled API keys** — configure env vars (`DEEPSEEK_API_KEY`, `JINA_API_KEY`, etc.) in your project, never in git.

---

## Related Projects

| Repo | Role |
|------|------|
| [marketing-skills](https://github.com/kostja94/marketing-skills) | SEO, content, pages, GEO — use after migration |
| [alignify.co](https://alignify.co/) | Human-readable marketing guides |

**Ecosystem:** [Agent Skills Specification](https://agentskills.io/specification) · [skills.sh](https://skills.sh) · [Vercel skills CLI](https://github.com/vercel-labs/skills)

---

## License

Repository: **[MIT](LICENSE)**. Individual skills may note proprietary authorship in `SKILL.md` frontmatter.
