# Fashion Luxury

> Emptiness is luxury, restraint communicates exclusivity

## Philosophy

Fashion Luxury communicates through what it withholds. Extreme whitespace, thin serif type, and a near-monochrome palette with a single gold accent create an atmosphere of curated exclusivity. Every element earns its place; nothing is decorative. Slow transitions and generous vertical rhythm make the experience feel considered and unhurried.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | none-or-hairline | 0px or 1px at very low opacity |
| Shadow | elegant-minimal | 0 10px 30px -12px rgba(0,0,0,0.1) |
| Radius | subtle | 0.25rem-0.5rem (barely rounded) |
| Typography | thin-serif | Playfair Display/Didot thin (300) for headings, Inter light (300-400) for body |
| Spacing | extreme-generous | section-py 8-10rem, card-p 3rem |
| Grid | clean-centered-narrow | 900-1000px, single column, extreme whitespace |
| Motion | slow-luxury | 400-600ms, ease-in-out, slow fade-ins |
| Density | very-low | line-height 1.8 |
| Elevation | elegant-minimal | very subtle shadows only on interactive elements |
| Color | bw-gold | white/off-white bg, near-black text, gold accent #C9A96E (40 50% 60%) |

## Compatible Brands

- Vogue — editorial luxury with thin serif type and extreme whitespace
- Aesop — restrained palette, considered spacing, slow unhurried interaction
- Balenciaga — near-monochrome with subtle gold, fashion-forward minimalism

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use extreme whitespace | Don't use bright colors |
| Use thin serif type | Don't use heavy weights |
| Use minimal color palette | Don't crowd the viewport |
| Use slow transitions | Don't use fast animations |
| Use generous vertical rhythm | Don't use rounded pill buttons |

## Compiled CSS Variables

```css
:root {
  --background: 40 20% 97%;
  --foreground: 40 5% 10%;
  --card: 0 0% 100%;
  --card-foreground: 40 5% 10%;
  --popover: 0 0% 100%;
  --popover-foreground: 40 5% 10%;
  --primary: 40 50% 60%;
  --primary-foreground: 0 0% 100%;
  --secondary: 40 10% 92%;
  --secondary-foreground: 40 5% 10%;
  --muted: 40 8% 93%;
  --muted-foreground: 40 4% 52%;
  --accent: 40 50% 60%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 50% 45%;
  --destructive-foreground: 0 0% 100%;
  --border: 40 10% 90%;
  --input: 40 10% 90%;
  --ring: 40 50% 60%;
  --radius: 0.375rem;
  --border-width: 0px;
  --font-display: "Playfair Display", "Didot", Georgia, serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --section-py: 9rem;
  --card-p: 3rem;
  --motion-duration: 500ms;
  --motion-easing: ease-in-out;
  --shadow-sm: 0 2px 8px -2px rgba(0,0,0,0.04);
  --shadow-md: 0 10px 30px -12px rgba(0,0,0,0.1);
  --shadow-elegant: 0 16px 48px -16px rgba(0,0,0,0.12);
  --shadow-glow: 0 0 0 0 transparent;
}

.dark {
  --background: 0 0% 5%;
  --foreground: 40 10% 92%;
  --card: 0 0% 8%;
  --card-foreground: 40 10% 92%;
  --popover: 0 0% 8%;
  --popover-foreground: 40 10% 92%;
  --primary: 40 50% 60%;
  --primary-foreground: 0 0% 5%;
  --secondary: 0 0% 14%;
  --secondary-foreground: 40 10% 90%;
  --muted: 0 0% 14%;
  --muted-foreground: 40 5% 55%;
  --accent: 40 50% 62%;
  --accent-foreground: 0 0% 5%;
  --destructive: 0 50% 50%;
  --destructive-foreground: 0 0% 100%;
  --border: 0 0% 16%;
  --input: 0 0% 16%;
  --ring: 40 50% 62%;
  --shadow-sm: 0 2px 8px -2px rgba(0,0,0,0.3);
  --shadow-md: 0 10px 30px -12px rgba(0,0,0,0.4);
  --shadow-elegant: 0 16px 48px -16px rgba(0,0,0,0.45);
  --shadow-glow: 0 0 0 0 transparent;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Product photography treatment: Image aspect ratios, filters, and overlays are content decisions outside the theme's scope
- E-commerce interaction flows: Cart, checkout, and size-selector patterns follow their own UX requirements
