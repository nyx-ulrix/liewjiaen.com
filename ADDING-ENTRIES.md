# Adding and editing entries

Everything on the site comes from one file, `docs/data.json`, plus the pictures and videos in `docs/uploads/`. Change those, push them to GitHub, and https://liewjiaen.com updates about a minute later. There are three ways to make changes.

## The quick way: the dashboard

1. Double-click **Portfolio.cmd** in the project folder. A console window opens, then the dashboard opens in your browser at http://127.0.0.1:7420/admin/. Keep the console window open while you work; closing it stops the dashboard.
2. Make your changes (see below). Every change saves itself to `docs/data.json`, and the top bar shows **saved ✓**.
3. Click **◎ Preview site** to see the site on your PC. Refresh the preview after each change.
4. Click **⇪ Publish to GitHub Pages**. The console at the bottom of the dashboard shows the push. About a minute later the change is live; **↗ Open live site** opens it.

### Add a project

1. Click **+ New** at the top left. A project called "New project" appears at the bottom of the list.
2. Fill in the fields:
- **Title**: the name on the spiral, in the title list and on the popup.
- **Tagline**: one line saying what it is, about 70 characters at most.
- **Year** and **Type**, for example `2026` and `Hackathon`.
- **Tools**: comma separated, like `React, TypeScript, Supabase`. Developer mode's `grep` searches these, so spell each tool the same way every time.
- **Details**: one bullet per line, each starting with a verb (Built, Designed, Led).
- **Write-up**: a few short paragraphs with a blank line between them.
- **Links**: one per line as `Label | https://...`, for example `GitHub | https://github.com/nyx-ulrix/budgeter`.
3. Drop images or videos anywhere on the page, or click the dashed box to choose them. The first one is the cover on the spiral; **★ Make cover** changes it.
4. Use **↑ Move up** and **↓ Move down** to place it. The order in the list is the order on the spiral and in `ls`.

Pictures are resized in your browser before they upload: a full image up to 1600 px and a 480 px thumbnail, both WebP. Videos (MP4 or WebM, up to 50 MB) upload as they are, with a poster frame taken about a second in. Keep videos short: GitHub refuses files over 100 MB.

### Edit or remove a project

Click the project in the list and change any field. **Delete** removes it and its pictures.

### Add a job, course, hackathon or leadership role

1. Click **☰ Resume & jobs** on the right.
2. In the section it belongs to, click **+ Add entry**. New entries go on top; **↑ Move up** reorders them.
3. Fill in **Title / role**, **Organisation · place**, **When** (for example `Jan 2024 - Feb 2025`) and **Details**, one bullet per line.
4. Each section shows up in About me, in `whoami`, and as a file in Developer mode (`cat experience.txt`). **+ Add section** makes a new one; the first word of its name becomes its file name.

### Change your name, headline or links

Click **⚙ Site & UI** on the right.
- **Headline** is the line above your name ("I solve problems with software...").
- **Summary** is the About me paragraph.
- **Contact links** are one per line, as `Label | https://...` or `Email | mailto:you@example.com`. The email address and the GitHub and LinkedIn icons in Contact me come from these.
- **Name banner** is the ASCII-art name in Developer mode.

## By hand: editing data.json

`docs/data.json` holds three things: `site` (name, headline, summary and links), `projects` (up to 50) and `resume` (sections of entries). A project looks like this:

```json
{
  "title": "Budgeter",
  "tagline": "Pixel-art daily budget planner with receipt scanning and widgets",
  "year": "2026",
  "type": "Passion project",
  "tools": "Kotlin, Jetpack Compose, ML Kit",
  "text": "Built ...\nDesigned ...",
  "writeup": "First paragraph.\n\nSecond paragraph.",
  "links": "GitHub | https://github.com/nyx-ulrix/budgeter",
  "images": ["budgeter.webp", "budgeter-2.webp"]
}
```

Each name in `images` needs two files in `docs/uploads/`: the picture itself (`budgeter.webp`, longest side 1600 px or less) and a thumbnail with `-t` added to its name (`budgeter-t.webp`, 480 px wide). A video is `.mp4` or `.webm` with a `-t.webp` poster beside it. Check that the file is still valid JSON before you publish; a missing comma stops the whole site from loading.

## With Claude Code

Ask Claude Code something like "add Budgeter to my portfolio" or "add my new job to my portfolio". The **portfolio-update** skill reads the project, makes screenshots and thumbnails, writes the entry and write-up, previews it and publishes it.

## Publishing by hand

If you edited the files yourself, or Publish in the dashboard failed, open a terminal in the project folder and run:

```bash
git add docs
git commit -m "Update portfolio"
git push
```

GitHub Pages rebuilds in about a minute. To check, run `gh api repos/nyx-ulrix/liewjiaen.com/pages/builds/latest --jq .status`, which prints `built` when it's done. Then open https://liewjiaen.com and press Ctrl+F5 if you still see the old version.

## If something goes wrong

- **"NOT SAVED" in the dashboard**: the console window was closed. Double-click Portfolio.cmd again and redo the last change.
- **The console says the port is reserved**: Windows reserves some ports, so the dashboard uses a free one and opens it for you.
- **Publish failed**: read the message in the dashboard's bottom console. Usually Git needs you to sign in again (run `git push` once in a terminal), or there was nothing new to publish.
- **Node.js is missing**: install the LTS version from https://nodejs.org, then run Portfolio.cmd again.
- **The live site looks old**: wait a minute after publishing, then press Ctrl+F5. Link previews in chat apps are cached separately and can take a day to update.
