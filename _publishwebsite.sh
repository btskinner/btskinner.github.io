#!/bin/bash

git branch -D master
git checkout -b master
git filter-branch --subdirectory-filter _site/ -f
git reflog expire --expire=now --all
git gc --prune=now
git checkout source
git push --all origin
