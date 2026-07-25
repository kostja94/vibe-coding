# CSS Output Schema — index.css Variable Format

> Standard output format for compiled theme tokens. Aligned with shadcn/ui variable naming and Tailwind CSS consumption patterns. Every theme must produce a complete block following this schema.

---

## Standard :root Block

```css
@layer base {
  :root {
    /* ===== COLOR ===== */
    --background: {BG_HSL};           /* e.g., 0 0% 100% for white, 0 0% 3.9% for dark */
    --foreground: {FG_HSL};           /* e.g., 0 0% 3.9% for near-black, 0 0% 98% for light */
    --card: {CARD_HSL};
    --card-foreground: {CARD_FG_HSL};
    --popover: {POPOVER_HSL};
    --popover-foreground: {POPOVER_FG_HSL};
    --primary: {PRIMARY_HSL};
    --primary-foreground: {PRIMARY_FG_HSL};
    --secondary: {SECONDARY_HSL};
    --secondary-foreground: {SECONDARY_FG_HSL};
    --muted: {MUTED_HSL};
    --muted-foreground: {MUTED_FG_HSL};
    --accent: {ACCENT_HSL};
    --accent-foreground: {ACCENT_FG_HSL};
    --destructive: {DESTRUCTIVE_HSL};
    --destructive-foreground: {DESTRUCTIVE_FG_HSL};
    --border: {BORDER_HSL};
    --input: {INPUT_HSL};
    --ring: {RING_HSL};

    /* ===== SHAPE ===== */
    --radius: {RADIUS};               /* 0px | 0.375rem | 0.5rem | 0.75rem | 1rem | 1.25rem */

    /* ===== BORDER ===== */
    --border-width: {BORDER_WIDTH};   /* 0px | 1px | 2px | 3px */

    /* ===== TYPOGRAPHY (application via Tailwind config) ===== */
    --font-display: {DISPLAY_FONT};   /* e.g., 'Playfair Display', serif */
    --font-sans: {BODY_FONT};         /* e.g., 'Inter', sans-serif */
    --font-mono: {MONO_FONT};         /* e.g., 'JetBrains Mono', monospace */

    /* ===== SPACING ===== */
    --section-py: {SECTION_PY};       /* 2rem | 3rem | 4rem | 5rem | 6rem | 8rem */
    --card-p: {CARD_P};               /* 1.5rem | 2rem | 2.5rem | 3rem */

    /* ===== MOTION ===== */
    --motion-duration: {MOTION_MS};   /* 0ms | 50ms | 150ms | 200ms | 300ms */
    --motion-easing: {MOTION_EASING}; /* linear | ease-out | ease-in-out | cubic-bezier(0.4, 0, 0.2, 1) */

    /* ===== SHADOW ===== */
    --shadow-sm: {SHADOW_SM};
    --shadow-md: {SHADOW_MD};
    --shadow-elegant: {SHADOW_ELEGANT};
    --shadow-glow: {SHADOW_GLOW};

    /* ===== THEME-SPECIFIC ===== */
    /* These variables are only present in themes that need them */
    /* Glassmorphism: */
    --backdrop-blur: {BLUR_VALUE};    /* e.g., 12px | 16px | 20px */
    /* Cyberpunk: */
    --glow-color: {GLOW_COLOR};       /* e.g., 0 255 255 for cyan */
    --scanline-opacity: {SCANLINE};   /* e.g., 0.03 */
  }

  .dark {
    --background: {DARK_BG_HSL};
    --foreground: {DARK_FG_HSL};
    --card: {DARK_CARD_HSL};
    --card-foreground: {DARK_CARD_FG_HSL};
    --popover: {DARK_POPOVER_HSL};
    --popover-foreground: {DARK_POPOVER_FG_HSL};
    --primary: {DARK_PRIMARY_HSL};
    --primary-foreground: {DARK_PRIMARY_FG_HSL};
    --secondary: {DARK_SECONDARY_HSL};
    --secondary-foreground: {DARK_SECONDARY_FG_HSL};
    --muted: {DARK_MUTED_HSL};
    --muted-foreground: {DARK_MUTED_FG_HSL};
    --accent: {DARK_ACCENT_HSL};
    --accent-foreground: {DARK_ACCENT_FG_HSL};
    --destructive: {DARK_DESTRUCTIVE_HSL};
    --destructive-foreground: {DARK_DESTRUCTIVE_FG_HSL};
    --border: {DARK_BORDER_HSL};
    --input: {DARK_INPUT_HSL};
    --ring: {DARK_RING_HSL};
    /* Dark-specific shadow overrides */
    --shadow-sm: {DARK_SHADOW_SM};
    --shadow-md: {DARK_SHADOW_MD};
    --shadow-elegant: {DARK_SHADOW_ELEGANT};
  }
}
```

---

## Variable Naming Convention

All color values use **HSL format without the `hsl()` wrapper**: `H S% L%` (e.g., `0 0% 100%`). This is the shadcn/ui convention — Tailwind's `hsl(var(--background))` wrapper adds the `hsl()` at consumption time.

```
✅ --background: 0 0% 100%;
❌ --background: #FFFFFF;
❌ --background: hsl(0, 0%, 100%);
❌ --background: rgba(255, 255, 255, 1);
```

### Opacity modifiers

Tailwind supports `bg-primary/50` for 50% opacity. This works automatically with the HSL format — Tailwind generates `hsl(var(--primary) / 0.5)`.

---

## Shadow Value Format

Shadow values use full CSS `box-shadow` syntax:

```
--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
--shadow-elegant: 0 10px 30px -12px rgba(0, 0, 0, 0.15);
--shadow-glow: 0 0 20px rgba(59, 130, 246, 0.3);
```

### Theme-specific shadow patterns

| Theme | Shadow Pattern |
|---|---|
| Brutalist | `--shadow-sm: none; --shadow-md: none;` |
| Neubrutalism | `--shadow-sm: 4px 4px 0 #000; --shadow-md: 6px 6px 0 #000;` |
| Minimal/SaaS | Standard soft shadows (see above) |
| Glassmorphism | `--shadow-sm: 0 4px 6px rgba(0,0,0,0.05);` (secondary to blur) |
| Dark Console | `--shadow-glow: 0 0 20px rgba(accent,0.2);` |
| Cyberpunk | `--shadow-glow: 0 0 15px rgba(accent,0.5);` |

---

## Tailwind Config Synchronization

When a `tailwind.config.ts` exists, these sections must be updated to match the CSS variables:

```typescript
// tailwind.config.ts — sections affected by theme switch
module.exports = {
  theme: {
    fontFamily: {
      display: ["var(--font-display)"],
      sans: ["var(--font-sans)"],
      mono: ["var(--font-mono)"],
    },
    borderRadius: {
      lg: "var(--radius)",
      md: "calc(var(--radius) - 2px)",
      sm: "calc(var(--radius) - 4px)",
    },
    // animation/keyframes only if motion values changed
  },
};
```

**Do NOT change**: `maxWidth`, `spacing`, `plugins`, `presets`, or any non-visual config.

---

## Completeness Checklist

Every theme output MUST include:

- [ ] All 18 color variables in `:root`
- [ ] All 18 color variables in `.dark`
- [ ] `--radius` value
- [ ] `--border-width` value
- [ ] `--font-display`, `--font-sans`, `--font-mono`
- [ ] `--section-py`, `--card-p`
- [ ] `--motion-duration`, `--motion-easing`
- [ ] `--shadow-sm`, `--shadow-md`, `--shadow-elegant`
- [ ] Theme-specific variables (if applicable)
- [ ] Shadow overrides in `.dark` (if different from light)
