#!/bin/bash

# Documentation validation script
# Run this before committing documentation changes

set -e

echo "🔍 Validating OpenMetadata Standards Documentation"
echo "=================================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0

# Check if we're in the right directory
if [ ! -f "mkdocs.yml" ]; then
    echo -e "${RED}❌ Error: mkdocs.yml not found. Please run this script from the repository root.${NC}"
    exit 1
fi

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Error: python3 is not installed${NC}"
    exit 1
fi

# Check if mkdocs is installed
if ! command -v mkdocs &> /dev/null && ! python3 -m mkdocs --version &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: mkdocs is not installed${NC}"
    echo "Installing dependencies..."
    pip install mkdocs-material mkdocs-glightbox mkdocs-minify-plugin mkdocs-git-revision-date-localized-plugin
fi

echo "1️⃣  Checking for empty or very small files..."
python3 << 'PYEOF'
import sys
from pathlib import Path

empty_files = []
small_files = []

for md_file in Path('docs').rglob('*.md'):
    size = md_file.stat().st_size
    if size == 0:
        empty_files.append(str(md_file.relative_to('docs')))
    elif size < 50:
        small_files.append((str(md_file.relative_to('docs')), size))

if empty_files:
    print(f"❌ Found {len(empty_files)} empty markdown files:")
    for f in empty_files:
        print(f"  - {f}")
    sys.exit(1)

if small_files:
    print(f"⚠️  Found {len(small_files)} very small files (< 50 bytes):")
    for f, size in small_files:
        print(f"  - {f} ({size} bytes)")

print("✅ No empty files found")
PYEOF

if [ $? -ne 0 ]; then
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "2️⃣  Checking for broken internal links..."
python3 << 'PYEOF'
import os
import re
import sys
from pathlib import Path

broken_links = []

# Parse all markdown files for internal links
for md_file in Path('docs').rglob('*.md'):
    content = md_file.read_text()
    # Find markdown links [text](path.md)
    links = re.findall(r'\[([^\]]+)\]\(([^)]+\.md[^)]*)\)', content)

    for link_text, link_path in links:
        # Skip external links
        if link_path.startswith('http://') or link_path.startswith('https://'):
            continue

        # Remove anchor
        link_path_clean = link_path.split('#')[0]

        # Resolve relative path
        link_file = md_file.parent / link_path_clean
        if not link_file.exists():
            broken_links.append({
                'file': str(md_file.relative_to('docs')),
                'link': link_path,
                'expected': str(link_file)
            })

if broken_links:
    print(f"❌ Found {len(broken_links)} broken internal links:")
    for link in broken_links[:10]:  # Show first 10
        print(f"  📄 {link['file']}")
        print(f"     ↳ {link['link']}")
        print(f"     Expected: {link['expected']}")
        print()
    if len(broken_links) > 10:
        print(f"  ... and {len(broken_links) - 10} more")
    sys.exit(1)
else:
    print("✅ No broken internal links found")
PYEOF

if [ $? -ne 0 ]; then
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "3️⃣  Building documentation with MkDocs..."
if mkdocs build --strict 2>&1 | tee /tmp/mkdocs-build.log; then
    echo -e "${GREEN}✅ Documentation built successfully${NC}"
else
    echo -e "${RED}❌ Documentation build failed${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check for warnings
WARNING_COUNT=$(grep "WARNING" /tmp/mkdocs-build.log | grep -v "git_follow\|git logs" | wc -l | tr -d ' ')
if [ "$WARNING_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Found $WARNING_COUNT warnings:${NC}"
    grep "WARNING" /tmp/mkdocs-build.log | grep -v "git_follow\|git logs"
    WARNINGS=$((WARNINGS + WARNING_COUNT))
fi

echo ""
echo "4️⃣  Checking for potential 404 references..."
python3 << 'PYEOF'
import sys
from pathlib import Path

missing_refs = []

for md_file in Path('docs').rglob('*.md'):
    content = md_file.read_text()
    if '404' in content.lower() or 'not found' in content.lower():
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if '404' in line.lower() or 'not found' in line.lower():
                # Skip if it's in code blocks or examples
                if not any(x in line for x in ['example', 'error', 'status code', 'http', '```']):
                    missing_refs.append({
                        'file': str(md_file.relative_to('docs')),
                        'line': i + 1,
                        'content': line.strip()[:100]
                    })

if missing_refs:
    print(f"⚠️  Found {len(missing_refs)} potential 404 references:")
    for ref in missing_refs[:5]:
        print(f"  - {ref['file']}:{ref['line']}")
        print(f"    {ref['content']}")
else:
    print("✅ No 404 references found")
PYEOF

echo ""
echo "5️⃣  Documentation statistics..."
MD_COUNT=$(find docs -name '*.md' | wc -l | tr -d ' ')
HTML_COUNT=$(find site -name '*.html' 2>/dev/null | wc -l | tr -d ' ')
SITE_SIZE=$(du -sh site 2>/dev/null | cut -f1 || echo "N/A")

echo "  📝 Markdown files: $MD_COUNT"
echo "  🌐 HTML pages: $HTML_COUNT"
echo "  💾 Site size: $SITE_SIZE"

# Summary
echo ""
echo "=================================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All validation checks passed!${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠️  But found $WARNINGS warnings${NC}"
    fi
    exit 0
else
    echo -e "${RED}❌ Validation failed with $ERRORS errors${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠️  And $WARNINGS warnings${NC}"
    fi
    exit 1
fi
