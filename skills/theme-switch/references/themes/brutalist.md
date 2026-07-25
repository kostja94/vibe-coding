# Brutalist

> Anti-polish, functional exposure, raw honesty

## Philosophy

Brutalism rejects decorative layering and exposes the structural skeleton of the interface. Every element declares its function without disguise—borders are heavy, shadows are absent, and color is stripped to its most confrontational minimum. The result is a system that is honest, fast, and unapologetically direct.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | heavy-raw | 3-4px solid black, fully opaque |
| Shadow | none | 0 (no shadows) |
| Radius | sharp-functional | 0-2px |
| Typography | monospace-functional | JetBrains Mono display, IBM Plex Mono body, 400-700 weight |
| Spacing | compact | section-py 2-3rem, card-p 1-1.5rem |
| Grid | strict | 12-col, 1100-1200px container |
| Motion | instant-functional | 0-50ms, linear |
| Density | high-density | line-height 1.4-1.5 |
| Elevation | flat | no shadows |
| Color | high-contrast-primary | pure white/black + 1 saturated accent (red or yellow) |

## Compatible Brands

- PostHog — product-led growth analytics with a raw, developer-first aesthetic
- Craigslist — the original functional web: no decoration, all utility
- Hacker News — minimal chrome, maximum signal, text-first information density
- Bloomberg Terminal — data-dense, contrast-maximized, zero-nonsense interface

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use thick solid borders to define regions | Add rounded corners or soft shadows |
| Keep color to black, white, and one accent | Use gradients, blurs, or transparency |
| Make motion instant or remove it entirely | Add hover animations or transitions |
| Prioritize information density and speed | Decorate for decoration's sake |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 100%;
  --foreground: 0 0% 4%;
  --card: 0 0% 100%;
  --card-foreground: 0 0% 4%;
  --popover: 0 0% 100%;
  --popover-foreground: 0 0% 4%;
  --primary: 0 72% 51%;
  --primary-foreground: 0 0% 100%;
  --secondary: 0 0% 92%;
  --secondary-foreground: 0 0% 4%;
  --muted: 0 0% 92%;
  --muted-foreground: 0 0% 30%;
  --accent: 45 93% 47%;
  --accent-foreground: 0 0% 4%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 0%;
  --input: 0 0% 0%;
  --ring: 0 72% 51%;
  --radius: 0px;
  --border-width: 3px;
  --font-display: "JetBrains Mono", monospace;
  --font-sans: "IBM Plex Mono", monospace;
  --font-mono: "IBM Plex Mono", monospace;
  --section-py: 2.5rem;
  --card-p: 1.25rem;
  --motion-duration: 0ms;
  --motion-easing: linear;
  --shadow-sm: none;
  --shadow-md: none;
  --shadow-elegant: none;
  --shadow-glow: none;
}

.dark {
  --background: 0 0% 5%;
  --foreground: 0 0% 96%;
  --card: 0 0% 5%;
  --card-foreground: 0 0% 96%;
  --popover: 0 0% 5%;
  --popover-foreground: 0 0% 96%;
  --primary: 0 72% 55%;
  --primary-foreground: 0 0% 100%;
  --secondary: 0 0% 15%;
  --secondary-foreground: 0 0% 96%;
  --muted: 0 0% 15%;
  --muted-foreground: 0 0% 65%;
  --accent: 45 93% 50%;
  --accent-foreground: 0 0% 5%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 100%;
  --input: 0 0% 100%;
  --ring: 0 72% 55%;
  --shadow-sm: none;
  --shadow-md: none;
  --shadow-elegant: none;
  --shadow-glow: none;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Imagery: photo/video content is outside the theme's scope
- Content voice: copywriting tone is independent of visual brutalism
- Icon style: icons may be outline or filled; the theme does not prescribe a set
