# SEO Migration Templates

## 1. Root Layout Template

```tsx
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { Navigation } from "@/components/layout/Navigation";
import { Footer } from "@/components/layout/Footer";

const inter = Inter({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-inter",
});

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || "https://example.com"),
  title: {
    template: "%s | BRAND_NAME",
    default: "BRAND_NAME — Tagline Here",
  },
  description: "Brand description for SEO, under 160 characters.",
  openGraph: {
    type: "website",
    locale: "en_US",
    url: process.env.NEXT_PUBLIC_SITE_URL,
    siteName: "BRAND_NAME",
    title: {
      template: "%s | BRAND_NAME",
      default: "BRAND_NAME — Tagline Here",
    },
    description: "Brand description for SEO, under 160 characters.",
    images: [
      {
        url: "/og.png",
        width: 1200,
        height: 630,
        alt: "BRAND_NAME",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "BRAND_NAME — Tagline Here",
    description: "Brand description for SEO, under 160 characters.",
    images: ["/og.png"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={inter.variable}>
      <body className="min-h-screen flex flex-col">
        <Navigation />
        <main className="flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
```

---

## 2. Static Page Metadata Template

```tsx
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Page Title",
  description: "Page description for search engines, 150-160 characters recommended.",
  alternates: {
    canonical: "/page-slug",
  },
  openGraph: {
    title: "Page Title",
    description: "Page description for social sharing.",
    images: ["/og-page.png"],
    url: "/page-slug",
  },
};

export default function StaticPage() {
  return (
    <>
      <h1>Page Title</h1>
      {/* page content */}
    </>
  );
}
```

---

## 3. Dynamic Page Metadata Template

Next.js 16 / React 19 — `params` is synchronous, NOT a Promise.

```tsx
import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getItemBySlug } from "@/lib/api";

interface PageProps {
  params: { slug: string };
}

export function generateMetadata({ params }: PageProps): Metadata {
  const item = getItemBySlug(params.slug);
  if (!item) return { title: "Not Found" };

  return {
    title: item.title,
    description: item.description,
    alternates: {
      canonical: `/items/${params.slug}`,
    },
    openGraph: {
      title: item.title,
      description: item.description,
      images: [item.image],
      url: `/items/${params.slug}`,
      type: "article",
    },
  };
}

export async function generateStaticParams() {
  const items = await getAllItems();
  return items.map((item) => ({ slug: item.slug }));
}

export default function DynamicPage({ params }: PageProps) {
  const item = getItemBySlug(params.slug);
  if (!item) notFound();

  return (
    <article>
      <h1>{item.title}</h1>
      <p>{item.description}</p>
    </article>
  );
}
```

---

## 4. JSON-LD Templates

### 4.1 Organization Schema (All Projects)

```tsx
function OrganizationJsonLd() {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Organization",
    name: "BRAND_NAME",
    url: process.env.NEXT_PUBLIC_SITE_URL,
    logo: `${process.env.NEXT_PUBLIC_SITE_URL}/logo.png`,
    description: "Brand description.",
    sameAs: [
      "https://twitter.com/brand",
      "https://github.com/brand",
      "https://linkedin.com/company/brand",
    ],
    contactPoint: {
      "@type": "ContactPoint",
      contactType: "customer support",
      email: "support@brand.com",
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.2 WebSite Schema (All Projects)

```tsx
function WebSiteJsonLd() {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "BRAND_NAME",
    url: process.env.NEXT_PUBLIC_SITE_URL,
    potentialAction: {
      "@type": "SearchAction",
      target: {
        "@type": "EntryPoint",
        urlTemplate: `${process.env.NEXT_PUBLIC_SITE_URL}/search?q={search_term_string}`,
      },
      "query-input": "required name=search_term_string",
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.3 Person Schema (Personal Brands)

```tsx
function PersonJsonLd() {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Person",
    name: "Full Name",
    url: process.env.NEXT_PUBLIC_SITE_URL,
    jobTitle: "Job Title",
    sameAs: [
      "https://twitter.com/username",
      "https://github.com/username",
      "https://linkedin.com/in/username",
    ],
    image: `${process.env.NEXT_PUBLIC_SITE_URL}/photo.jpg`,
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.4 Product Schema (Product Landing Pages)

```tsx
function ProductJsonLd({ product }: { product: { name: string; description: string; price: number; image: string } }) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    description: product.description,
    image: product.image,
    offers: {
      "@type": "Offer",
      price: product.price,
      priceCurrency: "USD",
      availability: "https://schema.org/InStock",
      url: process.env.NEXT_PUBLIC_SITE_URL,
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.5 FAQPage Schema (FAQ Sections)

```tsx
function FaqJsonLd({ faqs }: { faqs: { question: string; answer: string }[] }) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: faqs.map((faq) => ({
      "@type": "Question",
      name: faq.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: faq.answer,
      },
    })),
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.6 BreadcrumbList Schema (Deep Pages)

```tsx
function BreadcrumbJsonLd({ items }: { items: { name: string; url: string }[] }) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items.map((item, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: item.name,
      item: item.url,
    })),
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### 4.7 Article / BlogPosting Schema (Blog Posts)

```tsx
function ArticleJsonLd({
  title,
  description,
  url,
  image,
  datePublished,
  dateModified,
  authorName,
}: {
  title: string;
  description: string;
  url: string;
  image: string;
  datePublished: string;
  dateModified: string;
  authorName: string;
}) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: title,
    description,
    url,
    image,
    datePublished,
    dateModified,
    author: {
      "@type": "Person",
      name: authorName,
    },
    publisher: {
      "@type": "Organization",
      name: "BRAND_NAME",
      logo: {
        "@type": "ImageObject",
        url: `${process.env.NEXT_PUBLIC_SITE_URL}/logo.png`,
      },
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

---

## 5. robots.ts Template

```ts
import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://example.com";

  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: ["/api/", "/_next/"],
      },
    ],
    sitemap: `${siteUrl}/sitemap.xml`,
  };
}
```

---

## 6. sitemap.ts Template

### 6.1 Static + Dynamic Routes

```ts
import type { MetadataRoute } from "next";

