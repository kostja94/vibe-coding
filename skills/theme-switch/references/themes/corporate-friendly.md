# Corporate Friendly

> Safe professionalism, designed to make work feel trustworthy

## Philosophy

Corporate Friendly prioritizes clarity and trust above all. Blue primaries, moderate radius, compact efficient spacing, and system-sans typography create a predictable interface that teams adopt without friction. Every choice signals reliability — nothing playful, nothing surprising, just work made comfortable.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | fine | 1px solid at low opacity |
| Shadow | medium-soft | 0 2px 4px rgba(0,0,0,0.08) |
| Radius | moderate | 0.5rem UI, 0.75rem cards |
| Typography | system-sans-professional | Inter/system sans, 400-600 weight, clear hierarchy |
| Spacing | compact-efficient | section-py 3-4rem, card-p 1.5-2rem |
| Grid | strict | 12-col, 1100-1200px |
| Motion | standard | 200ms, ease-out |
| Density | compact | line-height 1.5 |
| Elevation | subtle | shadow-sm default, shadow-md hover |
| Color | blue-primary-corporate | white bg, blue primary (210 100% 50%), gray muted tones |

## Compatible Brands

- Atlassian — blue-primary, compact efficient layouts, professional trust signals
- Salesforce — corporate blue with structured 12-col grid and moderate radius
- Microsoft 365 — system-sans clarity, blue accent, safe professional density

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use blue as primary | Don't use playful colors |
| Use moderate radius | Don't use extreme radius |
| Use clear hierarchy | Don't use decorative animations |
| Use compact layout | Don't use monospace for body |
| Use standard interactions | Don't use gradient backgrounds |

## Compiled CSS Variables

```css
:root {
  --background: 210 20% 98%;
  --foreground: 210 20% 14%;
  --card: 0 0% 100%;
  --card-foreground: 210 20% 14%;
  --popover: 0 0% 100%;
  --popover-foreground: 210 20% 14%;
  --primary: 210 100% 50%;
  --primary-foreground: 0 0% 100%;
  --secondary: 210 14% 93%;
  --secondary-foreground: 210 20% 14%;
  --muted: 210 14% 93%;
  --muted-foreground: 210 10% 45%;
  --accent: 210 14% 90%;
  --accent-foreground: 210 20% 14%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 100%;
  --border: 210 14% 88%;
  --input: 210 14% 88%;
  --ring: 210 100% 50%;
  --radius: 0.5rem;
  --border-width: 1px;
  --font-display: "Inter", system-ui, -apple-system, sans-serif;
  --font-sans: "Inter", system-ui, -apple-system, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --section-py: 3.5rem;
  --card-p: 1.75rem;
  --motion-duration: 200ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-md: 0 2px 4px rgba(0,0,0,0.08);
  --shadow-elegant: 0 4px 12px rgba(0,0,0,0.08);
  --shadow-glow: 0 0 0 0 transparent;
}

.dark {
  --background: 210 20% 10%;
  --foreground: 210 14% 93%;
  --card: 210 16% 15%;
  --card-foreground: 210 14% 93%;
  --popover: 210 16% 15%;
  --popover-foreground: 210 14% 93%;
  --primary: 210 90% 55%;
  --primary-foreground: 0 0% 100%;
  --secondary: 210 12% 22%;
  --secondary-foreground: 210 14% 90%;
  --muted: 210 12% 22%;
  --muted-foreground: 210 8% 58%;
  --accent: 210 12% 24%;
  --accent-foreground: 210 14% 90%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 210 12% 24%;
  --input: 210 12% 24%;
  --ring: 210 90% 55%;
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.25);
  --shadow-md: 0 2px 4px rgba(0,0,0,0.3);
  --shadow-elegant: 0 4px 12px rgba(0,0,0,0.3);
  --shadow-glow: 0 0 0 0 transparent;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Data visualization palette: Charts and graphs may require additional categorical colors beyond the blue primary
- Form field internals: Input validation states and error messaging patterns follow their own accessibility requirements
