# Graph Report - .  (2026-10-20)

## Corpus Check
- 8 files · ~16,021 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 189 nodes · 342 edges · 12 communities
- Extraction: 91% EXTRACTED · 9% INFERRED · 0% AMBIGUOUS · INFERRED: 31 edges (avg confidence: 0.72)
- Token cost: 104,667 input · 0 output

## Community Hubs (Navigation)
- Live Site App Core
- Docs, Dashboard and Launcher
- Admin Dashboard Logic
- Card and Entry Rendering
- Site Layout and Panels
- Spiral Rendering and Aim
- Terminal Commands
- Content Schema and Dev Terminal
- Publishing and Hosting
- Sheet, Theme and About State
- Contact Window
- Glitch Effect Helpers

## God Nodes (most connected - your core abstractions)
1. `esc()` - 24 edges
2. `openProject()` - 13 edges
3. `admin/index.html (Gamemaster dashboard)` - 9 edges
4. `render()` - 8 edges
5. `upload()` - 8 edges
6. `lines()` - 8 edges
7. `showProject()` - 8 edges
8. `thumb()` - 7 edges
9. `findFile()` - 7 edges
10. `exec()` - 7 edges

## Surprising Connections (you probably didn't know these)
- `Spiral view (3D helix of project cards)` --references--> `build()`  [EXTRACTED]
  README.md → docs/app.js
- `Project popup (media grid, details, write-up, links)` --references--> `openProject()`  [EXTRACTED]
  README.md → docs/app.js
- `Manual publish (git add docs, commit, push; gh api pages build status)` --semantically_similar_to--> `Publish flow (git add docs, commit Update portfolio, push)`  [INFERRED] [semantically similar]
  ADDING-ENTRIES.md → README.md
- `Inline theme init script (localStorage.theme or prefers-color-scheme)` --semantically_similar_to--> `Saved view and theme picked before first paint`  [INFERRED] [semantically similar]
  admin/index.html → README.md
- `Spiral view (3D helix of project cards)` --references--> `draw()`  [EXTRACTED]
  README.md → docs/app.js

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Single-page portfolio panels (Spiral, About, Terminal)** — docs_index_spiral_panel, docs_index_about_panel, docs_index_term_panel [EXTRACTED 1.00]
- **View and theme state system** — docs_index_view_theme_bootstrap, docs_index_per_view_theme, docs_index_theme_btn, docs_index_view_switch_buttons [INFERRED 0.85]
- **Local edit and publish pipeline** — portfolio, server, admin_index, admin_admin, readme_github_repo, readme_github_pages [EXTRACTED 1.00]
- **Spiral build, input and animation loop** — docs_app_build, docs_app_nudge, docs_app_aim, docs_app_tick, docs_app_draw [EXTRACTED 1.00]
- **Public hosting chain for liewjiaen.com** — readme_github_repo, readme_github_pages, readme_cloudflare_dns, readme_google_fonts [EXTRACTED 1.00]

## Communities (12 total, 0 thin omitted)

### Community 0 - "Live Site App Core"
Cohesion: 0.06
Nodes (31): aboutSecs, arrow, bootLines, cards, cmds, contact, countNow, devBtn (+23 more)

