#!/usr/bin/env bash

export FILTER_BRANCH_SQUELCH_WARNING=1

git branch -D main
git checkout -b main
git filter-branch --subdirectory-filter _site/ -f
git reflog expire --expire=now --all
git gc --prune=now
git checkout source
git push --all origin
