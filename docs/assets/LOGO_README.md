# OpenMetadata Standards Logo

This document explains how to create and use the OpenMetadata Standards logo for the documentation.

## Current Logo Setup

The MkDocs configuration (`mkdocs.yml`) is already set up to use:
- **Logo**: `docs/assets/logo.png` (currently an SVG file)
- **Favicon**: `docs/assets/favicon.png`

## Creating the "OpenMetadata Standards" Logo

### Option 1: Use the Official OpenMetadata Logo (Recommended)

The official OpenMetadata logo is available from the GitHub repository:

```bash
# Download the PNG logo (600x600)
curl -s "https://raw.githubusercontent.com/open-metadata/OpenMetadata/main/openmetadata-ui/src/main/resources/ui/public/logo192.png" -o docs/assets/openmetadata-logo-base.png

# Download the logo from the website (SVG format)
# Visit: https://open-metadata.org/ and inspect the logo SVG in the header
```

### Option 2: Create Custom "OpenMetadata Standards" Logo

You can create a custom logo with "Standards" text using:

#### Using Design Tools (Recommended)

1. **Figma / Adobe Illustrator / Inkscape**:
   - Import the OpenMetadata logo SVG
   - Add "Standards" text below the main logo using the Inter or Roboto font
   - Use the OpenMetadata purple color: `#8D6AF1` or `#7147E8`
   - Export as SVG and PNG (recommended sizes: 192x192, 512x512)

2. **Canva** (Simple online option):
   - Upload the OpenMetadata logo
   - Add text "Standards" with matching typography
   - Download as PNG

#### Using ImageMagick (Command Line)

```bash
# Install ImageMagick if not already installed
brew install imagemagick  # macOS
# or
sudo apt-get install imagemagick  # Ubuntu/Debian

# Add "Standards" text below the logo
convert docs/assets/openmetadata-original-logo.png \
  -gravity South \
  -pointsize 48 \
  -font Inter \
  -fill "#7147E8" \
  -annotate +0+20 "STANDARDS" \
  -background transparent \
  -extent 600x680 \
  docs/assets/logo.png
```

### Option 3: Simple Text Addition (Quick Solution)

Create a composite logo with the word "Standards":

```bash
# Download the base logo
curl -s "https://raw.githubusercontent.com/open-metadata/OpenMetadata/main/openmetadata-ui/src/main/resources/ui/public/logo192.png" -o /tmp/om-logo.png

# Use ImageMagick to add text
convert /tmp/om-logo.png \
  -background transparent \
  -fill "#7147E8" \
  -font "Inter-Bold" \
  -pointsize 40 \
  -gravity South \
  label:"STANDARDS" \
  -append \
  docs/assets/logo.png
```

## OpenMetadata Brand Colors

Use these official colors when creating the logo:

- **Primary Purple**: `#8D6AF1`
- **Dark Purple**: `#7147E8`
- **Light Purple**: `#A78BFA`
- **Text Dark**: `#292929`
- **White**: `#FFFFFF`

## Logo Specifications

### Recommended Sizes

- **Documentation Logo**: 192x192px (minimum) to 512x512px (recommended)
- **Favicon**: 32x32px or 48x48px
- **High Resolution**: 600x600px or larger for clarity

### File Formats

- **SVG**: Preferred for scalability (vector format)
- **PNG**: With transparent background (for raster format)

## Updating the Logo in MkDocs

The logo is already configured in `mkdocs.yml`:

```yaml
theme:
  logo: assets/logo.png
  favicon: assets/favicon.png
```

After creating your custom logo:

1. Save it as `docs/assets/logo.png` (replace the existing file)
2. Optionally, create a matching favicon: `docs/assets/favicon.png`
3. Build the documentation: `mkdocs build`
4. Serve locally to preview: `mkdocs serve`

## Logo Usage Guidelines

When using the OpenMetadata logo or creating derivative works:

1. **Attribution**: Acknowledge OpenMetadata as the source
2. **Consistency**: Maintain the visual style and color scheme
3. **Clear Space**: Maintain adequate padding around the logo
4. **Minimum Size**: Don't use the logo smaller than 24px in digital media

## References

- **OpenMetadata GitHub**: https://github.com/open-metadata/OpenMetadata
- **OpenMetadata Website**: https://open-metadata.org/
- **OpenMetadata Documentation**: https://docs.open-metadata.org/

## License

The OpenMetadata logo is property of the OpenMetadata project. Use the logo in accordance with the project's branding guidelines and open-source license.

For the "OpenMetadata Standards" documentation, we're creating a derivative work that clearly indicates this is a standards documentation project related to OpenMetadata.
