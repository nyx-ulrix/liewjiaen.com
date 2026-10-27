# Portfolio handover

State as of 2026-10-21. For how the code works and which platforms it uses, read [README.md](README.md); for adding and publishing entries, read [ADDING-ENTRIES.md](ADDING-ENTRIES.md). This file covers where things stand and what to watch out for.

## What it is

Malcolm Liew Jia En's portfolio at https://liewjiaen.com. It's a static site with no build step: GitHub Pages serves the `docs/` folder of `main` in [nyx-ulrix/liewjiaen.com](https://github.com/nyx-ulrix/liewjiaen.com), and a local dashboard (`Portfolio.cmd` → `server.js` → `admin/`) edits it and pushes changes.

## Where things stand

- **Git:** `main` at `6a29bb0`, in sync with `origin/main`, working tree clean. The Pages build for `6a29bb0` reports `built`, so the live site matches the repo.
- **Content** (`docs/data.json`): 21 projects, newest first (SproControl, Budgeter, PixelPad, Badnotes, Deployer, ...), and 5 resume sections: Skills, Experience, Education, Hackathons, Leadership. Pictures and videos are in `docs/uploads/` (64 files, 22 MB).
- **Views:** the landing page is the Spiral view. Developer mode is a Linux-style terminal; it opens from the top bar, from a link ending in `#dev`, or from the last view the visitor used. The old sphere view is archived in `components/sphere/` and isn't published.
- **PixelPad subsite** (`docs/pixelpad/`, live at https://liewjiaen.com/pixelpad/): the PixelPad 1.0.0 page with the APK, the Windows `.exe` (PixelPad Desk), `SHA256SUMS.txt`, the `latest.json` update feed the app checks, plus `architecture.html` and `privacy.html`. These files are built in the PixelPad repo ([nyx-ulrix/pixelpad](https://github.com/nyx-ulrix/pixelpad), private; local copy at `../AndroidWinRemote`) and copied here. That repo has its own `HANDOVER.md`. README's layout section doesn't list this folder yet.
- **Code map:** `graphify-out/` (built 2026-10-20) is committed. The only commit since then changed binaries and version text, so the graph is still accurate.

## Needs your decision or action

1. **PixelPad 1.5.0 is withdrawn.** It was live on `/pixelpad/` for about 8 hours on 2026-10-20 (`fdeb503`) before the numbering restarted at 1.0.0 (`6a29bb0`). The page, downloads and `latest.json` now only offer 1.0.0. The one leftover: the app's updater (`Updater.kt`, `newer()`) compares version names number by number, so a phone that installed 1.5.0 won't be offered 1.0.x through 1.5.0. Anyone in that spot installs 1.0.0 from the page once by hand, which works because `versionCode` kept going up (it is 14 now).
2. **Release binaries live in git.** `.git` is 66 MB. Each PixelPad release adds about 21 MB (the Desk `.exe` alone is 20 MB), and deleted versions stay in git history. That's fine for now. Look at it again if the repo gets close to 1 GB or a single file gets close to 50 MB (GitHub warns at 50 MB and rejects files over 100 MB). The usual fix would be a public releases repo, because the PixelPad repo is private.
3. **"On Steam coming soon"** on the PixelPad page is a placeholder. Replace it with the link when the store page exists (edit it in the PixelPad repo's site source, not here).

## How to work on it

- **Content:** double-click `Portfolio.cmd`. The dashboard opens at http://127.0.0.1:7420/admin/, or on a free port if Windows has reserved 7420. Every edit saves to `docs/data.json` on its own. **Publish** runs `git add docs`, commits, and pushes.
- **Code:** edit `docs/index.html`, `docs/app.js` and `docs/style.css` directly. To preview, run `node server.js --no-open` and open http://127.0.0.1:7420/.
- **Check a deploy:** `gh api repos/nyx-ulrix/liewjiaen.com/pages/builds/latest --jq .status` prints `built` when the build is done. After that, press Ctrl+F5 on the live site.
- **With Claude Code:** the `portfolio-update` skill (`~/.claude/skills/portfolio-update/`) adds or refreshes a project from start to finish. After code changes, refresh the graph with `/graphify . --update`.
- **New PixelPad release:** in the PixelPad repo, raise both `versionName` and `versionCode`, rebuild, and run `python site/build_site.py`. Then copy `site/dist/*` into `docs/pixelpad/` here, remove the previous version's files, and push. Updates only reach phones once this push is live. The new `versionName` has to be higher than the old one, because the updater compares names (see item 1).

## Gotchas

- Only `docs/` goes live. `admin/`, `server.js`, `components/` and `graphify-out/` never do.
- `docs/data.json` has to stay valid JSON: one missing comma and the whole site fails to load. The server also refuses more than 50 projects.
- Every image or video in `docs/uploads/` needs a `-t.webp` thumbnail (or poster) beside it. The dashboard caps uploads at 50 MB.
- Keep `docs/CNAME`, or the custom domain drops. Keep the Cloudflare records on "DNS only" (grey cloud), or GitHub can't renew the HTTPS certificate.
- The dashboard server only answers on `127.0.0.1` and wants an `X-GM` header on API calls. Don't bind it to other addresses.
- Each browser stores its own view and theme in `localStorage`. Chat apps cache link previews, sometimes for a day.
- The in-app browser pane is about 800 px wide, so it only shows the phone layout. For desktop screenshots, use headless Chrome over CDP with `--remote-debugging-port=0`, because fixed ports hit Windows' reserved port ranges.
- `node --check docs/app.js` fails on top-level await. Copy the file to `.mjs` first.

## Rules the owner set

- No Claude or Anthropic co-author trailers or mentions in commits or anywhere in the repo.
- Commit `graphify-out/` (graph, report, manifest), but not its `cache/`.
