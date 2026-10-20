# Portfolio · liewjiaen.com

Malcolm Liew Jia En's portfolio: project cards on a 3D spiral that turns as you scroll, with the project names listed large in the corner, plus a Developer mode that works like a Linux terminal. It is a static site (HTML, CSS and one JavaScript module, no build step) hosted free on GitHub Pages, and a small dashboard on your PC edits it.

- **Live site:** https://liewjiaen.com
- **Add or edit entries:** double-click `Portfolio.cmd`, or read [ADDING-ENTRIES.md](ADDING-ENTRIES.md)
- **Code map:** [graphify-out/GRAPH_REPORT.md](graphify-out/GRAPH_REPORT.md) (a knowledge graph of the code; open `graphify-out/graph.html` in a browser to explore it)

## Platforms this project needs

| Platform | What it does here | Where to find it |
|---|---|---|
| **GitHub** | Holds the code and all content. The dashboard's Publish button pushes here. | https://github.com/nyx-ulrix/liewjiaen.com (account `nyx-ulrix`) |
| **GitHub Pages** | Hosts the site for free. It serves the `docs/` folder of the `main` branch at the custom domain `liewjiaen.com`, with HTTPS enforced, and rebuilds about a minute after each push. | Repository → Settings → Pages |
| **Cloudflare** | The domain `liewjiaen.com` and its DNS: four `A` records pointing at GitHub Pages (`185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`) and a `www` `CNAME` to `nyx-ulrix.github.io`, all set to "DNS only" (grey cloud) so GitHub can issue the HTTPS certificate. | https://dash.cloudflare.com → liewjiaen.com → DNS |
| **Google Fonts** | Serves the typefaces: Host Grotesk (all Spiral view text), DM Mono (years) and JetBrains Mono (the terminal, where SF Mono isn't installed). No account needed. | fonts.googleapis.com |
| **Your PC** | Node.js runs the dashboard (`server.js`, no npm packages). Git publishes. Any modern browser runs the dashboard, which also resizes your pictures before upload. | https://nodejs.org (LTS), https://git-scm.com |
| *Optional* | GitHub CLI (`gh`) to watch Pages builds; Python with Pillow (and `opencv-python` for videos) for the portfolio-update skill's media script; Claude Code with the `portfolio-update` and `graphify` skills. | https://cli.github.com, `~/.claude/skills/` |

Nothing else is involved: no backend, database, build step, analytics or paid service. Contact me is a `mailto:` link, so visitors write from their own mail app and the message lands in your Gmail.

## Architecture

```mermaid
flowchart LR
  subgraph PC["Your PC (local only)"]
    CMD["Portfolio.cmd"] --> SRV["server.js<br/>Node, 127.0.0.1:7420"]
    SRV -- "serves" --> ADM["admin/<br/>dashboard"]
    ADM -- "PUT /api/data, POST /api/upload" --> SRV
    SRV -- "writes" --> FILES[("docs/data.json<br/>docs/uploads/")]
    ADM -- "POST /api/publish" --> SRV
  end
  SRV -- "git add docs, commit, push" --> GH["GitHub<br/>nyx-ulrix/liewjiaen.com"]
  GH -- "builds docs/ from main" --> PAGES["GitHub Pages"]
  CF["Cloudflare DNS<br/>liewjiaen.com"] -- "A + CNAME records" --> PAGES
  V["Visitor's browser"] -- "https://liewjiaen.com" --> CF
  PAGES -- "index.html, app.js, style.css,<br/>data.json, uploads/" --> V
  GF["Google Fonts"] -- "Host Grotesk, DM Mono,<br/>JetBrains Mono" --> V
```

Inside the site, `docs/index.html` loads one stylesheet and one module, and everything is drawn from `docs/data.json`:

```mermaid
flowchart TB
  IDX["index.html<br/>picks the view and theme before first paint"] --> APP["app.js"]
  IDX --> CSS["style.css<br/>light and dark tokens"]
  APP -- "fetch" --> DATA["data.json<br/>site, projects, resume"]
  APP --> SPIRAL["Spiral view<br/>build, tick, draw"]
  APP --> TITLES["Title list, counter and arrow"]
  APP --> POPUP["Project popup<br/>media grid and viewer"]
  APP --> ABOUT["About me drawer"]
  APP --> CONTACT["Contact overlay"]
  APP --> TERM["Developer mode terminal<br/>virtual file system and commands"]
```

## How the code works

### Loading the page

```mermaid
flowchart TD
  A["Visitor opens liewjiaen.com"] --> B{"Last view saved in this browser,<br/>or a link ending in dev?"}
  B -- "Developer mode" --> C["Terminal, with its saved theme<br/>(dark the first time)"]
  B -- "Spiral view" --> D["Spiral, with its saved theme<br/>(light the first time)"]
  C --> E["app.js fetches data.json"]
  D --> E
  E --> F["Fill About me, the title list and the terminal's boot lines"]
  F --> G["build(): place every card on the helix"]
  G --> H["Every frame, tick() eases the spiral<br/>from six cards back into place"]
```

### Turning the spiral

Cards sit on a helix: card *i* is turned `i × 40°` around the vertical axis, pushed out to the radius and dropped a little, so nine cards make a turn and turns never overlap. Each frame only the wrapper moves (`preserve-3d` inside a `perspective` stage).

```mermaid
flowchart TD
  W["Mouse wheel or swipe<br/>(up, right or diagonal)"] --> N["nudge(): move the goal by part of a card"]
  N --> S["After 140 ms of stillness,<br/>settle the goal on a whole card"]
  K["Arrow or Page keys"] --> AIM["aim(i): goal = card i"]
  T["Hover or Tab onto a card or name"] --> AIM
  S --> L["tick(): position eases toward the goal"]
  AIM --> L
  L --> Q{"Did it move?"}
  Q -- "no" --> L
  Q -- "yes" --> D["draw(): turn and raise the wrapper, dim cards by depth,<br/>play the front card's video, slide and fade the three titles,<br/>update the counter and shorten the arrow"]
  D --> L
```

### Opening a project

```mermaid
flowchart TD
  C["Click a card or a project name"] --> L["launch(i)"]
  L --> A["aim(i): turn its card to the front"]
  A --> W{"Card in front<br/>(or 900 ms passed)?"}
  W --> O["openProject(i): media grid, details,<br/>write-up and links"]
  O --> F["The popup grows out of the card"]
  F --> X["Closes on Esc, the x, a click outside,<br/>or resting on another card for 350 ms"]
  X --> R["The card returns to the spiral"]
```

### Developer mode commands

The terminal has a small Linux-style file system and a handful of familiar commands.

```mermaid
flowchart LR
  H["~ = /home/visitor"] --> PR["projects/<br/>one .md per project"]
  H --> FILES["about.txt, contact.txt, skills.txt,<br/>experience.txt, education.txt,<br/>hackathons.txt, leadership.txt"]
```

```mermaid
flowchart TD
  I["Enter, a clicked link, or Tab to complete"] --> R["run(): echo the prompt, keep history,<br/>split chained commands"]
  R --> E["exec() each part"]
  E --> Q{"Is the first word a command?"}
  Q -- "yes" --> CMD["ls, cd, pwd, cat, tree, grep, whoami, mail,<br/>history, echo, date, uname, man, clear, exit"]
  Q -- "no" --> F{"Is it a file, a folder<br/>or a project name?"}
  F -- "file or project" --> SHOW["Show it, as cat would"]
  F -- "folder" --> CD["Go into it, as cd would"]
  F -- "neither" --> NF["command not found"]
  CMD --> P["print(): each block types itself in,<br/>without scrolling the view"]
  SHOW --> P
  NF --> P
```

### Editing and publishing

```mermaid
sequenceDiagram
  actor You
  participant D as Dashboard (browser)
  participant S as server.js
  participant G as GitHub
  participant P as GitHub Pages
  You->>D: Edit a field or drop pictures
  D->>S: PUT /api/data (400 ms after the last keystroke)
  S->>S: Write data.json.tmp, then rename it over data.json
  D->>S: POST /api/upload (WebP up to 1600 px and a 480 px thumbnail)
  You->>D: Publish to GitHub Pages
  D->>S: POST /api/publish
  S->>G: git add docs, commit "Update portfolio", push
  G->>P: Build docs/ from main (about a minute)
  P-->>You: Live at liewjiaen.com
```

The server only answers on `127.0.0.1`, rejects other host names, and requires an `X-GM` header on every API call, so other websites can't reach it.

## Repository layout

```
docs/                 the live site (GitHub Pages serves this folder)
  index.html          page shell; picks the view and theme before first paint
  app.js              everything that moves: spiral, titles, popups, contact, terminal
  style.css           light and dark themes, layout
  data.json           all content: site, projects, resume
  uploads/            pictures and videos, each with a -t.webp thumbnail
  favicon.svg, CNAME
admin/                the dashboard (local only, never published)
server.js             local server for the dashboard: saves, uploads, publishes
Portfolio.cmd         double-click to start the dashboard
ADDING-ENTRIES.md     how to add and publish entries
components/sphere/    the old sphere view, kept for reference and not published
graphify-out/         knowledge graph of the code (GRAPH_REPORT.md, graph.html, graph.json)
```
