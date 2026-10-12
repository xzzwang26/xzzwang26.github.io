# Hugo Portfolio Blog Design

## Purpose

Build a no-cost, public personal site for coursework and future personal publishing. The site will be titled `xzwang's life`, use a restrained editorial portfolio style, and publish at `https://xzzwang26.github.io`.

## Scope

The first release establishes an empty, polished structure rather than invented portfolio work. Visitors can navigate to Projects, Notes, and About. Each listing explicitly handles the empty state. Content can be added later as Markdown without changing templates.

## Architecture

The repository will be a Hugo static site. Hugo turns Markdown content and templates into static HTML, CSS, and assets. A GitHub Actions workflow will build the site using a pinned Hugo version and deploy the generated static output to GitHub Pages.

The deployment target is a public GitHub repository named `xzzwang26.github.io` owned by `xzzwang26`. The site must use the repository-root Pages option with the Actions source, not a manually committed generated `public/` folder.

## Content Model

- `content/projects/`: one Markdown bundle per portfolio project. A project may define `title`, `summary`, `date`, `tags`, `cover`, and `externalURL` in front matter.
- `content/notes/`: one Markdown file per note or post. A note may define `title`, `summary`, `date`, `tags`, and `cover`.
- `content/about.md`: editable personal introduction page.
- There will be no generated sample projects, posts, biographies, or stock imagery.

Project and note listing pages will render cards only when content exists. With no content, they will show a clear, neutral empty-state message.

## Information Architecture

- `/`: title, concise purpose statement, links to Projects and Notes, plus previews when content exists.
- `/projects/`: portfolio-project listing and its empty state.
- `/notes/`: chronological note listing and its empty state.
- `/about/`: editable about page.
- `/projects/<slug>/` and `/notes/<slug>/`: individual content pages rendered from Markdown.

The header will contain the site name and links to Projects, Notes, and About. The footer will be quiet and contain only copyright/year information.

## Visual Direction

The site uses a white background, near-black primary type, gray secondary type, fine neutral borders, and a muted teal accent. Typography is editorial and legible: serif headings paired with a system sans-serif body. Layout is open rather than card-heavy, with stable max-widths and responsive grids.

Images belong to actual project and note content. When a `cover` is supplied, it appears in a fixed-aspect-ratio media frame; without one, the content remains text-forward. No decorative gradients, stock placeholder imagery, or fabricated visual work will appear.

## Responsive and Accessibility Requirements

- Support a single-column mobile layout without horizontal overflow.
- Use semantic landmarks, a visible keyboard focus state, descriptive navigation labels, and sufficient color contrast.
- Respect `prefers-reduced-motion`; initial release should not require animation.
- All user-provided cover images must receive meaningful alt text through front matter, with a decorative empty alt only when the image has no informational role.

## Deployment and Maintenance

- The repository must be public for free GitHub Pages hosting.
- GitHub Actions must use only first-party GitHub Pages actions.
- The workflow must be triggerable on pushes to `main` and manually from the Actions interface.
- Documentation will explain repository creation, connecting the local site, enabling Pages, the expected public URL, and the Markdown/front-matter workflow for new work.
- The display name may change later in `hugo.toml` without changing the GitHub Pages address.

## Verification

- A Hugo production build must finish with exit code 0 when Hugo is available.
- The generated site must contain routes for home, projects, notes, and about.
- A configuration-level check must confirm the GitHub Actions workflow includes build and deployment actions and targets GitHub Pages.
- Visual inspection will cover home, listing pages, and the mobile layout before handoff when a local Hugo runtime is available; otherwise the documented GitHub Actions deployment is the verification path.
