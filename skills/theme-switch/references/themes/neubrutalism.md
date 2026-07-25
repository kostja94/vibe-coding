# Neubrutalism

> Brutal + playful, the box model made visible and fun

## Philosophy

Neubrutalism takes the honest structural exposure of Brutalism and injects playfulness through bold color, hard-offset shadows, and chunky type. The box model becomes a visible, celebratory feature rather than something to hide. Interfaces feel tactile, clickable, and deliberately raw—but with joy instead of severity.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | thick-visible | 2-3px solid black, fully opaque |
| Shadow | hard-offset | 4px 4px 0 #000 (sm), 6px 6px 0 #000 (md) |
| Radius | sharp | 0px |
| Typography | chunky-sans | 800-900 headings, monospace labels, Inter/Satoshi body |
| Spacing | comfortable-compact | section-py 3-4rem, card-p 1.5-2rem |
| Grid | strict | 12-col, 1100px container |
| Motion | snappy | 100-150ms, ease-out, hover lifts shadow |
| Density | medium | line-height 1.5 |
| Elevation | hard-offset | shadows show stacking order |
| Color | flat-bold | bright flat colors (yellow, pink, teal) on off-white, no gradients |

## Compatible Brands

- Gumroad — creator platform with bold cards, thick borders, and playful offset shadows
- Figma Community — component cards that celebrate visible structure and vivid color
- Certain portfolio sites — personal sites that embrace the fun side of raw box-model aesthetics

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use hard-offset shadows that lift on hover | Apply soft blur shadows or drop shadows |
| Pick bright, flat, unapologetic colors | Use subtle gradients or pastel washes |
| Keep borders thick and fully opaque | Round corners or soften edges |
| Make interactions snappy and obvious | Add slow, cinematic transitions |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 96%;
  --foreground: 0 0% 5%;
  --card: 50 92% 62%;
  --card-foreground: 0 0% 5%;
  --popover: 0 0% 96%;
  --popover-foreground: 0 0% 5%;
  --primary: 326 78% 60%;
  --primary-foreground: 0 0% 100%;
  --secondary: 174 72% 46%;
  --secondary-foreground: 0 0% 5%;
  --muted: 0 0% 88%;
  --muted-foreground: 0 0% 35%;
  --accent: 50 92% 62%;
  --accent-foreground: 0 0% 5%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 0%;
  --input: 0 0% 0%;
  --ring: 326 78% 60%;
  --radius: 0px;
  --border-width: 2.5px;
  --font-display: "Satoshi", "Inter", sans-serif;
  --font-sans: "Inter", sans-serif;
  --font-mono: "JetBrains Mono", monospace;
  --section-py: 3.5rem;
  --card-p: 1.75rem;
  --motion-duration: 120ms;
  --motion-easing: ease-out;
  --shadow-sm: 4px 4px 0 hsl(0 0% 0%);
  --shadow-md: 6px 6px 0 hsl(0 0% 0%);
  --shadow-elegant: 6px 6px 0 hsl(0 0% 0%);
  --shadow-glow: none;
}

.dark {
  --background: 0 0% 8%;
  --foreground: 0 0% 95%;
  --card: 0 0% 14%;
  --card-foreground: 0 0% 95%;
  --popover: 0 0% 8%;
  --popover-foreground: 0 0% 95%;
  --primary: 326 78% 65%;
  --primary-foreground: 0 0% 100%;
  --secondary: 174 72% 52%;
  --secondary-foreground: 0 0% 5%;
  --muted: 0 0% 18%;
  --muted-foreground: 0 0% 65%;
  --accent: 50 92% 55%;
  --accent-foreground: 0 0% 5%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 90%;
  --input: 0 0% 90%;
  --ring: 326 78% 65%;
  --shadow-sm: 4px 4px 0 hsl(0 0% 25%);
  --shadow-md: 6px 6px 0 hsl(0 0% 25%);
  --shadow-elegant: 6px 6px 0 hsl(0 0% 25%);
  --shadow-glow: none;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Illustration style: hand-drawn vs. geometric illustration is independent
- Content voice: playful copy is complementary but not enforced
- Icon set: any bold, consistent icon set works
