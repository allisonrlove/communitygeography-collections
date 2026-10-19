# Community Geography — collections

> **New editor? Start here: [HOW-TO-EDIT-THIS-WEBSITE.md](HOW-TO-EDIT-THIS-WEBSITE.md)** — a step-by-step guide for people with no coding experience.

This stage builds on [communitygeography-reorg](https://github.com/amaranth-unm/communitygeography-reorg), with the original UNM/Xanthan appearance and public routes. It demonstrates how editors can maintain one record and have pages, lists, and search update consistently.

| Stage | Demonstrates |
| --- | --- |
| [communitygeography-orig](https://github.com/amaranth-unm/communitygeography-orig) | Frozen converted baseline; documented conversion repairs already applied. |
| [communitygeography-reorg](https://github.com/amaranth-unm/communitygeography-reorg) | Organized page sources/images/documents, with matching baseline rendering. |
| **communitygeography-collections** | 45 events, 39 news records, 15 people, descriptive source names, and shared content patterns. |

The earlier `communitygeography` repository contains the separate working-copy/design experiment. Its proposed visual redesign is not included here.

## Edit here

- `_events/YYYY/`: one event, structured dates/details and Markdown description.
- `_news/YYYY/`: one story, publication metadata and Markdown article.
- `_people/`: one directory entry, identity/affiliation and Markdown biography.
- `pages/`: explanatory pages, directory wrappers, archives, and ordinary project pages.
- `assets/images/` and `assets/documents/`: organized media, with original URLs preserved by a build-time compatibility map.

Follow the [editor guide](migration/collections-guide.md). Existing `permalink` values preserve public addresses while source names improve. All 134 imported routes remain; three formerly embedded records add detail pages. The source Cascade domain is unchanged.

## Edit and publish through GitHub

No local development or software installation is required.

1. Open the [browser VS Code editor](https://github.dev/amaranth-unm/communitygeography-collections) and edit the relevant content file.
2. Use **Source Control** to stage your changes, add a short description, and select **Commit & Push**. Saving a file alone does not publish it.
3. Changes reaching `main` automatically start **Deploy Jekyll site to Pages**. If you edit on a branch, merge its pull request into `main` when ready.
4. Open the repository's [Actions tab](https://github.com/amaranth-unm/communitygeography-collections/actions) and check that both **build** and **deploy** succeed. Then follow the deployment link to view the website.

GitHub runs the Ruby plugins and all publishing checks. Failed checks stop publication; fix the reported file in the browser and commit again. The current workflows do not automatically check pull requests or provide a draft-site preview. A scheduled daily build refreshes upcoming events.

The [scripts and automation guide](scripts/README.md) explains every script, both plugins, the two workflows, and how to read errors. Image optimization is available through **Actions → Optimize Images → Run workflow**; follow the [image guide](migration/image-optimization.md).

Read the [verification record](migration/collections-verification.md), [editorial questions](migration/editorial-review.md), and [handoff](migration/start-here.md). `migration-baseline` identifies the original converted baseline; `reorganization-baseline` identifies this stage's parent. `scripts/check-reorganization.rb` belongs to that parent and intentionally does not pass after presentation/collection changes; use the collection checks here.
