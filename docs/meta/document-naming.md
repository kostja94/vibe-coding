# Markdown document naming — vibe-coding

Conventions for filenames in this repo (aligned with **`kostja94/marketing-skills`** style: readable slugs, hyphen separation, stable paths for links and agents).

## Goals

- **Readable URLs** on GitHub (`…/blob/main/docs/en/…`).
- **Consistent word boundaries**—use **hyphens** between words and product names, not glued lowercase.
- **Predictable pairing** between `docs/en/` and `docs/zh/` (same topic, different language).

## Locale layout

| Directory | Purpose |
|-----------|---------|
| `docs/en/` | English sources; **ASCII slugs** preferred. |
| `docs/zh/` | Chinese sources; **UTF-8** filenames allowed. |

## English (`docs/en/`)

| Rule | ✓ Do | ✗ Avoid |
|------|------|---------|
| Letters & digits | Use **lowercase** Latin, **hyphens** between tokens. | Glued words: `convertlovabletonextjs` |
| Word boundaries | `convert-lovable-to-nextjs.md` | `convertLovableToNextjs.md`, `CONVERT_LOVABLE.md` |
| Length | Prefer **clear over ultra-short** (roughly 4–8 hyphen segments max). | Whole sentence in filename |
| Stack / product slugs | Keep known names: `nextjs`, `lovable`, `vibe-coding`. | Random abbreviations |
| Extension | Always **`.md`**. | `.markdown` unless tooling requires |

**Examples in this repo:**

- `vibe-coding-product-frontend-stack.md`
- `convert-lovable-to-nextjs.md`

## Chinese (`docs/zh/`)

| Rule | Guidance |
|------|----------|
| **` .md` 后缀** | 与其他文档一致。 |
| **可读性优先** | 用自然中文描述主题；产品与框架名可保留 **Lovable / Next.js** 等拉丁写法。 |
| **与英文配对** | 同一主题的中英文文件在 README 与文内互链中成对列出；**文件名不必逐词对译**，但主题需一致。 |

**Current examples:** `Vibe-Coding产品前端技术栈.md`, `迁移Lovable至Nextjs.md`

## Repo root

- **`README.md`** — default GitHub landing (**English** primary for global discovery).
- **`README.zh-CN.md`** — Chinese counterpart; link from `README.md`.

## When adding or renaming a doc

1. Pick the slug using the rules above.
2. **Update every internal link** in this repo (`README`, sibling docs, cross-references).
3. Prefer **one PR / one commit** per rename so blame stays clear.
4. Avoid breaking **external deep links** without need; if you rename, consider a short note in the PR body for bookmarked URLs.

## Relation to marketing-skills

The **marketing-skills** repo names **skill** trees and individual `SKILL.md` files for agent consumption. This repo names **long-form reference articles** under `docs/`; the same spirit applies: **hyphenated, descriptive, stable paths**.
