# Dark Console

> Terminal aesthetics, code-native UI, high contrast monochrome

## Philosophy

The console is where developers live, and this theme treats that environment as a design virtue rather than a limitation. It embraces the monospace grid, the high-contrast scan line, and the quiet glow of an accent cursor against a near-black void. Every element is chosen for functional clarity first — the aesthetic of the terminal is the aesthetic of intent.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | subtle-dark | 1px solid at low opacity on dark |
| Shadow | glow | 0 0 20px rgba(accent,0.2) |
| Radius | moderate | 0.5rem UI, 0.75rem cards |
| Typography | monospace-functional | JetBrains Mono/IBM Plex Mono for display, Inter for body, mono for code |
| Spacing | compact-efficient | section-py 3-4rem, card-p 1.5rem |
| Grid | strict | 12-col, 1100-1200px |
| Motion | snappy-functional | 150ms, ease-out |
| Density | compact | line-height 1.5 |
| Elevation | glow-based | accent-colored glow shadows |
| Color | monochrome-neon | near-black bg #0a0a0f (240 10% 3.9%), light gray text, 1 neon accent (cyan #00D4FF) |

## Compatible Brands

- Vercel Dashboard — dark-first, monospace accents, minimal chrome
- Cursor — terminal-native aesthetics with glow elevation
- Arc Browser — command-palette UI, dark-mode-first with accent highlights

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use monospace for headings and code blocks | Don't use decorative serifs or script fonts |
| Use accent glow shadows for elevation and focus | Don't use soft drop shadows or traditional elevation |
| Keep spacing tight and grid-aligned | Don't waste whitespace — every pixel earns its place |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 96%;
  --foreground: 240 10% 8%;
  --card: 0 0% 100%;
  --card-foreground: 240 10% 8%;
  --popover: 0 0% 100%;
  --popover-foreground: 240 10% 8%;
  --primary: 168 100% 42%;
  --primary-foreground: 0 0% 100%;
  --secondary: 240 5% 90%;
  --secondary-foreground: 240 10% 20%;
  --muted: 240 5% 88%;
  --muted-foreground: 240 5% 45%;
  --accent: 168 100% 42%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 100%;
  --border: 240 5% 85%;
  --input: 240 5% 85%;
  --ring: 168 100% 42%;
  --radius: 0.5rem;
  --border-width: 1px;
  --font-display: "JetBrains Mono", "IBM Plex Mono", monospace;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", "IBM Plex Mono", monospace;
  --section-py: 3.5rem;
  --card-p: 1.5rem;
  --motion-duration: 150ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 0 8px rgba(0,212,255,0.08);
  --shadow-md: 0 0 14px rgba(0,212,255,0.12);
  --shadow-elegant: 0 0 20px rgba(0,212,255,0.16);
  --shadow-glow: 0 0 20px rgba(0,212,255,0.2);
}

.dark {
  --background: 240 10% 3.9%;
  --foreground: 0 0% 92%;
  --card: 240 10% 7%;
  --card-foreground: 0 0% 92%;
  --popover: 240 10% 7%;
  --popover-foreground: 0 0% 92%;
  --primary: 168 100% 50%;
  --primary-foreground: 240 10% 3.9%;
  --secondary: 240 8% 12%;
  --secondary-foreground: 0 0% 75%;
  --muted: 240 8% 12%;
  --muted-foreground: 0 0% 50%;
  --accent: 168 100% 50%;
  --accent-foreground: 240 10% 3.9%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 240 8% 16%;
  --input: 240 8% 16%;
  --ring: 168 100% 50%;
  --shadow-sm: 0 0 8px rgba(0,212,255,0.1);
  --shadow-md: 0 0 14px rgba(0,212,255,0.15);
  --shadow-elegant: 0 0 20px rgba(0,212,255,0.2);
  --shadow-glow: 0 0 20px rgba(0,212,255,0.25);
}
```

## Theme-Specific Variables

```css
:root {
  --glow-color: 168 100% 50%;
}

.dark {
  --glow-color: 168 100% 50%;
}
```

## Non-Controlling Declaration

This theme does NOT control:
- Accent hue: The neon accent color (cyan vs green) should be configurable per project
- Code syntax highlighting: Syntax theme is controlled by the editor/highlighter, not the UI theme
