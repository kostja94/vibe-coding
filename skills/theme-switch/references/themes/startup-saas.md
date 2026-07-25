# Startup SaaS

> Credibility by default, the Stripe/Vercel look that signals "serious tech company"

## Philosophy

Startup SaaS borrows the visual language of the most trusted developer-infrastructure brands to project credibility from day one. Clean sans-serif type, pill-shaped CTAs, soft shadows, and an indigo-to-purple gradient create an instantly recognizable signal of modern, well-funded technology. The system is designed to look expensive and trustworthy without requiring a design team.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | fine | 1px solid at low opacity |
| Shadow | soft | 0 1px 3px rgba(0,0,0,0.1) |
| Radius | pill-CTAs | 0.75rem general, 9999px for CTA buttons |
| Typography | one-font-sans | Inter only, 400-700 |
| Spacing | comfortable-generous | section-py 5-6rem, card-p 2rem |
| Grid | clean-centered | 1100px max-width |
| Motion | subtle | 200ms, ease-out |
| Density | comfortable | line-height 1.6 |
| Elevation | subtle | standard soft shadows |
| Color | indigo-purple-gradient | white/#F8FAFC alternating bg, indigo #6366F1 primary, purple #8B5CF6 secondary |

## Compatible Brands

- Stripe — the gold standard for SaaS credibility: clean, gradient-accented, trustworthy
- Vercel — developer platform with premium polish and restrained color
- Raycast — productivity tool with sharp hierarchy and confident use of indigo
- Linear — project management that proves minimal can feel premium

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use the gradient on primary CTAs and key headings | Apply gradient to body text or small UI elements |
| Keep surfaces white or very light with soft elevation | Use heavy borders or hard shadows |
| Use pill-shaped buttons for primary actions | Mix too many accent colors beyond indigo/purple |
| Maintain generous spacing between sections | Cramp content to fit above the fold |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 100%;
  --foreground: 229 25% 8%;
  --card: 0 0% 100%;
  --card-foreground: 229 25% 8%;
  --popover: 0 0% 100%;
  --popover-foreground: 229 25% 8%;
  --primary: 239 84% 67%;
  --primary-foreground: 0 0% 100%;
  --secondary: 258 90% 66%;
  --secondary-foreground: 0 0% 100%;
  --muted: 210 20% 96%;
  --muted-foreground: 229 15% 42%;
  --accent: 239 84% 95%;
  --accent-foreground: 239 84% 40%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 229 20% 90%;
  --input: 229 20% 90%;
  --ring: 239 84% 67%;
  --radius: 0.75rem;
  --border-width: 1px;
  --font-display: "Inter", sans-serif;
  --font-sans: "Inter", sans-serif;
  --font-mono: "JetBrains Mono", monospace;
  --section-py: 5.5rem;
  --card-p: 2rem;
  --motion-duration: 200ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --shadow-elegant: 0 8px 30px rgba(0, 0, 0, 0.08);
  --shadow-glow: 0 0 20px rgba(99, 102, 241, 0.15);
}

.dark {
  --background: 229 25% 6%;
  --foreground: 229 25% 92%;
  --card: 229 20% 9%;
  --card-foreground: 229 25% 92%;
  --popover: 229 20% 9%;
  --popover-foreground: 229 25% 92%;
  --primary: 239 84% 70%;
  --primary-foreground: 0 0% 100%;
  --secondary: 258 90% 70%;
  --secondary-foreground: 0 0% 100%;
  --muted: 229 15% 14%;
  --muted-foreground: 229 15% 58%;
  --accent: 239 84% 14%;
  --accent-foreground: 239 84% 80%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 229 15% 18%;
  --input: 229 15% 18%;
  --ring: 239 84% 70%;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.3);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.4);
  --shadow-elegant: 0 8px 30px rgba(0, 0, 0, 0.3);
  --shadow-glow: 0 0 20px rgba(99, 102, 241, 0.2);
}
```

## Theme-Specific Variables

```css
:root {
  --gradient-primary: linear-gradient(135deg, #6366F1, #8B5CF6);
}
.dark {
  --gradient-primary: linear-gradient(135deg, #7577F5, #9B72FA);
}
```

## Non-Controlling Declaration

This theme does NOT control:
- Pricing table layout: data presentation structure is independent
- Illustration style: spot illustrations may be 3D, flat, or abstract
- Navigation pattern: top nav, sidebar, or hybrid are all compatible
