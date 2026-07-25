# Glassmorphism

> Light through frosted crystal, depth without weight

## Philosophy

Glassmorphism creates visual hierarchy not through solid surfaces but through translucency and blur. By layering frosted glass panels over gradient-rich backgrounds, interfaces gain a sense of physical depth and luminosity while remaining lightweight and airy. The aesthetic borrows from real-world optics — condensation on glass, light refracting through ice — to make digital surfaces feel tangible yet ethereal.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | translucent-edge | 1px solid rgba(255,255,255,0.15-0.25) |
| Shadow | diffused-soft | 0 4px 6px rgba(0,0,0,0.05) |
| Radius | generous | 1.25rem UI, 1.5rem cards |
| Typography | light-elegant | Inter thin (300) to regular (400) for body, elegant serif or light sans for headings |
| Spacing | loose | section-py 5-6rem, card-p 2-2.5rem |
| Grid | fluid | 100% width max 1400px, responsive |
| Motion | smooth-fluid | 200-300ms, ease-in-out, elastic on hover |
| Density | comfortable | line-height 1.6 |
| Elevation | blur-based | no traditional shadows, depth via backdrop-blur and translucency |
| Color | translucent-pastel | gradient orbs (purple, blue, pink) behind blur, white at 10-20% opacity on panels |

## Compatible Brands

- macOS — native frosted-glass window chrome and sidebar aesthetic
- iOS — system-wide blur sheets and translucent navigation bars
- Stripe Dashboard — frosted panels over subtle gradient backgrounds

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use backdrop-filter blur on translucent surfaces | Don't use opaque backgrounds on panels |
| Use gradient backgrounds with orbs behind blur layers | Don't use hard shadows on elevated elements |
| Use generous border-radius to soften glass edges | Don't use sharp corners or text-heavy content behind blur |

## Compiled CSS Variables

```css
:root {
  --background: 240 20% 98%;
  --foreground: 240 10% 15%;
  --card: 0 0% 100%;
  --card-foreground: 240 10% 15%;
  --popover: 0 0% 100%;
  --popover-foreground: 240 10% 15%;
  --primary: 252 56% 57%;
  --primary-foreground: 0 0% 100%;
  --secondary: 240 15% 93%;
  --secondary-foreground: 240 10% 25%;
  --muted: 240 12% 90%;
  --muted-foreground: 240 8% 46%;
  --accent: 262 60% 65%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 100%;
  --input: 240 15% 93%;
  --ring: 252 56% 57%;
  --radius: 1.25rem;
  --border-width: 1px;
  --font-display: "Inter", "SF Pro Display", system-ui, sans-serif;
  --font-sans: "Inter", "SF Pro Text", system-ui, sans-serif;
  --font-mono: "SF Mono", "Fira Code", monospace;
  --section-py: 5.5rem;
  --card-p: 2.25rem;
  --motion-duration: 250ms;
  --motion-easing: ease-in-out;
  --shadow-sm: 0 2px 4px rgba(0,0,0,0.03);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.05);
  --shadow-elegant: 0 8px 32px rgba(0,0,0,0.06);
  --shadow-glow: 0 0 40px rgba(120,100,255,0.08);
}

.dark {
  --background: 240 15% 10%;
  --foreground: 240 12% 90%;
  --card: 240 12% 14%;
  --card-foreground: 240 12% 90%;
  --popover: 240 12% 14%;
  --popover-foreground: 240 12% 90%;
  --primary: 252 56% 67%;
  --primary-foreground: 240 15% 10%;
  --secondary: 240 10% 20%;
  --secondary-foreground: 240 12% 80%;
  --muted: 240 10% 18%;
  --muted-foreground: 240 8% 55%;
  --accent: 262 60% 72%;
  --accent-foreground: 240 15% 10%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 240 10% 20%;
  --input: 240 10% 20%;
  --ring: 252 56% 67%;
  --shadow-sm: 0 2px 4px rgba(0,0,0,0.15);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.2);
  --shadow-elegant: 0 8px 32px rgba(0,0,0,0.25);
  --shadow-glow: 0 0 40px rgba(120,100,255,0.12);
}
```

## Theme-Specific Variables

```css
:root {
  --backdrop-blur: 16px;
  --surface-opacity: 0.15;
}

.dark {
  --backdrop-blur: 16px;
  --surface-opacity: 0.12;
}
```

## Non-Controlling Declaration

This theme does NOT control:
- Gradient orb placement: Background gradient positions are layout-dependent and must be set per-page
- Backdrop-filter support: Graceful degradation required for browsers without backdrop-filter
