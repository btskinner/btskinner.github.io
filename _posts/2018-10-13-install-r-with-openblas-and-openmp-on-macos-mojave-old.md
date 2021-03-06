---
layout: post
title: OUTDATED Build R with OpenBLAS and OpenMP support on MacOS 10.14 (Mojave)
category: code
tag: __misc
lang: r bash
hide: true
---

*These instructions have been updated (August 2019) to account for the
fact that Homebrew no longer allows optional installation
arguments. If you've landed on this page from an external site, you
most likely want to use the [new instructions here]({% link
_posts/2018-10-13-install-r-with-openblas-and-openmp-on-macos-mojave.md
%}). I've left this old version of page active for reference*

These instructions are to compile R from source on MacOS 10.14
(Mojave) so that it both uses OpenBLAS libraries ([for faster
computations](https://www.r-bloggers.com/why-is-r-slow-some-explanations-and-mklopenblas-setup-to-try-to-fix-this/))
and has OpenMP support ([to take advantage of multiple
cores](https://www.r-bloggers.com/openmp-tutorial-with-r-interface/)).

## Rationale

While the Clang compilers shipped with R finally support OpenMP for
parallel processing, [they require their own unique
flags](https://iscinumpy.gitlab.io/post/omp-on-high-sierra/). The GNU
family of compilers (`gcc`, `g++`, etc) don't play nice with all R
packages when building them from source. I figured both out the hard way.  

To get R to work with both OpenMP (after compiling with OpenBLAS)
and packages built from source, I use a newer, non-Apple version of
the [LLVM compiler](https://llvm.org).

## But why?

Why not?

Seriously, don't try this if you don't like the command line or have a
low tolerance for potentially borking your R installation. This worked
for me and was a (mostly) fun project while setting up a new machine,
but YMMV. 

## Tools

You'll need:

- XCode  
- Homebrew
- `~/.R/Makevars`

### XCode

1. Install Command Line Tools through XCode  
  1. You may need to type `xcode-select --install` in the terminal after installation,
     but I got this message which makes me believe this is no longer necessary:
	 ```
	 xcode-select: error: command line tools are already installed, use "Software Update" to install updates
     ```
2. Install [missing header
   files](https://silvae86.github.io/sysadmin/mac/osx/mojave/beta/libxml2/2018/07/05/fixing-missing-headers-for-homebrew-in-mac-osx-mojave.html)
   using: 
   ```
   cp /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg ~/Desktop
   ```
   Once saved, double click on the install package (which is now on
   your Desktop). This will place header files (*e.g.*, `math.h`) in
   the `/usr/include` directory, where they have historically been and
   R still looks for them.
   
**NB**: As 10.14 becomes more mature, this intial XCode work-around
may not be necessary. 

### Homebrew packages

1. Install [Homebrew](https://brew.sh)  
2. Brew install some packages:  

- `brew install openblas`  
- `brew install r`  
- `brew install llvm`  
- `brew install ccache`  
- `brew install gcc`  
- `brew install libgit2`  
- `brew install openssl`  
- `brew install gettext`  

Note that you don't technically need the last three libraries, but
many R packages look for them if built from source. You'll see that
they are place in the compilation path in `Makevars` below.

### Set up ~/.R/Makevars

Create `Makevars` file in `~/.R` directory that looks like this

{% gist 81511cbc878eb08c8abcccef6c30f829 %}

## Install packages

Open R and install packages like normal using `install.packages()`. I
found that installing [Rcpp](https://CRAN.R-project.org/package=Rcpp),
[data.table](https://CRAN.R-project.org/package=data.table), and
[tidyverse](https://CRAN.R-project.org/package=tidyverse) will give a
good all-around indication of whether everything worked.