### Community 1 - "Docs, Dashboard and Launcher"
Cohesion: 0.08
Nodes (28): Dashboard editing workflow, Troubleshooting (NOT SAVED, reserved port, publish failure, missing Node), admin/index.html (Gamemaster dashboard), Editor panel (#editor), Compendium project list (#plist, #q search, + New), Inline theme init script (localStorage.theme or prefers-color-scheme), Portfolio index.html (liewjiaen.com), Google Fonts (Host Grotesk, DM Mono, JetBrains Mono) (+20 more)

### Community 2 - "Admin Dashboard Logic"
Cohesion: 0.15
Nodes (24): Browser-side media pipeline (WebP 1600 px + 480 px -t thumbnail, video poster), portfolio-update Claude Code skill, api(), esc(), field(), flush(), get(), isVid() (+16 more)

### Community 3 - "Card and Entry Rendering"
Cohesion: 0.14
Nodes (28): banner(), build(), bullets(), chips(), drop(), entry(), entryText(), esc() (+20 more)

### Community 4 - "Site Layout and Panels"
Cohesion: 0.16
Nodes (14): #about panel (About me), Developer mode (terminal view), Per-view light/dark theme persistence, "Have a problem?" pitch button, #spiral-panel section, Spiral view (projects panel), #stage (spiral, pitch, words, counter), #suggest suggested commands (+6 more)

### Community 5 - "Spiral Rendering and Aim"
Cohesion: 0.24
Nodes (11): aim(), backspace(), clampGoal(), draw(), nudge(), placeTitles(), tick(), toggleDrop() (+3 more)

### Community 6 - "Terminal Commands"
Cohesion: 0.24
Nodes (11): cmd(), complete(), exec(), findFile(), findProject(), norm(), print(), resolve() (+3 more)

### Community 7 - "Content Schema and Dev Terminal"
Cohesion: 0.25
Nodes (8): Label | URL link format, Project entry schema (title, tagline, year, type, tools, text, writeup, links, images), Resume sections (jobs, courses, hackathons, leadership), Site settings (headline, summary, contact links, name banner), run(), typeRun(), Developer mode terminal, Virtual file system (~ = /home/visitor, projects/*.md, *.txt)

### Community 8 - "Publishing and Hosting"
Cohesion: 0.29
Nodes (8): Manual publish (git add docs, commit, push; gh api pages build status), GM console log (#log), Cloudflare DNS for liewjiaen.com, GitHub Pages hosting (docs/ on main, liewjiaen.com), GitHub repo nyx-ulrix/liewjiaen.com, mailto: Contact me, Publish flow (git add docs, commit Update portfolio, push), Static site, no build step

### Community 9 - "Sheet, Theme and About State"
Cohesion: 0.33
Nodes (7): closeSheet(), rest(), setAbout(), setDev(), setTheme(), store(), stored()

### Community 10 - "Contact Window"
Cohesion: 0.50
Nodes (4): center(), icon(), openContact(), openWin()

### Community 11 - "Glitch Effect Helpers"
Cohesion: 0.67
Nodes (3): glitch(), isDev(), rnd()

## Knowledge Gaps
- **54 isolated node(s):** `view`, `stage`, `spiral`, `cards`, `titleBox` (+49 more)
  These have ≤1 connection - possible missing edges or undocumented components.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `admin/index.html (Gamemaster dashboard)` connect `Docs, Dashboard and Launcher` to `Publishing and Hosting`, `Admin Dashboard Logic`?**
  _High betweenness centrality (0.253) - this node is a cross-community bridge._
- **Why does `Portfolio index.html (liewjiaen.com)` connect `Docs, Dashboard and Launcher` to `Live Site App Core`, `Site Layout and Panels`?**
  _High betweenness centrality (0.071) - this node is a cross-community bridge._
- **Why does `Publish flow (git add docs, commit Update portfolio, push)` connect `Publishing and Hosting` to `Docs, Dashboard and Launcher`?**
  _High betweenness centrality (0.063) - this node is a cross-community bridge._
- **What connects `view`, `stage`, `spiral` to the rest of the system?**
  _54 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Live Site App Core` be split into smaller, more focused modules?**
  _Cohesion score 0.05555555555555555 - nodes in this community are weakly interconnected._
- **Should `Docs, Dashboard and Launcher` be split into smaller, more focused modules?**
  _Cohesion score 0.08387096774193549 - nodes in this community are weakly interconnected._
- **Should `Admin Dashboard Logic` be split into smaller, more focused modules?**
  _Cohesion score 0.14814814814814814 - nodes in this community are weakly interconnected._