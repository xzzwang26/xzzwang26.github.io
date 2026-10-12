$ErrorActionPreference = 'Stop'

$config = Get-Content -Raw 'hugo.toml'

if ($config -notmatch 'title = "xzwang''s life"') {
  throw 'Expected configured title.'
}

if ($config -match 'languageCode') {
  throw 'Expected current Hugo locale configuration.'
}

if ($config -notmatch 'locale = "en-us"') {
  throw 'Expected configured locale.'
}

foreach ($path in 'content/projects/_index.md', 'content/notes/_index.md', 'content/about.md') {
  if (-not (Test-Path $path)) {
    throw "Expected content endpoint: $path"
  }
}

foreach ($path in 'layouts/_default/baseof.html', 'layouts/index.html', 'layouts/_default/list.html', 'layouts/_default/single.html') {
  if (-not (Test-Path $path)) {
    throw "Expected template: $path"
  }
}

$base = Get-Content -Raw 'layouts/_default/baseof.html'

foreach ($landmark in '<header', '<main', '<footer') {
  if ($base -notmatch [regex]::Escape($landmark)) {
    throw "Expected landmark: $landmark"
  }
}

if ($base -match 'Language\.LanguageCode') {
  throw 'Expected current Hugo language field in base template.'
}

$cssPath = 'assets/css/main.css'

if (-not (Test-Path $cssPath)) {
  throw 'Expected main stylesheet.'
}

$css = Get-Content -Raw $cssPath

foreach ($token in '--accent:', ':focus-visible', '@media (max-width: 640px)') {
  if ($css -notmatch [regex]::Escape($token)) {
    throw "Expected token: $token"
  }
}

if ($css -notmatch '(?s)@media \(max-width: 640px\).*?\.site-nav\s*\{.*?flex-wrap:\s*wrap;') {
  throw 'Expected mobile navigation to wrap.'
}

$workflowPath = '.github/workflows/hugo.yaml'

if (-not (Test-Path $workflowPath)) {
  throw 'Expected GitHub Pages workflow.'
}

$workflow = Get-Content -Raw $workflowPath

foreach ($fragment in 'workflow_dispatch:', 'actions/configure-pages@v5', 'actions/upload-pages-artifact@v3', 'actions/deploy-pages@v4', 'hugo --minify') {
  if ($workflow -notmatch [regex]::Escape($fragment)) {
    throw "Expected workflow fragment: $fragment"
  }
}

if ($workflow -notmatch "hugo-version: '0.167.0'") {
  throw 'Expected workflow Hugo version to support Language.Locale.'
}

if (-not (Test-Path 'README.md')) {
  throw 'Expected authoring guide.'
}
