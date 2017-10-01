---
layout: post
title: Module to include online markdown files in Jekyll site
category: code
tag: misc
lang: ruby 
---

This ruby module is a [fork from another module](https://gist.github.com/mignev/7759676) that allowed one to include markdown files located in the `_includes` folder. My modification allows online markdown code to be included. I use it to include my GitHub-hosted README files in my code posts since there's no point in saving them in two locations (as well as risk having them diverge over time). Place this script in the `_plugins` folder of the Jekyll site directory.

{% gist 4dbe92f204bee43e82c2 %}
