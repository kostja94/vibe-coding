# Bento Grid

> Modular order, every module knows its place, calm organization

## Philosophy

Bento Grid treats the page as a curated collection of self-contained modules. Each cell is a quiet, confident container that relies on subtle elevation rather than borders or decoration. The layout itself does the talking — asymmetric grid cells with generous radius create a sense of calm organization where content breathes.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | borderless | no visible borders, elevation defines edges |
| Shadow | barely-there | 0 2px 8px rgba(0,0,0,0.06) |
| Radius | generous | 1.25rem (20px) on cells |
| Typography | quiet-confident | Inter 400-600, no heavy display type, let layout do the talking |
| Spacing | comfortable | section-py 4-5rem, card-p 2-2.5rem, gap 12-16px between cells |
| Grid | asymmetric | CSS grid with grid-template-areas, variable span cells, 1200px |
| Motion | subtle | 200ms, ease-out, smooth hover lifts |
| Density | comfortable | line-height 1.6 |
| Elevation | subtle-float | barely perceptible shadow creates gentle lift |
| Color | calm-neutral | warm gray bg #F5F5F7 (220 14% 96%), white cards #FFFFFF, dark text #1D1D1F (0 0% 12%) |

## Compatible Brands

- Apple product pages — modular feature blocks with generous radius and quiet confidence
- Linear feature sections — asymmetric grid cells with clean elevation and calm palette
- Notion dashboard — self-contained card modules in a grid with no borders

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use asymmetric grid cells | Don't use borders |
| Use generous radius | Don't use heavy display type |
| Use self-contained modules | Don't use high-saturation colors |
| Use quiet typography | Don't force equal-width cells |

## Compiled CSS Variables

```css
:root {
  --background: 220 14% 96%;
  --foreground: 0 0% 12%;
  --card: 0 0% 100%;
  --card-foreground: 0 0% 12%;
  --popover: 0 0% 100%;
  --popover-foreground: 0 0% 12%;
  --primary: 220 14% 20%;
  --primary-foreground: 0 0% 98%;
  --secondary: 220 10% 92%;
  --secondary-foreground: 220 14% 20%;
  --muted: 220 10% 92%;
  --muted-foreground: 220 8% 46%;
  --accent: 220 10% 88%;
  --accent-foreground: 220 14% 20%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 98%;
  --border: 220 10% 90%;
  --input: 220 10% 90%;
  --ring: 220 14% 40%;
  --radius: 1.25rem;
  --border-width: 0px;
  --font-display: "Inter", system-ui, sans-serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --section-py: 5rem;
  --card-p: 2.25rem;
  --motion-duration: 200ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 1px 4px rgba(0,0,0,0.04);
  --shadow-md: 0 2px 8px rgba(0,0,0,0.06);
  --shadow-elegant: 0 4px 16px rgba(0,0,0,0.06);
  --shadow-glow: 0 0 0 0 transparent;
}

.dark {
  --background: 220 14% 10%;
  --foreground: 220 14% 93%;
  --card: 220 12% 15%;
  --card-foreground: 220 14% 93%;
  --popover: 220 12% 15%;
  --popover-foreground: 220 14% 93%;
  --primary: 220 14% 90%;
  --primary-foreground: 220 14% 10%;
  --secondary: 220 10% 20%;
  --secondary-foreground: 220 14% 90%;
  --muted: 220 10% 20%;
  --muted-foreground: 220 8% 60%;
  --accent: 220 10% 22%;
  --accent-foreground: 220 14% 90%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 98%;
  --border: 220 10% 22%;
  --input: 220 10% 22%;
  --ring: 220 14% 60%;
  --shadow-sm: 0 1px 4px rgba(0,0,0,0.2);
  --shadow-md: 0 2px 8px rgba(0,0,0,0.25);
  --shadow-elegant: 0 4px 16px rgba(0,0,0,0.25);
  --shadow-glow: 0 0 0 0 transparent;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Content structure: Bento grid defines the container aesthetic, not the content hierarchy within each cell
- Icon style: Icons within cells may follow any consistent set (outline, filled, duotone)
