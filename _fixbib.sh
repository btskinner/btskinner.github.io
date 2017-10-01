#!/bin/bash

# PURPOSE
#
# To fix {{...}} used by BibDesk that don't play well with Jekyll scholar.
# Replaces {{...}} with "{...}". This respects capitalization and corporation
# names in the author field, but doesn't break Jekyll scholar.
#
# USAGE
#
# ./_fixbib.sh <name of bib file w/path>
#

bib=$1
cat $bib | sed 's/{{\(.*\)}}/"{\1}"/g' > tmp
mv tmp ${bib%.bib}_web.bib

