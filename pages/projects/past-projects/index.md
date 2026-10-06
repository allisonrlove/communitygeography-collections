---
title: Past Projects
permalink: "/projects/past-projects/index.html"
source_url: https://communitygeography.unm.edu/projects/past-projects/index.html
section: Projects
section_url: "/projects/index.html"
summary: Completed community geography projects, including the students, faculty, and community partners behind them.
---

# Past Projects

<p class="past-projects-gallery-link"><a href="{{ '/projects/gis-day-2025-gallery.html' | relative_url }}">View the 2025 GIS Day photo gallery &rarr;</a></p>

{% assign past_projects = site.pages | where_exp: "p", "p.path contains 'projects/past-projects/' and p.name != 'index.md'" %}
{% include community/past-projects.html projects=past_projects %}
