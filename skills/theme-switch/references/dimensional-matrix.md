# Dimensional Matrix — 10-Dimension Design Philosophy Profile

> Every theme is defined across 10 dimensions. Each dimension has a philosophy, a value range, and mapping rules to CSS variables. This file defines the dimensions and their general mapping; specific theme values live in `references/themes/{name}.md`.

---

## The 10 Dimensions

### 1. Border

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How borders express structure | — |
| Width | Border thickness | `--border-width` |
| Style | solid / double / dashed / none | component border classes |
| Color | Border color opacity | `--border` (HSL) |

**Value ranges by theme category**:

| Direction | Width | Style | Color Opacity |
|---|---|---|---|
| Heavy (Brutalist, Neubrutalism) | 2-4px | solid / double | 100% opaque, often black |
| Fine (Minimal, SaaS, Magazine) | 1px | solid | 8-20% of foreground |
| Translucent (Glassmorphism) | 1px | solid | 15-25% of white |
| None (Notion-core, Fashion) | 0px | — | — |

### 2. Shadow

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How elevation is expressed | — |
| Strategy | none / soft / hard / blur-based / glow | `--shadow-sm`, `--shadow-md`, `--shadow-elegant` |
| Blur | Shadow blur radius | shadow value construction |
| Offset | Shadow x/y offset | shadow value construction |

**Value ranges by strategy**:

| Strategy | Shadow Example | Themes |
|---|---|---|
| None | `none` | Brutalist |
| Hard offset | `4px 4px 0 #000` | Neubrutalism |
| Soft | `0 1px 3px rgba(0,0,0,0.1)` | Minimal, SaaS, Corporate |
| Soft large | `0 2px 8px rgba(0,0,0,0.06)` | Bento Grid, Notion-core |
| Elegant | `0 10px 30px -12px rgba(color,0.15)` | Fashion, Magazine |
| Blur-based | No shadow, use backdrop-blur instead | Glassmorphism |
| Glow | `0 0 20px rgba(accent,0.3)` | Dark Console, Cyberpunk |

### 3. Radius

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How roundness expresses approachability | — |
| UI controls | Input, badge, small elements | `--radius` (Tailwind `rounded-lg` etc.) |
| Cards | Card containers | component-specific |
| CTA pills | Primary buttons | `rounded-full` vs `rounded-lg` |

**Value ranges**:

| Direction | UI Radius | Card Radius | CTA Shape |
|---|---|---|---|
| Sharp | 0-2px | 0-2px | Rectangular |
| Moderate | 0.375-0.5rem | 0.75rem | Rounded rectangle |
| Smooth | 0.75rem | 1rem | Pill (rounded-full) |
| Generous | 1-1.25rem | 1.25-1.5rem | Pill |
| Extreme | 1.5rem+ | 1.5-2rem | Pill |

### 4. Typography

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How typeface personality serves the design | — |
| Display font | Heading typeface | `--font-display` |
| Body font | Body/UI typeface | `--font-sans` |
| Mono font | Code/data typeface | `--font-mono` |
| Heading weight | Default weight for H1-H4 | Tailwind fontWeight |
| Body weight | Default weight for body text | Tailwind fontWeight |

**Typeface direction mapping**:

| Direction | Display Font | Body Font | Heading Weight | Themes |
|---|---|---|---|---|
| Monospace-functional | JetBrains Mono, IBM Plex Mono | Same mono or Inter | 400-700 | Brutalist, Dark Console |
| Geometric-sans | Inter, Geist Sans | Same family | 600-700 | Minimal, SaaS, Corporate |
| Serif-editorial | Playfair Display, Charter, Lora | Inter, Source Serif | 400-700 | Magazine, Notion-core, Fashion |
| Angular-condensed | Rajdhani, Space Grotesk | Share Tech Mono | 700-900 | Cyberpunk |
| Soft-rounded | Nunito, DM Sans | Same family | 600-700 | Bento Grid |

### 5. Spacing

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How spatial rhythm serves density | — |
| Density direction | compact / comfortable / loose | `--section-py`, `--card-p`, Tailwind spacing |
| Section padding | Hero/section vertical padding | `--section-py` |
| Card padding | Card internal padding | `--card-p` |

**Value ranges**:

| Direction | Section PY | Card P | Gap | Themes |
|---|---|---|---|---|
| Compact | 2-3rem | 1-1.5rem | 1rem | Brutalist, Corporate |
| Comfortable | 4-6rem | 1.5-2rem | 1.5-2rem | Minimal, SaaS, Bento |
| Loose | 6-8rem+ | 2-3rem | 2-3rem | Magazine, Fashion, Glassmorphism |

### 6. Grid

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How layout structure serves content | — |
| Grid type | strict / editorial / clean-centered / fluid / asymmetric | Tailwind container, columns |
| Container max-width | Default content width | Tailwind `maxWidth` |
| Column count | Number of content columns | Tailwind `columns`, grid |

**Grid type mapping**:

