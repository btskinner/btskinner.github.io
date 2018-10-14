---
layout: post
title: Create dummy variables from categorical variables while keeping labels
category: code
tag: data
lang: stata 
---

Sometimes we want dummy variables but instead have categorical variables. While it's no big deal to create dummy variables from categorical variables, relabeling those dummies can be a total pain if there are a lot of them. This code allows you to insert categorical variables in the local `makedummy` and have them:

1. turned into dummies that
2. retain their variable and value label.

It is robust to categorical variables, whether they start at 0 or 1.

{% gist 869b3658230cc3661c2c %}