export default async function sitemap(): MetadataRoute.Sitemap {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://example.com";

  const staticRoutes: MetadataRoute.Sitemap = [
    { url: siteUrl, lastModified: new Date(), changeFrequency: "weekly", priority: 1.0 },
    { url: `${siteUrl}/about`, lastModified: new Date(), changeFrequency: "monthly", priority: 0.8 },
    { url: `${siteUrl}/pricing`, lastModified: new Date(), changeFrequency: "monthly", priority: 0.8 },
    { url: `${siteUrl}/legal/privacy`, lastModified: new Date(), changeFrequency: "yearly", priority: 0.3 },
    { url: `${siteUrl}/legal/terms`, lastModified: new Date(), changeFrequency: "yearly", priority: 0.3 },
  ];

  const dynamicSlugs = await getDynamicSlugs();
  const dynamicRoutes: MetadataRoute.Sitemap = dynamicSlugs.map((slug) => ({
    url: `${siteUrl}/use-cases/${slug}`,
    lastModified: new Date(),
    changeFrequency: "weekly",
    priority: 0.6,
  }));

  return [...staticRoutes, ...dynamicRoutes];
}

async function getDynamicSlugs(): Promise<string[]> {
  // Fetch from CMS, database, or static data
  return ["voice-changer", "image-upscaler", "bg-remover"];
}
```

---

## 7. SEO Metadata Mapping Table

| Lovable (Original) | Next.js (Target) | Notes |
|---------------------|------------------|-------|
| `<Helmet><title>X</title></Helmet>` | `metadata.title = "X"` | Or `generateMetadata` for dynamic |
| `<meta name="description" content="X">` | `metadata.description = "X"` | |
| `<meta property="og:title" content="X">` | `metadata.openGraph.title = "X"` | |
| `<meta property="og:description" content="X">` | `metadata.openGraph.description = "X"` | |
| `<meta property="og:image" content="X">` | `metadata.openGraph.images = ["X"]` | Array of strings or objects |
| `<meta property="og:url" content="X">` | `metadata.openGraph.url = "X"` | |
| `<meta property="og:type" content="X">` | `metadata.openGraph.type = "X"` | |
| `<meta name="twitter:card" content="X">` | `metadata.twitter.card = "X"` | |
| `<link rel="canonical" href="X">` | `metadata.alternates.canonical = "X"` | Relative path or full URL |
| TanStack `head()` → `meta.title` | `metadata.title` | |
| TanStack `head()` → `meta.name=description` | `metadata.description` | |
| TanStack `head()` → `meta.property=og:*` | `metadata.openGraph.*` | |
| `<script type="application/ld+json">` | Same in Next.js | Keep as-is; works in Server Components |
| `robots.txt` file | `app/robots.ts` | Programmatic generation |
| `sitemap.xml` file | `app/sitemap.ts` | Programmatic generation |
| `<html lang="en">` | `<html lang="en">` in root layout | Keep; add font variable className |
| `<meta name="viewport">` | Auto-injected by Next.js | Remove from manual head |
| `<meta charset="UTF-8">` | Auto-injected by Next.js | Remove from manual head |
