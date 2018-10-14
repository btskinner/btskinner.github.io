---
layout: post
title: Bash script to fix double braces for Jekyll Scholar
category: code
tag: misc
lang: bash 
---

This bash script corrects double braces in `bib` files that break Jekyll Scholar. I use BibDesk for my citations, which uses braces around all fields. When I add 
braces to preserve formatting, double braces appear, like so (see `Title` field):

{% raw %}
```
@manual{skinner2016rscorecard,
	Author = {Skinner, Benjamin T.},
	Keywords = {technical},
	Note = {R package version 0.2.4},
	Title = {{rscorecard: A Method to Download Department of Education College Scorecard Data}},
	Url = {https://CRAN.R-project.org/package=rscorecard},
	Year = {2016}}
```
{% endraw %}

This is a problem for Jekyll Scholar, which cannot parse the entry. This is true even when `use_raw_bibtex_entry` is set to `true` in `_config.yml`. Running this script on a `bib` file replaces the problematic double braces, {% raw %} `{{...}}`{% endraw %}, with a double-quotation mark brace combination: 
`"{...}"`:

{% raw %}
```
@manual{skinner2016rscorecard,
	Author = {Skinner, Benjamin T.},
	Keywords = {technical},
	Note = {R package version 0.2.4},
	Title = "{rscorecard: A Method to Download Department of Education College Scorecard Data}",
	Url = {https://CRAN.R-project.org/package=rscorecard},
	Year = {2016}}
```
{% endraw %}

So far, this seems to solve my problem.	Script is in the gist is below.

{% gist f22e53e0a840c31d21f478b7996cfa98 %}
