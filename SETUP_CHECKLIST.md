# GitHub Pages Setup Checklist

Follow this checklist to deploy OpenMetadata Standards documentation to GitHub Pages with custom domains.

## ✅ Pre-Deployment Checklist

### 1. Repository Files

- [x] `.github/workflows/deploy-docs.yml` - GitHub Actions workflow
- [x] `docs/CNAME` - Custom domain configuration (openmetadatastandards.org)
- [x] `mkdocs.yml` - MkDocs configuration with correct site_url
- [x] `DEPLOYMENT.md` - Detailed deployment guide
- [x] `README.md` - Updated with deployment info

### 2. Commit and Push

```bash
# Stage all files
git add .

# Commit changes
git commit -m "Add GitHub Pages deployment with custom domain support"

# Push to main branch
git push origin main
```

## ✅ GitHub Repository Configuration

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** (top navigation)
3. Click **Pages** (left sidebar)
4. Under **Source**:
   - Select: `Deploy from a branch`
5. Under **Branch**:
   - Branch: `gh-pages`
   - Folder: `/ (root)`
6. Click **Save**

### Step 2: Configure Workflow Permissions

1. Still in **Settings**, click **Actions** → **General** (left sidebar)
2. Scroll to **Workflow permissions**
3. Select: `Read and write permissions`
4. Check: `Allow GitHub Actions to create and approve pull requests`
5. Click **Save**

### Step 3: Run Initial Deployment

**Option A: Automatic (push to main)**
```bash
git push origin main
# Workflow will run automatically
```

**Option B: Manual trigger**
1. Go to **Actions** tab
2. Click **Deploy MkDocs to GitHub Pages**
3. Click **Run workflow** button
4. Select branch: `main`
5. Click **Run workflow**

### Step 4: Wait for Deployment

1. Go to **Actions** tab
2. Watch the workflow run (should take 1-2 minutes)
3. Wait for green checkmark ✓
4. If red X, click on the workflow run to see error logs

### Step 5: Verify GitHub Pages

1. Go back to **Settings** → **Pages**
2. You should see: "Your site is live at https://open-metadata.github.io/OpenMetadataStandards/"
3. Click the link to verify the site loads

## ✅ Custom Domain Configuration

### Step 1: Add Custom Domain in GitHub

