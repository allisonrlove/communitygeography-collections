---
title: Projects
permalink: "/projects/index.html"
source_url: https://communitygeography.unm.edu/projects/index.html
summary: Active, student- and faculty-led community geography projects currently underway.
---

# Projects

{% assign current_projects = site.pages | where_exp: "p", "p.path contains 'projects/current-projects/'" %}
{% include community/current-projects.html projects=current_projects %}
