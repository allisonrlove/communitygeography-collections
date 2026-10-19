# How to Edit the Community Geography Website

**No coding experience needed.** This guide walks you through everything step by step.
Everything is done in your web browser. You do not need to install anything.

---

## Table of Contents

1. [The 5-minute version](#1-the-5-minute-version)
2. [Editing with GitHub and VS Code in your browser](#2-editing-with-github-and-vs-code-in-your-browser)
3. [Where things live (a map of the website files)](#3-where-things-live)
4. [General edits: text, links, images, colors, sizes](#4-general-edits)
5. [Add a news story](#5-add-a-news-story)
6. [Add an event](#6-add-an-event)
7. [Add a project](#7-add-a-project)
8. [Move a project from current to past](#8-move-a-project-from-current-to-past)
9. [Add or edit a person](#9-add-or-edit-a-person)
10. [Other things to know](#10-other-things-to-know)
11. [Troubleshooting](#11-troubleshooting)
12. [Cheat sheet](#12-cheat-sheet)

---

## 1. The 5-minute version

1. Go to the repository on GitHub and press the **period key (`.`)** on your keyboard. This opens the editor in your browser. (Or see Section 2 for other ways.)
2. Find the file you want in the left-hand list and click it.
3. Make your change and save with **Ctrl+S** (Mac: **Cmd+S**).
4. Click the **Source Control** icon on the left (it looks like a branch with dots).
5. Type a short message such as "Add spring workshop event" and click **Commit & Push**.
6. Wait 2-5 minutes. Check the **Actions** tab on GitHub for a green check mark. Your change is now on the website.

> **Important:** Saving a file does NOT publish it. You must **Commit & Push** (step 5).

---

## 2. Editing with GitHub and VS Code in your browser

### What you need
- A free [GitHub](https://github.com) account.
- Permission to edit the repository. Ask the website owner to add you as a collaborator if you don't have it.

### Opening the editor
Pick whichever is easiest:

- **Easiest:** Open the repository on GitHub and press the **`.`** (period) key.
- Or change `github.com` to `github.dev` in the web address.
- Or use this link: <https://github.dev/amaranth-unm/communitygeography-collections>

(If the repository has moved, use the address of wherever this repository lives now.)

A screen that looks like a code editor will open. This is "VS Code in the browser."

### Finding your way around

| Area | What it does |
| --- | --- |
| **Left side, Explorer (two pages icon)** | A list of all the website's files and folders. Click a folder to open it. |
| **Search (magnifying glass)** | Find text across all files. Useful for finding a sentence you want to change. |
| **Source Control (branch icon)** | Where you save and publish your changes. A number badge shows how many files you changed. |
| **Middle** | The file you are editing. |

**Tip:** Press **Ctrl+P** (Mac: **Cmd+P**) and start typing a file name to jump straight to it.

### Making and publishing a change

1. **Open the file** you want to change.
2. **Edit it.** Click in the text and type like you would in a document.
3. **Save** with **Ctrl+S** (Mac: **Cmd+S**).
4. Click the **Source Control** icon on the left.
5. You will see your changed files listed. Click the **+** next to a file to "stage" it (or click **+** next to "Changes" to stage everything).
6. Type a short description in the message box (for example, "Fix typo on mission page").
7. Click **Commit & Push** (or the checkmark, then **Sync Changes**).
8. If it asks which branch, choose the main one (`main`). If you're unsure, stay on `main` for small edits.

### Checking that it worked

1. On the GitHub page for the repository, click the **Actions** tab.
2. Find your most recent entry named **Deploy Jekyll site to Pages**.
3. A **yellow circle** means it is still working. A **green check** means it is live. A **red X** means something went wrong (see [Troubleshooting](#11-troubleshooting)).
4. It usually takes 2-5 minutes. Refresh the live website to see the change.

### Made a mistake?

- **Before you commit:** In Source Control, click the small **undo arrow** next to the file to throw away your changes.
- **After you commit:** Nothing is lost. GitHub keeps the full history. Ask a teammate for help, or edit the file again and commit the fix.

### A word about the "front matter"

Many files start with a block between two lines of three dashes:

```
---
title: Community mapping workshop
start_date: '2027-03-12'
---
```

This is "front matter." It is information the website uses (title, dates, pictures). **Edit only the words after the colon.** Do not delete the dashes or the words before the colons. Everything below the second `---` is the normal text of the page.

---

## 3. Where things live

| I want to change... | Go to this folder |
| --- | --- |
| A news story | `_news/` (inside a year folder, like `_news/2026/`) |
| An event | `_events/` (inside a year folder, like `_events/2026/`) |
| A current project | `pages/projects/current-projects/` |
| A past project | `pages/projects/past-projects/` |
| A person on the Team or Affiliates page | `_people/` |
| Other pages (About, Funding, Donate, etc.) | `pages/` |
| Pictures | `assets/images/` |
| PDFs and flyers | `assets/documents/` |
| The menu at the top of the site | `_data/nav-top.yml` |
| Site-wide settings (title, email, banner) | `_config.yml` |
| Colors and fonts | `assets/css/themes/unm.css` |

**Folders starting with `_` (underscore) are special.** Leave their names alone.

---

## 4. General edits

### Changing text

Open the page file, find the words, and type. Page text is written in **Markdown**, a simple way to format text:

| You type | You get |
| --- | --- |
| `# Big heading` | A large heading |
| `## Smaller heading` | A medium heading |
| `### Smallest heading` | A small heading |
| `**bold text**` | **bold text** |
| `*italic text*` | *italic text* |
| `- item` (at the start of a line) | A bullet list |
| `1. item` | A numbered list |
| `[link words](https://example.com)` | A clickable link |

Leave a **blank line** between paragraphs, or they will run together.

### Adding a link

```
[Visit the UNM website](https://www.unm.edu)
```

To link to another page on this website, use its address starting with a slash:

```
[See our projects]({{ '/projects/index.html' | relative_url }})
```

Keep the `{{ ... | relative_url }}` part exactly as shown.

### Adding an image

**Step 1: Prepare the image.**
- Use a clear file name with lowercase letters, numbers and dashes, and no spaces. Example: `spring-workshop-flyer.jpg`.
- Keep files reasonably small (under about 1 MB if you can). Photos are best as `.jpg`; logos and flyers as `.png`.

**Step 2: Upload it.**
1. In the Explorer, open the right folder under `assets/images/` (for example `assets/images/news/` for news pictures, `assets/images/events/` for event flyers, `assets/images/projects/project/` for project pictures).
2. **Drag and drop** the image from your computer into that folder in the Explorer. (Or right-click the folder and choose **Upload**.)

**Step 3: Show it on the page.** Put this in the page text where you want the picture:

```
<img src="{{ '/assets/images/news/spring-workshop-flyer.jpg' | relative_url }}" alt="Flyer for the spring workshop" />
```

- Change the path (`/assets/images/news/...`) to match your file.
- **Always fill in `alt`.** It is a short description for people who use screen readers. It is also required by the site's automatic checks.

> Some pages (events, news, projects) have special spots for pictures. Those are covered in Sections 5-7. Just give the file's path.

**Step 4:** Commit and push as usual (the uploaded image counts as a change).

The site has an **Optimize Images** tool that shrinks large pictures. On GitHub go to **Actions → Optimize Images → Run workflow**.

### Adding a PDF or document

1. Drag the PDF into `assets/documents/` (use the matching subfolder such as `news` or `funding`).
2. Link to it:

```
[Download the flyer (PDF)]({{ '/assets/documents/news/my-flyer.pdf' | relative_url }})
```

### Changing colors

All the website's colors are in one file: `assets/css/themes/unm.css`. Near the top you will see lines like:

```
--accent-primary: #007a86;
--interactive-hover: #ba0c2f;
--bg-page: #f8f8f6;
```

The part after the colon (like `#007a86`) is a **color code**. Replace it with another color code and the whole site changes. Find color codes at [htmlcolorcodes.com](https://htmlcolorcodes.com/) (copy the "HEX" value, including the `#`).

| Line starts with | Changes |
| --- | --- |
| `--accent-primary` | Main teal color (buttons, links) |
| `--interactive-hover` | Cherry red (hover and focus color) |
| `--bg-page` | Page background |
| `--bg-nav` | Top menu background |
| `--bg-footer` | Footer background |
| `--text-body` | Main text color |
| `--text-h1`, `--text-h2`, `--text-h3` | Heading colors |

**Tip:** Change one color at a time and check the live site afterward. This stops a typo from breaking many things at once. Keep the `;` at the end of each line.

> The site uses UNM's official brand colors. Check with the Center director before changing them.

### Changing text size or fonts

Fonts are set in the same `unm.css` file under `--font-body` and `--font-heading`. For text size in particular:

- Look in `assets/css/typography.css`. Sizes look like `font-size: 1.125rem;`. A **bigger number = bigger text**. `1rem` is normal size.
- Change a number by small steps (for example, `1rem` to `1.1rem`).

For one-off sizing inside a page you can wrap text in a tag:

```
<span style="font-size: 1.5rem;">This text is larger.</span>
```

### Changing the top menu

Open `_data/nav-top.yml`. Each menu has a `title` (what visitors see) and a `url` (where it goes). Keep the spacing (indentation) and the dashes exactly as they are. Spaces matter in this file.

### Changing the contact email or site title

Open `_config.yml`. Edit the `title`, `description`, or `email` lines. Do not change other lines unless you know what they do.

---

## 5. Add a news story

1. In the Explorer, open `_news/` and then the folder for the current year (for example `_news/2026/`). If the year's folder doesn't exist yet, right-click `_news` and choose **New Folder**.
2. Right-click the year folder and choose **New File**.
3. Name it with lowercase words separated by dashes and ending in `.md`. Example: `new-fellows-announced.md`.
4. Paste this template into the file and fill it in:

```
---
title: New Fellows Announced
permalink: /news/new-fellows-announced.html
published_date: '2026-09-15'
---

Write your story here. Leave a blank line between paragraphs.

You can add a [link](https://example.com), **bold text**, and pictures
(see the "Adding an image" section above).
```

5. Save, then **Commit & Push**.

**Notes**
- `title` is the headline.
- `permalink` is the web address. Use `/news/` + the file name (without `.md`) + `.html`.
- `published_date` is the date in `'YYYY-MM-DD'` form. **Keep the quote marks.**
- If you only know the year, use `published_year: '2026'` instead of `published_date`.
- The news page and the year page update by themselves. You do not need to edit any list.
- **Optional lead picture:** add two lines to the top block: `image: /assets/images/news/my-photo.jpg` and `image_alt: A short description`.
- **Homepage list:** the homepage shows a hand-picked set of stories. To add yours, add `featured_order: 6` (a number nobody else is using). Ask the director before featuring a story. New stories are *not* shown on the homepage automatically.

**Easiest way:** copy an existing news file (for example `_news/2026/michael-devivo-visit.md`), rename the copy, and replace the text. Remember to change the `permalink`, too. Two pages cannot share an address.

---

## 6. Add an event

1. Open `_events/` and the folder for the year **the event starts in** (for example `_events/2027/`). Create the folder if needed.
2. Create a new file named like `community-mapping-workshop.md`.
3. Paste and fill in this template:

```
---
title: Community Mapping Workshop
permalink: /events/community-mapping-workshop.html
start_date: '2027-03-12'
end_date: '2027-03-12'
start_time: '14:00'
end_time: '16:00'
location: UNM Bandelier East 105
presenter: Jane Doe
---

Describe the event here. Include who it is for, what will happen, and
how to register.
```

4. Save, then **Commit & Push**.

**Notes**
- **Keep the quote marks** around dates and times.
- Use **24-hour time**: 2 p.m. is `'14:00'`, 9 a.m. is `'09:00'`.
- The file must sit in the folder matching its start year, or the checks will fail.
- If you don't know the time, location, or presenter, **delete that line**. Don't guess.
- **Flyer picture:** upload it to `assets/images/events/` (see Section 4) and add two lines at the top:
  ```
  flyer: /assets/images/events/my-flyer.png
  flyer_alt: Flyer for the Community Mapping Workshop on March 12
  ```
- **Upcoming Events** automatically lists events whose date hasn't passed yet. It refreshes every day, so old events move to the archive by themselves.
- Events are never deleted. They stay in the **Events Archive**.

**Easiest way:** copy an existing event (for example `_events/2026/devivo-public-talk.md`), rename the copy, and edit it. Remove lines you don't need (like `source_url`, `legacy_upcoming`, `date_review`, and `review_notes`).

---

## 7. Add a project

Projects are pages in two folders:

- `pages/projects/current-projects/` for projects happening now
- `pages/projects/past-projects/` for finished projects

A new project is added by creating one file. The cards on the Projects page are built for you.

1. Upload the project's picture to `assets/images/projects/project/` (see Section 4).
2. Open `pages/projects/current-projects/`, create a new file named like `my-new-project.md`.
3. Paste and fill in this template:

```
---
title: My New Project
permalink: "/projects/project/my-new-project.html"
section: Projects
section_url: "/projects/index.html"
thumbnail: "/assets/images/projects/project/my-new-project.jpg"
start_date: 2027-01-15
end_date: Ongoing
faculty:
  - Dr. Jane Doe
community_member:
  - Example Community Group
summary: Two or three sentences that describe the project. This shows on the project card.
---

# My New Project

<img src="{{ '/assets/images/projects/project/my-new-project.jpg' | relative_url }}" class="img-thumbnail student-project-thumb" alt="Describe the picture" />

{% include community/project-meta.html %}

Write the full description of the project here.
```

4. Save, then **Commit & Push**.

**Notes**
- Keep `{% include community/project-meta.html %}` exactly as is. It displays the faculty and partner names.
- `start_date` is written `YYYY-MM-DD` (no quote marks needed here).
- For a project that hasn't ended, write `end_date: Ongoing`.
- Don't know the faculty or partner? Use `- TBD`.
- The Projects page sorts current projects with the newest start date first.
- Past projects are sorted alphabetically by title.

**Easiest way:** copy a similar project file, rename it, and replace the information.

---

## 8. Move a project from current to past

When a project is finished:

1. Open the project's file in `pages/projects/current-projects/`.
2. Change `end_date: Ongoing` to the real end date, such as `end_date: 2027-05-15`.
3. **Move the file** to the past-projects folder: in the Explorer, **drag the file** from `current-projects` onto the `past-projects` folder (or right-click the file → **Cut**, then right-click `past-projects` → **Paste**).
4. Click **Source Control**, write a message like "Move X project to past projects", and **Commit & Push**.

That's it. The project disappears from the **Projects** page and appears on the **Past Projects** page automatically. The project's web address (`permalink`) does not change, so existing links still work. **Do not edit the `permalink` line.**

To move a project back, drag it back the other way.

---

## 9. Add or edit a person

People appear on the **Our Team** and **Affiliates** pages. Each person is one file in `_people/`.

Template:

```
---
name: Jane Doe
role: Graduate Fellow
affiliation: Department of Geography and Environmental Studies
groups: [team]
display_order: 20
anchor: jane-doe
image: /assets/images/about/jane-doe.jpg
image_alt: Portrait of Jane Doe
---

A short biography goes here.
```

- Use `groups: [team]` for staff or `groups: [affiliates]` for affiliates.
- `display_order` is a number that decides the order on the page. Smaller numbers come first.
- `anchor` must be unique. Use the person's name with dashes.
- The photo is optional. Upload it to `assets/images/about/`.
- To remove someone, delete their file (right-click it → **Delete**).

---

## 10. Other things to know

- **Nothing is live until it is committed and pushed.** The Actions tab shows progress.
- **Check the live site after every change.** Open the page and make sure it looks right.
- **Search updates itself.** New events, news, and people become searchable automatically.
- **Two pages cannot have the same `permalink`.** The site's checks will stop publication if they do.
- **Never delete the dashes (`---`) that surround the top block** of a page.
- **Do not put passwords or private information** in any file. This repository and website may be public.
- **Photos of people:** get permission before posting.
- **Keep file names simple:** lowercase, dashes instead of spaces, no special characters.
- **Folders starting with `_`, and the `scripts/`, `migration/`, and `.github/` folders:** leave them alone unless you know what you're doing. The `migration/` folder holds historical notes. A more technical guide is in `migration/collections-guide.md` and `scripts/README.md`.
- **Analytics and UNM footer/header:** these are managed by UNM. Do not edit files inside `_includes/unm/` without checking first.
- **Old pages are kept.** Instead of deleting an old story, event, or project, leave it. Events move to the archive on their own, and projects move to "past."
- **New year?** Create a new year folder in `_news/` and `_events/` (for example `_news/2027/`). The year pages are made automatically.
- **Backups:** GitHub stores every version of every file. You can look at the history of any file by right-clicking it and choosing **Open Timeline**.
- **Handing over the site?** Add the new editor as a collaborator on the GitHub repository (Settings → Collaborators) and point them to this guide.

---

## 11. Troubleshooting

| Problem | What to do |
| --- | --- |
| I saved but the website didn't change | You must **Commit & Push** in Source Control. Then wait a few minutes and refresh (Ctrl+F5). |
| The Actions tab shows a red X | Click the failed run, then click **build**. Read the red lines for the file name and message. Fix that file in the browser, then Commit & Push again. The old website stays online meanwhile. |
| Error mentions a date or time | Dates must look like `'2027-03-12'` and times like `'14:00'`, with quote marks. |
| Error mentions "front matter" or "YAML" | Something in the top block between the `---` lines is off: a missing colon, a missing dash, or odd spacing. Compare with a working file. |
| Error mentions an image or "alt" | The image path is wrong, the file wasn't uploaded, or the `alt` text is missing. Check the spelling of the file name (capital letters matter). |
| Error mentions a duplicate URL/permalink | Another page already uses that `permalink`. Make yours unique. |
| Error about the year folder | An event or news file is in the wrong year folder. Move it to the folder that matches its date. |
| My picture doesn't show | Check the file name, the folder, and capital letters. `Photo.JPG` and `photo.jpg` are different. |
| My event isn't in "Upcoming Events" | The date might be in the past, or the file has `date_review: true`. Delete that line. |
| My text looks like one big paragraph | Add a blank line between paragraphs. |
| I can't push my changes | You may not have permission. Ask the website owner to add you as a collaborator. |
| Nothing works | Stop, don't delete anything, and ask for help. All past versions can be restored. |

---

## 12. Cheat sheet

| I want to... | Do this |
| --- | --- |
| Open the editor | Press `.` on the GitHub repository page |
| Find a file fast | Ctrl+P (Cmd+P), then type its name |
| Save a file | Ctrl+S (Cmd+S) |
| Publish my changes | Source Control → message → **Commit & Push** |
| Check if it's live | GitHub → **Actions** tab → green check |
| Add news | New file in `_news/YEAR/` |
| Add an event | New file in `_events/YEAR/` |
| Add a project | New file in `pages/projects/current-projects/` |
| Finish a project | Set `end_date`, drag file to `pages/projects/past-projects/` |
| Add a person | New file in `_people/` |
| Add a picture | Drag into `assets/images/...`, then reference its path |
| Change colors | `assets/css/themes/unm.css` |
| Change the menu | `_data/nav-top.yml` |

*Last updated: October 2026. If something in this guide is out of date, please fix it. This file is `HOW-TO-EDIT-THIS-WEBSITE.md` in the main folder of the repository.*
