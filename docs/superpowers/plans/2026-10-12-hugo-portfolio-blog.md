# Hugo Portfolio Blog Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build an empty, responsive Hugo portfolio blog titled `xzwang's life` that deploys free of charge to GitHub Pages.

**Architecture:** Hugo templates render the pages from Markdown and shared CSS. GitHub Actions builds the static output from `main` and deploys it to Pages.

**Tech Stack:** Hugo extended 0.128.0, Go templates, CSS, Markdown, GitHub Actions, PowerShell.

**Spec:** `docs/superpowers/specs/2026-10-12-hugo-portfolio-blog-design.md`

## Global Constraints

- Repository: public `xzzwang26.github.io`; title: `xzwang's life`.
- No theme, JavaScript framework, database, external API, invented content, stock imagery, or gradients.
- Empty site routes: Home, Projects, Notes, About.
- Design: white, near-black, neutral-border, muted-teal; keyboard focus and mobile layout required.
- Deployment: first-party Pages actions, on `main` push and manual dispatch.

---

### Task 1: Establish Hugo Configuration and Content Boundaries

**Files:** Create `hugo.toml`, `content/projects/_index.md`, `content/notes/_index.md`, `content/about.md`, `tests/Verify-Site.ps1`.

**Interfaces:** Produces Hugo section endpoints `projects`, `notes`, and `about` for template consumption.

- [ ] **Step 1: Write the configuration contract test.** Add `tests/Verify-Site.ps1` to read `hugo.toml`, assert the literal title `xzwang's life`, and assert all three content entry-point paths exist.
- [ ] **Step 2: Run `powershell -ExecutionPolicy Bypass -File tests/Verify-Site.ps1`.** Confirm it fails because `hugo.toml` does not exist.
- [ ] **Step 3: Add minimal configuration.** Set `baseURL = "https://xzzwang26.github.io/"`, `languageCode = "en-us"`, title, `enableRobotsTXT = true`, and `params.description` / `params.author`. Add title-only section index front matter and an editable `content/about.md`; add no project, note, image, or biography.
- [ ] **Step 4: Re-run the contract test.** Confirm exit code 0.
- [ ] **Step 5: Commit with `git add hugo.toml content tests/Verify-Site.ps1` and `git commit -m "feat: configure Hugo content structure"`.**

### Task 2: Build Semantic Templates and Empty States

**Files:** Create `layouts/_default/baseof.html`, `layouts/_default/list.html`, `layouts/_default/single.html`, `layouts/index.html`, `layouts/partials/header.html`, `layouts/partials/footer.html`, `layouts/partials/content-card.html`; modify `tests/Verify-Site.ps1`.

**Interfaces:** Consumes `.Site.Title`, `.Site.Params.description`, plus optional `summary`, `date`, `tags`, `cover`, `coverAlt`, and `externalURL` front matter. Produces all specified routes and future item pages.

- [ ] **Step 1: Extend the contract test.** Assert base, index, list, and single template paths exist; assert `baseof.html` contains `<header`, `<main`, and `<footer`.
- [ ] **Step 2: Run the test.** Confirm it fails due to missing templates.
- [ ] **Step 3: Implement templates.** Base template contains skip link, header partial, main block, footer, and stylesheet hook. Header navigation uses `relURL` links to Projects, Notes, About. Lists use `.RegularPages.ByDate.Reverse`, cards when nonempty, and `Nothing here yet.` otherwise. Home shows title, description, section links, and conditional previews. Single pages render title, optional date/tags/cover/external link and `.Content`. Covers require `coverAlt`; absent covers create no empty media frame.
- [ ] **Step 4: Re-run the test.** Confirm exit code 0.
- [ ] **Step 5: Commit with `git add layouts tests/Verify-Site.ps1` and `git commit -m "feat: add accessible portfolio templates"`.**

### Task 3: Add Responsive Editorial Styling

**Files:** Create `assets/css/main.css`; modify `layouts/_default/baseof.html` and `tests/Verify-Site.ps1`.

**Interfaces:** Consumes the template class names `site-header`, `site-nav`, `site-main`, `page-heading`, `content-grid`, `content-card`, `empty-state`, `site-footer`. Produces desktop/mobile layout and focus/image styles.

- [ ] **Step 1: Extend the contract test.** Assert `assets/css/main.css` exists and contains `--accent:`, `:focus-visible`, and `@media (max-width: 640px)`.
- [ ] **Step 2: Run the test.** Confirm it fails due to a missing stylesheet.
- [ ] **Step 3: Implement CSS.** Define `--page: #ffffff`, `--ink: #1d2426`, `--muted: #5e686b`, `--line: #d9dfdf`, and muted teal `--accent`; use Georgia/Times for headings and a system sans body. Use a two-column `minmax(0, 1fr)` grid that collapses to one column at 640px, clear focus outlines, and fixed `aspect-ratio` for cover frames. Load it with `resources.Get "css/main.css" | minify | fingerprint` in `baseof.html`.
- [ ] **Step 4: Re-run the test.** Confirm exit code 0.
- [ ] **Step 5: Commit with `git add assets layouts tests/Verify-Site.ps1` and `git commit -m "feat: style responsive editorial portfolio"`.**

### Task 4: Configure GitHub Pages and Authoring Documentation

**Files:** Create `.github/workflows/hugo.yaml`, `README.md`; modify `tests/Verify-Site.ps1`.

**Interfaces:** Consumes the Hugo source; produces Actions deployment and the author instructions.

- [ ] **Step 1: Extend the contract test.** Assert the workflow exists and includes `workflow_dispatch:`, `actions/configure-pages@v5`, `actions/upload-pages-artifact@v3`, `actions/deploy-pages@v4`, and `hugo --minify`; assert `README.md` exists.
- [ ] **Step 2: Run the test.** Confirm it fails because workflow and README are missing.
- [ ] **Step 3: Implement deployment and docs.** Workflow triggers on `main` push and manual dispatch, has Pages permissions, uses checkout/configure-pages/Hugo 0.128.0 extended, runs `hugo --minify --baseURL "${{ steps.pages.outputs.base_url }}/"`, uploads the artifact, then deploys it. Write Chinese README instructions to create public `xzzwang26.github.io`, push `main`, select GitHub Actions in Settings > Pages, visit expected URL, and create projects/notes with `cover` and `coverAlt` front matter.
- [ ] **Step 4: Run the static contract test.** Confirm exit code 0.
- [ ] **Step 5: When Hugo is available, build to `.verification-public`.** Confirm `index.html`, `projects/index.html`, `notes/index.html`, and `about/index.html` exist; then remove that temporary directory.
- [ ] **Step 6: Commit with `git add .github README.md tests/Verify-Site.ps1` and `git commit -m "ci: deploy Hugo site to GitHub Pages"`.**
