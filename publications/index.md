---
layout: page
---

## Peer reviewed publications

{% bibliography --query @article[keywords ^= article] %}

## Policy reports, briefs, and other writing

{% bibliography --query @article[keywords ^= otherpub] %}

## Analyst

{% bibliography --query @techreport[keywords ^= analyst] %}
