# Personal website

Code for my personal website at [btskinner.io](https://btskinner.io).

## Steps to update / publish site

Below are the steps I use to update and publish my site. Since I want
a dynamic site that incorporates, for example, javascript
visualizations, it's a little more complicated than just pushing to
the master branch. This is the solution I cobbled together using tips
from others who've had the same issues. I started this site a few
years ago and it's possible that there are better solutions now, but
this works for me.

1. Have two branches: *source* and *master*
   - *source* holds the core files used to build the site
   - *master* holds the built website files / serves the site
2. When updating, make local changes on my machine in the *source*
   branch
   - use `./_fixbib.sh ./bibliography/<my_citation_bib_file>.bib` to clean up
     personal `bib` file so that it plays more nicely with
     [`jekyll-scholar`](https://github.com/inukshuk/jekyll-scholar). *This
     may no longer be necessary, but I had trouble in the past with
     Jekyll not properly parsing braces when building citations*.
3. Build and test the site locally using `build exec jekyll serve` in
   the command line
   - **NB** Some links to external repos may not work locally
   - The built site, which is dynamic, now lives in `_site` in the
     *source* branch.
4. Once happy with changes, `add`, `commit`, and `push` changes to
   *source* branch
5. Run `./_publishwebsite.sh` script  
   - Script is mostly these commands [from
here](https://github.com/randymorris/randymorris.github.com)
   - The gist is that the *master* branch is fully deleted and only
   files from `_site` are placed in it. Since GitHub isn't coverting
   `.md` files but instead reads `.html` and other files directly, all
   dynamic features coming from javascript should work (that is, not
   scrubbed). 

Over time, the process to rebuild the *master* branch can take a while
since you are filtering through all the changes in *source*. If you
don't need a full record of your website changes over time, it may
make sense to prune or make a shallow clone of your source code every
now and again to speed up `./_publishwebsite`.
