# Notion-core

> Productivity zen, the interface of organized thinking

## Philosophy

Notion-core strips away every visual distraction until only structured thought remains. Flat surfaces, serif headings on a document-width column, and hover-highlighted blocks create an environment where reading and writing feel natural. The interface disappears so the content can breathe.

## 10-Dimensional Profile

| Dimension | Direction | Range/Value |
|---|---|---|
| Border | minimal | 1px solid at very low opacity, or none |
| Shadow | none-or-barely-there | 0 1px 2px rgba(0,0,0,0.03) |
| Radius | minimal-or-none | 0-4px, sharp containers |
| Typography | serif-headings-sans-body | Charter/Lora for headings (400, 700), Inter for body (400, 500) |
| Spacing | structured-breathing | section-py 4-5rem, card-p 1.5-2rem, line-height 1.7 |
| Grid | narrow-centered | max-width 720px, single column like a document |
| Motion | subtle | 200ms, ease-out, toggle-like expand/collapse |
| Density | comfortable | line-height 1.7 |
| Elevation | flat | no shadows, hover background highlight |
| Color | warm-neutral | off-white bg #FFFFFF, Notion dark text #37352F (30 6% 20%), muted #9B9A97, accent #2EAADC |

## Compatible Brands

- Notion — the canonical reference: block-based, serif headings, flat hover highlights
- Obsidian — knowledge graph UI with document-centric, warm-neutral reading experience
- Personal wikis and knowledge bases — long-form reading with structured block editing

## Do's and Don'ts

| ✅ Do | ❌ Don't |
|---|---|
| Use block-based layout | Don't use shadows |
| Use serif headings | Don't use gradient backgrounds |
| Use narrow column | Don't use wide layouts |
| Use hover highlight blocks | Don't use rounded cards |
| Use inline property tables | Don't use decorative elements |

## Compiled CSS Variables

```css
:root {
  --background: 0 0% 100%;
  --foreground: 30 6% 20%;
  --card: 0 0% 100%;
  --card-foreground: 30 6% 20%;
  --popover: 0 0% 100%;
  --popover-foreground: 30 6% 20%;
  --primary: 30 6% 20%;
  --primary-foreground: 0 0% 100%;
  --secondary: 30 10% 95%;
  --secondary-foreground: 30 6% 20%;
  --muted: 30 10% 94%;
  --muted-foreground: 30 3% 60%;
  --accent: 196 74% 52%;
  --accent-foreground: 0 0% 100%;
  --destructive: 0 72% 51%;
  --destructive-foreground: 0 0% 100%;
  --border: 30 10% 90%;
  --input: 30 10% 90%;
  --ring: 196 74% 52%;
  --radius: 0.25rem;
  --border-width: 1px;
  --font-display: "Lora", "Charter", Georgia, serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --section-py: 4.5rem;
  --card-p: 1.75rem;
  --motion-duration: 200ms;
  --motion-easing: ease-out;
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.03);
  --shadow-md: 0 1px 2px rgba(0,0,0,0.03);
  --shadow-elegant: none;
  --shadow-glow: none;
}

.dark {
  --background: 0 0% 10%;
  --foreground: 30 10% 88%;
  --card: 0 0% 12%;
  --card-foreground: 30 10% 88%;
  --popover: 0 0% 12%;
  --popover-foreground: 30 10% 88%;
  --primary: 30 10% 88%;
  --primary-foreground: 0 0% 10%;
  --secondary: 30 8% 18%;
  --secondary-foreground: 30 10% 88%;
  --muted: 30 8% 18%;
  --muted-foreground: 30 5% 50%;
  --accent: 196 74% 55%;
  --accent-foreground: 0 0% 10%;
  --destructive: 0 72% 55%;
  --destructive-foreground: 0 0% 100%;
  --border: 30 8% 20%;
  --input: 30 8% 20%;
  --ring: 196 74% 55%;
  --shadow-sm: none;
  --shadow-md: none;
  --shadow-elegant: none;
  --shadow-glow: none;
}
```

## Theme-Specific Variables

None

## Non-Controlling Declaration

This theme does NOT control:
- Block type rendering: Notion-core defines the surface aesthetic, not how specific block types (toggle, callout, embed) render internally
- Sidebar chrome: Sidebar navigation may follow its own interaction patterns independent of the document column
