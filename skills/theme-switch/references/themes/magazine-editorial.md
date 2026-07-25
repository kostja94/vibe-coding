# Magazine / Editorial

> Typography is illustration, reading experience is paramount

## Philosophy

In editorial design, the written word is the visual. Every typographic choice — from drop cap to pull quote — serves as illustration, drawing the reader deeper into the story. This theme privileges the reading experience above all else, using generous whitespace, serif faces with personality, and the restrained drama of thin black rules to create pages that feel like they belong in print.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | thin-rules | 1px solid black horizontal rules for section dividers |
| Shadow | elegant-soft | 0 10px 30px -12px rgba(0,0,0,0.15) |
| Radius | mixed | 0px for most elements (editorial boxes), up to 0.5rem for interactive elements |
| Typography | serif-editorial | Playfair Display/Charter for headings (400, 700), Inter/Source Serif for body (400, 600) |
| Spacing | loose-dramatic | section-py 6-8rem, card-p 2-3rem |
| Grid | editorial | 1200-1400px, 2-3 column asymmetric |
| Motion | expressive | 300-500ms, ease-in-out, scroll-triggered reveals |
| Density | low-breathing | line-height 1.7-1.8 |
| Elevation | layered | subtle shadow on cards, depth through typographic scale |
| Color | warm-rich | off-white/cream bg #F8F5F0, near-black text #1A1A1A, red accent #CC0000 for bylines/rules |

## Compatible Brands

- NYT Magazine — same editorial serif-first, rule-driven print heritage
- The Verge — bold typographic hierarchy with restrained color
- Bloomberg Businessweek — editorial grid with dramatic whitespace and thin dividers

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use drop caps and pull quotes with red left border | Don't use icons where typography suffices |
| Justify body text with hyphenation | Don't use gradient buttons |
| Use thin black rules between sections | Don't use rounded pill CTAs or colored section backgrounds |

## Compiled CSS Variables

```css
:root {
  --background: 35 40% 96%;
  --foreground: 0 0% 10%;
  --card: 35 30% 98%;
  --card-foreground: 0 0% 10%;
  --popover: 35 30% 98%;
  --popover-foreground: 0 0% 10%;
  --primary: 0 100% 40%;
  --primary-foreground: 0 0% 98%;
  --secondary: 35 15% 90%;
  --secondary-foreground: 0 0% 20%;
  --muted: 35 10% 88%;
  --muted-foreground: 0 0% 40%;
  --accent: 0 100% 40%;
  --accent-foreground: 0 0% 98%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 98%;
  --border: 0 0% 82%;
  --input: 0 0% 82%;
  --ring: 0 100% 40%;
  --radius: 0px;
  --border-width: 1px;
  --font-display: "Playfair Display", "Charter", Georgia, serif;
  --font-sans: "Inter", "Source Serif Pro", Georgia, serif;
  --font-mono: "IBM Plex Mono", "Source Code Pro", monospace;
  --section-py: 7rem;
  --card-p: 2.5rem;
  --motion-duration: 400ms;
  --motion-easing: ease-in-out;
  --shadow-sm: 0 2px 8px -2px rgba(0,0,0,0.08);
  --shadow-md: 0 4px 16px -4px rgba(0,0,0,0.1);
  --shadow-elegant: 0 10px 30px -12px rgba(0,0,0,0.15);
  --shadow-glow: none;
}

.dark {
  --background: 0 0% 12%;
  --foreground: 35 25% 92%;
  --card: 0 0% 15%;
  --card-foreground: 35 25% 92%;
  --popover: 0 0% 15%;
  --popover-foreground: 35 25% 92%;
  --primary: 0 100% 45%;
  --primary-foreground: 0 0% 98%;
  --secondary: 0 5% 22%;
  --secondary-foreground: 35 20% 80%;
  --muted: 0 5% 20%;
  --muted-foreground: 0 0% 55%;
  --accent: 0 100% 45%;
  --accent-foreground: 0 0% 98%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 98%;
  --border: 0 0% 22%;
  --input: 0 0% 22%;
  --ring: 0 100% 45%;
  --shadow-sm: 0 2px 8px -2px rgba(0,0,0,0.3);
  --shadow-md: 0 4px 16px -4px rgba(0,0,0,0.35);
  --shadow-elegant: 0 10px 30px -12px rgba(0,0,0,0.45);
  --shadow-glow: none;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Grid: Column proportions are layout-dependent and should be set per-page
- Motion: Scroll-triggered reveal patterns depend on the animation library in use
