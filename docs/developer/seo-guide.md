---
title: SEO Optimization Guide
description: Guide for optimizing documentation pages for search engines and social media
---

# SEO Optimization Guide

This guide explains the SEO optimizations implemented in the OpenMetadata Standards documentation.

## Implemented SEO Features

### 1. Meta Tags

All pages include comprehensive meta tags:

- **Basic Meta Tags**: charset, viewport, description, author, language
- **Open Graph Tags**: For social media sharing (Facebook, LinkedIn)
- **Twitter Card Tags**: Enhanced Twitter previews
- **Keywords**: Relevant keywords for search categorization

### 2. Structured Data (JSON-LD)

Structured data helps search engines understand our content:

- **WebSite Schema**: Site-level information with search action
- **TechArticle Schema**: Page-level documentation markup
- **Organization Schema**: OpenMetadata Community information

### 3. Social Media Optimization

Enhanced social media sharing:

- Open Graph images (1200x630px recommended)
- Twitter Card support with large image preview
- Social media profile links

### 4. Technical SEO

- **Sitemap**: Auto-generated `sitemap.xml` at the root
- **Robots.txt**: Search engine crawling instructions
- **Canonical URLs**: Prevents duplicate content issues
- **Clean URLs**: Directory-based URLs for better readability
- **HTML Minification**: Faster page loads
- **Mobile Responsive**: Mobile-first design

### 5. Content SEO

- **Semantic HTML**: Proper heading hierarchy
- **Alt Text**: Images with descriptive alt attributes
- **Internal Linking**: Well-structured navigation
- **Breadcrumbs**: Clear page hierarchy

## Adding Page-Specific SEO

To optimize individual pages, add front matter at the top of your markdown files:

```yaml
---
title: Your Page Title - OpenMetadata Standards
description: A compelling description of this page (150-160 characters)
keywords: keyword1, keyword2, keyword3, keyword4
---

# Your Page Title
```

### Example

```yaml
---
title: Data Lineage - OpenMetadata Standards
description: Learn how OpenMetadata Standards defines data lineage schemas for tracking data flow across pipelines, transformations, and analytics.
keywords: data lineage, lineage tracking, data flow, ETL lineage, data observability, OpenMetadata
---

# Data Lineage
```

### Common Keywords by Topic

Use these keywords based on your page topic:

- **Data Governance**: data governance, AI governance, compliance, policy management, access control
- **Data Quality**: data quality, data observability, data profiling, validation, test cases
- **Data Contracts**: data contract, SLA, schema validation, API contracts, data agreements
- **Data Products**: data product, data mesh, domain-driven data, product thinking
- **Domains**: data domains, domain ownership, federated governance, organizational structure
- **Lineage**: data lineage, lineage tracking, data flow, upstream/downstream dependencies
- **Metadata Standards**: JSON Schema, RDF, OWL ontology, SHACL, JSON-LD, semantic web

## SEO Best Practices

### 1. Title Tags

- Keep titles under 60 characters
- Include primary keyword
- Make it descriptive and unique
- Include "OpenMetadata Standards" for branding

### 2. Meta Descriptions

- Keep between 150-160 characters
- Include target keywords naturally
- Make it compelling (increases click-through rate)
- Avoid duplicate descriptions across pages

### 3. Keywords

- Focus on 3-5 primary keywords per page
- Use long-tail keywords
- Include semantic variations
- Avoid keyword stuffing

### 4. Content Structure

- Use proper heading hierarchy (H1 → H2 → H3)
- One H1 per page
- Include keywords in headings naturally
- Use descriptive subheadings

### 5. Internal Linking

- Link to related documentation pages
- Use descriptive anchor text
- Maintain a logical site structure
- Ensure no broken links

## Testing SEO Implementation

### Verify Meta Tags

View page source and check for:

```html
<!-- Basic Meta Tags -->
<meta name="description" content="...">
<meta name="keywords" content="...">

<!-- Open Graph -->
<meta property="og:title" content="...">
<meta property="og:description" content="...">
<meta property="og:image" content="...">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="...">
```

### Test Social Sharing

- **Facebook**: https://developers.facebook.com/tools/debug/
- **Twitter**: https://cards-dev.twitter.com/validator
- **LinkedIn**: Share the URL and preview

### Check Structured Data

- **Google Rich Results Test**: https://search.google.com/test/rich-results
- **Schema Markup Validator**: https://validator.schema.org/

### Verify Sitemap

- Check: https://openmetadatastandards.org/sitemap.xml
- Submit to Google Search Console
- Submit to Bing Webmaster Tools

### Check Robots.txt

- Visit: https://openmetadatastandards.org/robots.txt
- Verify allows crawling of all pages

## Monitoring SEO Performance

### Google Search Console

1. Verify ownership of openmetadatastandards.org
2. Submit sitemap
3. Monitor:
   - Search queries and impressions
   - Click-through rates
   - Index coverage
   - Mobile usability
   - Core Web Vitals

### Key Metrics to Track

- **Organic Traffic**: Users from search engines
- **Keyword Rankings**: Target keyword positions
- **Click-Through Rate (CTR)**: Impressions vs clicks
- **Bounce Rate**: User engagement quality
- **Page Load Speed**: Core Web Vital scores
- **Mobile Performance**: Mobile search visibility

## Social Media Image Requirements

For optimal social sharing, create images:

### Open Graph (Facebook, LinkedIn)

- **Size**: 1200 x 630 pixels
- **Format**: PNG or JPG
- **Max File Size**: 8 MB
- **Aspect Ratio**: 1.91:1

### Twitter Card

- **Size**: 1200 x 628 pixels (summary_large_image)
- **Format**: PNG, JPG, or WEBP
- **Max File Size**: 5 MB
- **Aspect Ratio**: 1.91:1

Place images in: `docs/assets/social/`

## Common SEO Issues to Avoid

1. **Duplicate Content**: Each page should have unique content
2. **Missing Meta Descriptions**: All pages need descriptions
3. **Broken Links**: Regularly audit internal/external links
4. **Slow Page Load**: Optimize images and minimize JavaScript
5. **Poor Mobile Experience**: Test on mobile devices
6. **Thin Content**: Pages should have substantial, valuable content
7. **Missing Alt Text**: All images need descriptive alt attributes
8. **Non-Descriptive Titles**: Avoid generic titles like "Page 1"

## Resources

- [Google Search Central](https://developers.google.com/search)
- [Moz SEO Learning Center](https://moz.com/learn/seo)
- [Ahrefs SEO Guide](https://ahrefs.com/seo)
- [Schema.org Documentation](https://schema.org/)
- [Open Graph Protocol](https://ogp.me/)
- [Twitter Card Documentation](https://developer.twitter.com/en/docs/twitter-for-websites/cards/overview/abouts-cards)

## Support

For SEO-related questions or issues:

- Open an issue: [OpenMetadata Standards Issues](https://github.com/open-metadata/OpenMetadataStandards/issues)
- Join Slack: [OpenMetadata Slack](https://slack.open-metadata.org)
