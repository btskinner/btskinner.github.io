---
layout: page
---

## Peer reviewed

{% bibliography --query @article[keywords ^= article] %}

## Software packages

{% bibliography --query @manual[keywords ^= software] %}

## Analyst

{% bibliography --query @techreport[keywords ^= analyst] %}