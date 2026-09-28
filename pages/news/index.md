---
title: Recent News
permalink: /news/index.html
source_url: https://communitygeography.unm.edu/news/index.html
section: News
section_url: /news/index.html
---

## Recent News

{% assign news_years = site.news | where_exp: 'story', 'story.archived != true' | map: 'archive_year' | uniq | sort | reverse %}
<nav aria-label="News by year"><p>{% for year in news_years %}<a href="{{ '/news/' | append: year | append: '.html' | relative_url }}">{{ year }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}</p></nav>

{% include community/news-list.html %}
