# Quality Gates — Theme Output Validation

> Every compiled theme output must pass these checks before being written to the project. Checks are ordered by severity — contrast failures are blocking, consistency warnings are advisory.

---

## Gate 1: Color Contrast (Blocking)

**Rule**: All foreground-on-background pairings must meet WCAG AA.

| Pairing | Minimum Ratio | Test |
|---|---|---|
| `--foreground` on `--background` | ≥ 4.5:1 | Normal text |
| `--muted-foreground` on `--background` | ≥ 3:1 | Large text / secondary info |
| `--primary-foreground` on `--primary` | ≥ 4.5:1 | Button text |
| `--card-foreground` on `--card` | ≥ 4.5:1 | Card body text |
| `--destructive-foreground` on `--destructive` | ≥ 4.5:1 | Error state text |

**Calculation**: Convert HSL to RGB, then compute relative luminance:

```
L = 0.2126 * R_linear + 0.7152 * G_linear + 0.0722 * B_linear
Contrast = (L_lighter + 0.05) / (L_darker + 0.05)
```

**Failure action**: Flag the failing pairing. Suggest adjusting the foreground lightness to meet the minimum ratio. Do not auto-fix — let the user decide.

**Special case — Glassmorphism**: Translucent backgrounds make fixed contrast testing impossible. Test with the fallback background (the one visible when backdrop-filter is unsupported) and flag that Glassmorphism may have contrast issues in certain contexts.

---

## Gate 2: Type Scale (Blocking)

**Rule**: H1 vs body font size ratio must be ≥ 2.5:1.

| Check | Minimum | Rationale |
|---|---|---|
| H1 size / body size | ≥ 2.5:1 | Visual hierarchy must be immediately obvious |
| Adjacent heading step difference | ≥ 1.2:1 | Each heading level must be distinguishable |
| Body size minimum | ≥ 14px (0.875rem) | Readability floor |

**Failure action**: Flag and suggest adjusting the heading scale. Do not reduce body size below 14px.

---

## Gate 3: Density Consistency (Warning)

**Rule**: Spacing values must form a coherent scale.

| Check | Expected | Warning if |
|---|---|---|
| `--section-py` vs `--card-p` | section ≥ 2× card | section < 1.5× card (too tight) |
| `--card-p` vs gap | card ≥ gap | card < gap (cards feel hollow) |
| Line-height multiplier | Matches density direction | Compact theme with loose line-height, or vice versa |

**Failure action**: Warn but allow. Suggest which values to adjust for consistency.

---

## Gate 4: CSS Variable Completeness (Blocking)

**Rule**: Every variable in `css-output-schema.md` must have a value.

Check against the completeness checklist:

- All 18 color variables present in both `:root` and `.dark`
- `--radius`, `--border-width`, font variables, spacing variables, motion variables present
- All three shadow variables present
- Theme-specific variables present (e.g., `--backdrop-blur` for Glassmorphism)

**Failure action**: Block output. The theme file is incomplete — must be fixed before writing.

---

## Gate 5: Theme-Specific Rules (Warning)

Rules that apply only to specific themes:

| Theme | Rule | Check |
|---|---|---|
| Brutalist | No motion | `--motion-duration` must be ≤ 50ms |
| Brutalist | No radius | `--radius` must be ≤ 2px |
| Brutalist | No shadow | `--shadow-sm` and `--shadow-md` must be `none` |
| Neubrutalism | Hard shadow | `--shadow-sm` must include `Xpx Xpx 0` pattern |
| Neubrutalism | No radius | `--radius` must be 0px |
| Glassmorphism | Backdrop blur | `--backdrop-blur` must be ≥ 10px |
| Glassmorphism | Translucent bg | Card backgrounds must use rgba or low-alpha HSL |
| Dark Console | Dark background | `--background` lightness ≤ 10% |
| Cyberpunk | Glow effect | `--shadow-glow` must be present and non-none |
| Cyberpunk | Cut corners | Note that clip-path usage is expected in components |
| Fashion Luxury | Extreme spacing | `--section-py` must be ≥ 6rem |
| Startup SaaS | Pill CTAs | CTA border-radius must be `rounded-full` (9999px) |

**Failure action**: Warn. The theme may work but doesn't fully express its design philosophy. Suggest the expected value.

---

## Gate 6: Dark Mode Validity (Blocking)

**Rule**: Dark mode must be a valid, usable color scheme — not just an inversion.

| Check | Expected |
|---|---|
| `--background` lightness in `.dark` | ≤ 15% (actually dark) |
| `--foreground` lightness in `.dark` | ≥ 85% (actually light) |
| `--primary` in `.dark` | Sufficient contrast on dark bg |
| `--muted` in `.dark` | Lighter than background, darker than foreground |
| `--border` in `.dark` | Visible but not harsh |

**Failure action**: Block. Dark mode must be fully specified and pass contrast checks independently.

---

## Validation Script

Run `scripts/validate-tokens.ps1` to automate Gates 1-4 and 6. Gate 5 requires theme-awareness and is checked during compilation.

```powershell
# Usage:
# .\scripts\validate-tokens.ps1 -CssPath "path/to/index.css"
# .\scripts\validate-tokens.ps1 -CssPath "path/to/index.css" -Theme "brutalist"
```

Exit codes:
- 0: All gates pass
- 1: Blocking gate failure (contrast, completeness, dark mode)
- 2: Warning only (density consistency, theme-specific rules)
