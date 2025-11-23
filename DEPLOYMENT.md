# Deployment Guide

This guide explains how to deploy the OpenMetadata Standards documentation to GitHub Pages with custom domains.

## Automated Deployment

The documentation is automatically deployed to GitHub Pages whenever changes are pushed to the `main` branch.

### GitHub Actions Workflow

The deployment workflow (`.github/workflows/deploy-docs.yml`) performs the following:

1. **Triggers**: Runs on every push to `main` branch or manual workflow dispatch
2. **Build**: Installs Python dependencies and builds the MkDocs site
3. **Deploy**: Deploys the built site to the `gh-pages` branch
4. **Publish**: GitHub Pages serves the content from the `gh-pages` branch

### Required GitHub Settings

#### 1. Enable GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Under **Source**, select: `Deploy from a branch`
3. Under **Branch**, select: `gh-pages` branch and `/ (root)` folder
4. Click **Save**

#### 2. Configure Custom Domain

1. In **Settings** → **Pages** → **Custom domain**
2. Enter: `openmetadatastandards.org`
3. Click **Save**
4. Check **Enforce HTTPS** (after DNS propagation)

#### 3. Set Workflow Permissions

1. Go to **Settings** → **Actions** → **General**
2. Under **Workflow permissions**, select: `Read and write permissions`
3. Check: `Allow GitHub Actions to create and approve pull requests`
4. Click **Save**

---

## Custom Domain Configuration

### Primary Domain: openmetadatastandards.org

#### DNS Configuration (at your domain registrar)

Add the following DNS records for **openmetadatastandards.org**:

```
Type    Name    Value                           TTL
A       @       185.199.108.153                 3600
A       @       185.199.109.153                 3600
A       @       185.199.110.153                 3600
A       @       185.199.111.153                 3600
AAAA    @       2606:50c0:8000::153             3600
AAAA    @       2606:50c0:8001::153             3600
AAAA    @       2606:50c0:8002::153             3600
AAAA    @       2606:50c0:8003::153             3600
CNAME   www     open-metadata.github.io.        3600
```

### Additional Domains (Redirects)

For **openmetadatastandards.com** and **openmetadatastandard.com**, configure redirects to the primary domain.

#### Option 1: DNS-Level Redirect (Recommended)

Most domain registrars offer URL forwarding/redirect features:

1. **openmetadatastandards.com**:
   - Set up URL forwarding to `https://openmetadatastandards.org`
   - Enable "301 Permanent Redirect"
   - Enable "Forward with masking" if you want the URL to remain unchanged

2. **openmetadatastandard.com** (singular):
   - Set up URL forwarding to `https://openmetadatastandards.org`
   - Enable "301 Permanent Redirect"

#### Option 2: DNS Records + GitHub Pages (Alternative)

If your registrar doesn't support redirects, you can point all domains to GitHub Pages:

**For openmetadatastandards.com**:
```
Type    Name    Value                           TTL
A       @       185.199.108.153                 3600
A       @       185.199.109.153                 3600
A       @       185.199.110.153                 3600
A       @       185.199.111.153                 3600
CNAME   www     open-metadata.github.io.        3600
```

**For openmetadatastandard.com**:
```
Type    Name    Value                           TTL
A       @       185.199.108.153                 3600
A       @       185.199.109.153                 3600
A       @       185.199.110.153                 3600
A       @       185.199.111.153                 3600
CNAME   www     open-metadata.github.io.        3600
```

Then add all domains in GitHub Pages settings (only one primary domain is supported, but GitHub will serve content on all configured domains).

---

## DNS Propagation

After configuring DNS records:

