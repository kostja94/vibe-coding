# Cyberpunk

> Neon wasteland, dystopian terminal UI, the screen as a cracked HUD

## Philosophy

The cyberpunk aesthetic treats the interface as a heads-up display from a broken future — equal parts functional telemetry and dystopian spectacle. Neon glows bleed through cracks in dark surfaces, angular cut corners replace smooth radius, and every element hums with the tension of technology on the edge of collapse. This is UI as world-building: the screen itself becomes a character.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | neon-edged | 1px solid with neon glow |
| Shadow | neon-glow | 0 0 15px rgba(accent,0.5) |
| Radius | cut-corner | 0px (use clip-path polygon for angled corners instead) |
| Typography | angular-condensed | Rajdhani/Space Grotesk for headings, Share Tech Mono/IBM Plex Mono for body |
| Spacing | compact-dense | section-py 3-4rem, card-p 1.5rem |
| Grid | asymmetric | variable spans, 1200px |
| Motion | glitch-expressive | 200-400ms, includes glitch effects via CSS transform |
| Density | compact | line-height 1.5 |
| Elevation | glow-heavy | strong neon glow shadows, scanline overlay |
| Color | neon-tricolor | near-black bg, cyan #00FFFF primary, magenta #FF00FF accent, yellow #FFD700 highlights |

## Compatible Brands

- Cyberpunk 2077 UI — source material for the aesthetic, neon tricolor on dark
- Gaming sites — RGB-forward, high-impact, HUD-style layouts
- Sci-fi projects — dystopian terminal aesthetics with glitch and glow

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use neon glow borders and shadows on key elements | Don't use rounded corners — use clip-path cut corners |
| Use monospace type for body and condensed angular faces for headings | Don't use soft drop shadows or traditional elevation |
| Apply scanline overlay for CRT texture | Don't use pastel colors or soft sans-serif body text |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 95%;
  --foreground: 270 10% 10%;
  --card: 0 0% 100%;
  --card-foreground: 270 10% 10%;
  --popover: 0 0% 100%;
  --popover-foreground: 270 10% 10%;
  --primary: 180 100% 50%;
  --primary-foreground: 270 100% 5%;
  --secondary: 300 100% 50%;
  --secondary-foreground: 0 0% 100%;
  --muted: 270 5% 90%;
  --muted-foreground: 270 5% 40%;
  --accent: 300 100% 50%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 100% 50%;
  --destructive-foreground: 0 0% 100%;
  --border: 270 5% 82%;
  --input: 270 5% 82%;
  --ring: 180 100% 50%;
  --radius: 0px;
  --border-width: 1px;
  --font-display: "Rajdhani", "Space Grotesk", sans-serif;
  --font-sans: "Share Tech Mono", "IBM Plex Mono", monospace;
  --font-mono: "Share Tech Mono", "IBM Plex Mono", monospace;
  --section-py: 3.5rem;
  --card-p: 1.5rem;
  --motion-duration: 300ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 0 8px rgba(0,255,255,0.15);
  --shadow-md: 0 0 12px rgba(0,255,255,0.25);
  --shadow-elegant: 0 0 15px rgba(255,0,255,0.3);
  --shadow-glow: 0 0 15px rgba(0,255,255,0.5);
}

.dark {
  --background: 270 20% 5%;
  --foreground: 180 100% 85%;
  --card: 270 15% 8%;
  --card-foreground: 180 100% 85%;
  --popover: 270 15% 8%;
  --popover-foreground: 180 100% 85%;
  --primary: 180 100% 50%;
  --primary-foreground: 270 20% 5%;
  --secondary: 300 100% 50%;
  --secondary-foreground: 0 0% 100%;
  --muted: 270 10% 14%;
  --muted-foreground: 180 15% 50%;
  --accent: 300 100% 50%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 100% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 180 30% 20%;
  --input: 180 30% 20%;
  --ring: 180 100% 50%;
  --shadow-sm: 0 0 8px rgba(0,255,255,0.2);
  --shadow-md: 0 0 12px rgba(0,255,255,0.3);
  --shadow-elegant: 0 0 15px rgba(255,0,255,0.35);
  --shadow-glow: 0 0 15px rgba(0,255,255,0.5);
}
```

## Theme-Specific Variables

```css
:root {
  --glow-color: 180 100% 50%;
  --scanline-opacity: 0.03;
  --clip-corner: polygon(0 0, calc(100% - 12px) 0, 100% 12px, 100% 100%, 12px 100%, 0 calc(100% - 12px));
}

.dark {
  --glow-color: 180 100% 50%;
  --scanline-opacity: 0.03;
  --clip-corner: polygon(0 0, calc(100% - 12px) 0, 100% 12px, 100% 100%, 12px 100%, 0 calc(100% - 12px));
}
```

## Non-Controlling Declaration

This theme does NOT control:
- Clip-path values: Cut-corner sizes should be adjusted per component context
- Glitch animation: Implementation depends on the animation library and may require JS-driven effects
