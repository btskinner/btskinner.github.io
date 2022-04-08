---
layout: page
---

## Peer-reviewed conference presentations
**_Co-author presenter_

{% bibliography --query @*[keywords ~= conference && keywords ~= peer && keywords != working] %}

## Invited presentations

{% bibliography --query @*[keywords ~= conference && keywords ~= invited && keywords != working] %}

## Course presentations

{% bibliography --query @*[keywords ^= class && keywords != working] %}