1. **Wait**: DNS changes can take 24-48 hours to propagate globally
2. **Check**: Use [DNS Checker](https://dnschecker.org/) to verify propagation
3. **Verify**: Visit your domain to ensure it loads the documentation
4. **Enable HTTPS**: Return to GitHub Pages settings and enable "Enforce HTTPS"

---

## Local Testing

Test the documentation locally before pushing:

```bash
# Install dependencies
pip install mkdocs-material mkdocs-glightbox mkdocs-minify-plugin mkdocs-git-revision-date-localized-plugin

# Serve locally
mkdocs serve

# Build locally
mkdocs build

# Test the built site
cd site && python -m http.server 8000
```

---

## Deployment Workflow

### Automatic Deployment

1. Make changes to documentation files in `docs/`
2. Commit and push to `main` branch:
   ```bash
   git add .
   git commit -m "Update documentation"
   git push origin main
   ```
3. GitHub Actions automatically builds and deploys to GitHub Pages
4. Changes are live at your custom domain within 1-2 minutes

### Manual Deployment

Trigger deployment manually from GitHub:

1. Go to **Actions** tab
2. Select **Deploy MkDocs to GitHub Pages** workflow
3. Click **Run workflow** → **Run workflow**

### Local Deployment (if needed)

```bash
# Deploy directly from local machine (requires write access)
mkdocs gh-deploy --force --clean
```

---

## Monitoring

### Check Deployment Status

1. Go to **Actions** tab to see workflow runs
2. Each push triggers a new deployment
3. Green checkmark = successful deployment
4. Red X = deployment failed (check logs)

### View Deployment Logs

1. Click on a workflow run
2. Expand the job steps to see detailed logs
3. Look for errors in the "Build and Deploy" step

---

## Troubleshooting

### Deployment Fails

**Error**: `Permission denied`
- **Fix**: Enable write permissions in Settings → Actions → General → Workflow permissions

**Error**: `Module not found`
- **Fix**: Add missing Python package to workflow's `pip install` step

### Custom Domain Not Working

**Error**: `DNS_PROBE_FINISHED_NXDOMAIN`
- **Fix**: Wait for DNS propagation (24-48 hours)
- **Check**: Verify DNS records at your registrar

**Error**: `Not Secure` / `SSL Certificate Invalid`
- **Fix**: Wait for GitHub to provision SSL certificate (can take up to 24 hours after DNS propagation)
- **Check**: Ensure "Enforce HTTPS" is enabled in GitHub Pages settings

### Site Not Updating

**Cause**: Browser cache
- **Fix**: Hard refresh (Ctrl+Shift+R / Cmd+Shift+R)
- **Clear**: Browser cache for your domain

**Cause**: CDN cache
- **Fix**: Wait 5-10 minutes for GitHub's CDN to update
- **Force**: Push another commit to trigger rebuild

---

## Repository Structure

```
OpenMetadataStandards/
├── .github/
│   └── workflows/
│       └── deploy-docs.yml       # GitHub Actions workflow
├── docs/
│   ├── CNAME                      # Custom domain configuration
│   ├── index.md                   # Homepage
│   ├── assets/                    # Images, logos, etc.
│   ├── stylesheets/               # Custom CSS
│   └── ...                        # Documentation pages
├── mkdocs.yml                     # MkDocs configuration
├── DEPLOYMENT.md                  # This file
└── README.md                      # Project README
```

---

## Security

### HTTPS

- GitHub Pages automatically provisions SSL certificates for custom domains
- Always enable "Enforce HTTPS" in repository settings
- All traffic is encrypted with TLS 1.2+

### Branch Protection

Consider enabling branch protection for `main`:

1. Go to **Settings** → **Branches**
2. Add rule for `main` branch
3. Enable: "Require status checks to pass before merging"
4. Enable: "Require branches to be up to date before merging"

---

## Contact & Support

- **Issues**: Report problems at [GitHub Issues](https://github.com/open-metadata/OpenMetadataStandards/issues)
- **Community**: Join [OpenMetadata Slack](https://slack.open-metadata.org)
- **Documentation**: [MkDocs Material](https://squidfunk.github.io/mkdocs-material/)