1. In **Settings** → **Pages**
2. Under **Custom domain**
3. Enter: `openmetadatastandards.org`
4. Click **Save**
5. Wait for DNS check (this will initially fail - that's okay)

### Step 2: Configure DNS Records

Go to your domain registrar (where you bought the domains) and add these records:

#### For openmetadatastandards.org (Primary Domain)

| Type  | Name | Value                     | TTL  |
|-------|------|---------------------------|------|
| A     | @    | 185.199.108.153          | 3600 |
| A     | @    | 185.199.109.153          | 3600 |
| A     | @    | 185.199.110.153          | 3600 |
| A     | @    | 185.199.111.153          | 3600 |
| CNAME | www  | open-metadata.github.io. | 3600 |

**Important Notes:**
- `@` represents the root domain (openmetadatastandards.org)
- `www` is for www subdomain
- Don't forget the trailing dot in `open-metadata.github.io.`

#### For openmetadatastandards.com (Redirect)

**Option 1: URL Forwarding (Recommended)**

Most registrars have a "URL Forwarding" or "URL Redirect" feature:

1. Find URL forwarding settings
2. Set up 301 redirect from `openmetadatastandards.com` to `https://openmetadatastandards.org`
3. Set up 301 redirect from `www.openmetadatastandards.com` to `https://openmetadatastandards.org`
4. Enable "Forward path" option if available

**Option 2: DNS Records (Alternative)**

If your registrar doesn't support URL forwarding:

| Type  | Name | Value                     | TTL  |
|-------|------|---------------------------|------|
| A     | @    | 185.199.108.153          | 3600 |
| A     | @    | 185.199.109.153          | 3600 |
| A     | @    | 185.199.110.153          | 3600 |
| A     | @    | 185.199.111.153          | 3600 |
| CNAME | www  | open-metadata.github.io. | 3600 |

#### For openmetadatastandard.com (Redirect - singular "standard")

Same as openmetadatastandards.com - use URL forwarding to redirect to openmetadatastandards.org

### Step 3: Wait for DNS Propagation

- **Time Required**: 24-48 hours (usually faster, often 1-2 hours)
- **Check Progress**: [dnschecker.org](https://dnschecker.org)
  1. Enter your domain: `openmetadatastandards.org`
  2. Select record type: `A`
  3. Click **Search**
  4. Green checkmarks = DNS has propagated in that region

### Step 4: Enable HTTPS

1. Wait for DNS to fully propagate (check dnschecker.org)
2. Go to **Settings** → **Pages**
3. Once DNS is verified, check **Enforce HTTPS**
4. GitHub will automatically provision SSL certificate (takes a few minutes)

## ✅ Verification Checklist

### Test Primary Domain

- [ ] Visit https://openmetadatastandards.org
- [ ] Verify site loads correctly
- [ ] Check logo displays properly
- [ ] Verify version badge shows v1.11.0
- [ ] Test navigation menu works
- [ ] Check examples page loads
- [ ] Verify search works
- [ ] Confirm HTTPS lock icon in browser

### Test WWW Subdomain

- [ ] Visit https://www.openmetadatastandards.org
- [ ] Should redirect to https://openmetadatastandards.org

### Test Redirect Domains (after DNS configuration)

- [ ] Visit https://openmetadatastandards.com
- [ ] Should redirect to https://openmetadatastandards.org
- [ ] Visit https://openmetadatastandard.com
- [ ] Should redirect to https://openmetadatastandards.org

### Test Automated Deployment

- [ ] Make a small change to docs (e.g., edit `docs/index.md`)
- [ ] Commit and push to main
- [ ] Go to Actions tab and watch workflow
- [ ] Verify workflow completes successfully
- [ ] Visit site and verify changes appear (wait 1-2 minutes)
- [ ] Hard refresh browser (Ctrl+Shift+R / Cmd+Shift+R)

## 🚨 Troubleshooting

### Workflow Fails with "Permission denied"

**Fix:**
1. Settings → Actions → General
2. Workflow permissions → Read and write permissions
3. Save and re-run workflow

### DNS Not Resolving

**Check:**
```bash
# Check DNS resolution
dig openmetadatastandards.org

# Should show GitHub Pages IPs:
# 185.199.108.153
# 185.199.109.153
# 185.199.110.153
# 185.199.111.153
```

**Fix:**
- Wait longer for DNS propagation
- Verify DNS records at registrar
- Check for typos in DNS records

### Custom Domain Shows 404

**Causes:**
- DNS not propagated yet (wait longer)
- CNAME file missing or incorrect
- GitHub Pages not enabled on gh-pages branch

**Fix:**
1. Verify `docs/CNAME` contains `openmetadatastandards.org`
2. Verify workflow deployed successfully
3. Check Settings → Pages shows "Your site is published"

### HTTPS Certificate Error

**Causes:**
- DNS not fully propagated
- Too early to enable HTTPS

**Fix:**
- Wait for DNS to fully propagate (24-48 hours)
- Disable "Enforce HTTPS" temporarily
- Re-enable after DNS propagates
- GitHub will auto-provision certificate

### Site Shows Old Content

**Causes:**
- Browser cache
- CDN cache

**Fix:**
1. Hard refresh: Ctrl+Shift+R (Windows) / Cmd+Shift+R (Mac)
2. Clear browser cache
3. Wait 5-10 minutes for CDN to update
4. Try incognito/private browsing mode

## 📞 Support

If you encounter issues:

1. Check [DEPLOYMENT.md](DEPLOYMENT.md) for detailed troubleshooting
2. Review workflow logs in Actions tab
3. Visit [GitHub Pages Documentation](https://docs.github.com/en/pages)
4. Ask in [OpenMetadata Slack](https://slack.open-metadata.org)

## 🎉 Success!

Once all checkmarks are complete, your documentation is:

- ✅ Hosted on GitHub Pages
- ✅ Automatically deployed on every commit
- ✅ Accessible via custom domain with HTTPS
- ✅ Redirecting from alternate domains

**Next Steps:**
- Share the documentation link with your team
- Monitor deployment workflow for future updates
- Consider adding branch protection rules for main branch