| Grid Type | Container | Columns | Themes |
|---|---|---|---|
| Strict | 1100-1200px | 12-col grid | Brutalist, Corporate |
| Clean-centered | 1100px | Single column centered | Minimal, SaaS, Fashion |
| Editorial | 1200-1400px | 2-3 column, asymmetric | Magazine, Notion-core |
| Fluid | 100% width, max 1400px | Responsive grid | Glassmorphism, Bento |
| Asymmetric | 1200px | Variable span cells | Bento Grid, Cyberpunk |

### 7. Motion

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How animation serves interaction | — |
| Duration | Transition/animation duration | `--motion-duration` |
| Easing | Timing function | `--motion-easing` |
| Decorative loops | Allowed / disabled | component-specific |

**Value ranges**:

| Direction | Duration | Easing | Loops | Themes |
|---|---|---|---|---|
| Instant | 0-50ms | linear / step-end | Disabled | Brutalist |
| Subtle | 150-200ms | ease-out | Micro only | Minimal, SaaS, Corporate |
| Smooth | 200-300ms | ease-in-out | Slow bg only | Glassmorphism, Bento, Notion |
| Expressive | 300-600ms | cubic-bezier | Controlled | Magazine, Cyberpunk |
| Slow-luxury | 400-800ms | ease-in-out | Gentle fades | Fashion |

### 8. Density

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How much information per viewport | — |
| Level | compact / comfortable / loose | line-height multiplier, spacing scale |
| Line height multiplier | Body text line height | Tailwind `lineHeight` |
| Viewport utilization | % of viewport filled with content | `--section-py` inverse |

**Value ranges**:

| Level | Line Height | Section PY | Themes |
|---|---|---|---|
| Compact | 1.4-1.5 | 2-3rem | Brutalist, Corporate, Dense Info |
| Comfortable | 1.5-1.6 | 4-5rem | Minimal, SaaS, Bento, Notion |
| Loose | 1.6-1.8 | 6-8rem | Magazine, Fashion, Glassmorphism |

### 9. Elevation

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How depth is expressed | — |
| Strategy | flat / subtle / layered / blur-based / glow | `--shadow-*` values |
| Hover behavior | How elements lift on interaction | component transition |

**Strategy mapping**:

| Strategy | Default | Hover | Themes |
|---|---|---|---|
| Flat | No shadow | No shadow change | Brutalist |
| Subtle | shadow-sm | shadow-md | Minimal, SaaS, Corporate |
| Layered | shadow-sm | shadow-md + translate | Magazine, Notion |
| Blur-based | No shadow, translucent bg | Blur intensity increase | Glassmorphism |
| Glow | Soft glow shadow | Glow intensity increase | Dark Console, Cyberpunk |
| Hard-offset | Hard shadow | Shadow offset change | Neubrutalism |

### 10. Color

| Property | Description | CSS Targets |
|---|---|---|
| Philosophy | How color strategy serves mood | — |
| Strategy | High-contrast-primary / grayscale-accent / warm-rich / vibrant / muted / neon | All `--*` HSL variables |
| Background | Page background tone | `--background` |
| Accent count | Number of saturated accent colors | `--primary`, `--accent` |
| Accent position | Where accent color appears | Component usage rules |

**Strategy mapping**:

| Strategy | Background | Primary | Accent | Themes |
|---|---|---|---|---|
| High-contrast-primary | Pure white/black | 1 saturated color | Same as primary | Brutalist, Neubrutalism |
| Grayscale-accent | White or near-white | 1 muted accent | 1 accent color | Minimal, SaaS |
| Warm-rich | Off-white/cream | Warm accent | Rich secondary | Magazine, Fashion |
| Translucent-pastel | Gradient orbs behind blur | Soft tint | Pastel accent | Glassmorphism |
| Monochrome-neon | Near-black | 1 neon color | Neon highlights | Dark Console, Cyberpunk |
| Calm-neutral | White/warm-white | Blue or teal | Muted secondary | Corporate, Notion-core, Bento |

---

## Mapping Rules: 10 Dimensions → CSS Variables

### General Mapping

```
For each dimension:
  1. Read the theme's value/range for that dimension
  2. Select a concrete value within the range
  3. Map to the target CSS variable(s)
  4. Verify the value is consistent with other dimensions
     (e.g., Brutalist's "no motion" must produce --motion-duration: 0ms)
```

### Cross-Dimension Consistency Rules

1. **Radius × Border**: If radius is 0px (sharp), borders tend to be heavier (2-4px). If radius is generous, borders tend to be fine (1px) or absent.
2. **Shadow × Elevation**: Shadow strategy and elevation strategy must align. "Blur-based" elevation means no traditional shadows.
3. **Motion × Density**: High-density themes (compact) tend toward instant motion. Low-density themes (loose) can afford slower motion.
4. **Color × Typography**: Monochrome-neon color strategies pair with monospace or angular fonts. Warm-rich color pairs with serif.
5. **Spacing × Density**: These are two expressions of the same concept. Section padding and line-height must be in the same density band.

### Non-Controlling Declaration

Each theme explicitly declares which dimensions it does NOT control, leaving those as designer freedom:

- **Most themes** do not control: specific font family names (only direction), specific hex color values (only strategy), specific spacing pixel values (only density direction)
- **Some themes** additionally do not control: grid type (e.g., Minimal works with both strict and fluid grids), accent count (e.g., Corporate can have 1 or 2 accent colors)
