# Minimal

> Less but better, strip away until only the essential remains

## Philosophy

Minimalism removes every element that does not directly serve the user's intent. Borders vanish into whitespace, shadows whisper rather than shout, and color is restrained to a single muted accent against a near-white canvas. The interface recedes so the content can speak. Every remaining element carries deliberate weight.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | fine-or-none | 1px solid at low opacity or none |
| Shadow | subtle | soft small blur (0 1px 2px rgba(0,0,0,0.05)) |
| Radius | smooth | 0.75rem UI, 1rem cards |
| Typography | geometric-sans | Inter/Geist Sans, heading 600-700, body 400 |
| Spacing | comfortable | section-py 5-6rem, card-p 2rem |
| Grid | clean-centered | 1100px, single column |
| Motion | subtle-micro | 150-200ms, ease-out, barely visible |
| Density | comfortable | line-height 1.6 |
| Elevation | subtle | shadow-sm default, shadow-md on hover |
| Color | grayscale-accent | near-white bg, 1 muted accent color |

## Compatible Brands

- Linear — project management with surgical precision and zero visual noise
- Apple — the benchmark for restraint: space, type, and nothing else
- Notion — content-first interface where chrome disappears into the page
- Figma — tool UI that stays out of the way of the work

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use generous whitespace as the primary separator | Add decorative borders or dividers |
| Keep one muted accent and commit to it | Introduce multiple accent colors |
| Let typography and spacing do the visual work | Rely on shadows or color for hierarchy |
| Make transitions imperceptibly smooth | Add attention-grabbing animations |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 100%;
  --foreground: 0 0% 9%;
  --card: 0 0% 100%;
  --card-foreground: 0 0% 9%;
  --popover: 0 0% 100%;
  --popover-foreground: 0 0% 9%;
  --primary: 220 14% 46%;
  --primary-foreground: 0 0% 100%;
  --secondary: 0 0% 96%;
  --secondary-foreground: 0 0% 9%;
  --muted: 0 0% 96%;
  --muted-foreground: 0 0% 45%;
  --accent: 220 14% 96%;
  --accent-foreground: 0 0% 9%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 90%;
  --input: 0 0% 90%;
  --ring: 220 14% 46%;
  --radius: 0.75rem;
  --border-width: 1px;
  --font-display: "Inter", "Geist Sans", sans-serif;
  --font-sans: "Inter", sans-serif;
  --font-mono: "Geist Mono", monospace;
  --section-py: 5.5rem;
  --card-p: 2rem;
  --motion-duration: 175ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
  --shadow-elegant: 0 8px 30px rgba(0, 0, 0, 0.04);
  --shadow-glow: none;
}

.dark {
  --background: 0 0% 5%;
  --foreground: 0 0% 91%;
  --card: 0 0% 5%;
  --card-foreground: 0 0% 91%;
  --popover: 0 0% 5%;
  --popover-foreground: 0 0% 91%;
  --primary: 220 14% 58%;
  --primary-foreground: 0 0% 100%;
  --secondary: 0 0% 12%;
  --secondary-foreground: 0 0% 91%;
  --muted: 0 0% 12%;
  --muted-foreground: 0 0% 55%;
  --accent: 220 14% 12%;
  --accent-foreground: 0 0% 91%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 16%;
  --input: 0 0% 16%;
  --ring: 220 14% 58%;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.2);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.25);
  --shadow-elegant: 0 8px 30px rgba(0, 0, 0, 0.15);
  --shadow-glow: none;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Content structure: information architecture is independent of visual minimalism
- Imagery treatment: photography style is not prescribed
- Interaction patterns: gesture and navigation models are out of scope
