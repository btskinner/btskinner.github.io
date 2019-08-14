---
layout: post
title: Build R with OpenBLAS and OpenMP support on MacOS 10.14 (Mojave)
category: code
tag: misc
lang: r bash
---

*These instructions have been updated (August 2019) to account for the
fact that Homebrew no longer allows optional installation
arguments. Initally, I just rolled with the changes since was I still
able to set up OpenBLAS support. But after a helpful email exchange
with [Luis Puerto](https://luispuerto.net) in which he pointed out
that the standard (and now optionless) Homebrew R did not have full
`capabilities()`, I've updated this post. I broadly follow his
process, which can be found
[here](https://luispuerto.net/blog/2018/05/11/homebrews-r-doesnt-have-all-the-capabilities/)
and
[here](https://luispuerto.net/blog/2018/05/11/installing-r-with-homebrew-with-all-the-capabilities/),
but with the addition of my `Makevars` and `.Renviron` files. For
reference, the obsolete version of these instructions can be found
[here]({% link
_posts/2018-10-13-install-r-with-openblas-and-openmp-on-macos-mojave-old.md
%}).*


These instructions allow you to compile R from source on MacOS 10.14
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
but YMMV. Of course, I've had to update since Homebrew changed its
default behavior, so keep that in mind if you decide to go this route.   

## Tools

You'll need:

- XCode  
- Homebrew
- `~/.R/Makevars`
- `~/.Renviron`

### XCode

1. Install Command Line Tools through XCode  
  1. You may need to type `xcode-select --install` in the terminal after installation,
     but I got this message which makes me believe this is no longer necessary:
	 ```
	 xcode-select: error: command line tools are already installed, use "Software Update" to install updates
     ```
2. Figure out where your [missing header
     files](https://apple.stackexchange.com/questions/337940) are
     located on your machine. Since 10.14, installing the Command Line
     Tools doesn't place necessary header files (*e.g.*, `math.h`) in
     the `/usr/include` directory, where they have historically been
     and R still looks for them when you build from source. They are
     instead kept within Xcode.app.
	 
	 There are two fixes:
	 
	 1. **NOT RECOMMENDED**  
	 At the time of this post (August 2019),
     you can still just copy the header files to `/usr/include` using
     [this process](https://apple.stackexchange.com/a/337945). I don't
     recommend this approach because it's likely that it will stop
     working with future Apple updates.  
	 2. **RECOMMENDED**   
	 Figure out the path to the SDK headers using the following
	 command:
	 ```
     xcrun --show-sdk-path
	 ```
	 On my machine, the path is
	 ```
	 /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk
	 ```
	 This is the standard path at the moment and so should be the same
	 on your machine unless you've installed Xcode in a non-standard
	 location. Take note of this path because we'll add it to our
	 `Makevars` file.
	 
### Homebrew packages

1. Install [Homebrew](https://brew.sh)  
2. `brew install` some apps/libraries from homebrew-core:  
    - `brew cask install xquartz`
    - `brew install openblas`  
    - `brew install llvm`  
    - `brew install ccache`  
    - `brew install gcc`  
    - `brew install lomp`  
    - `brew install libgit2`  
    - `brew install openssl`  
    - `brew install gettext`  
    - `brew install tcl-tk`  
3. `brew install` some **optional** libraries from homebrew-core:  
    - `brew install liblwgeom`  
    - `brew install gdal`  
    - `brew install geos`  
    - `brew install proj`  
    - `brew install udunits`  
    - `brew install qt`  

    Many R packages look for these libraries on your system if built
    from source, so unless you have compelling reason not to do so, I
    would highly recommend installing them. In particular, the
    [sf](https://github.com/r-spatial/sf) package will need these in
    order to work.

	**NOTE** There's a [Homebrew tap dedicated to QGIS and other
    spatial libraries](https://github.com/OSGeo/homebrew-osgeo4mac)
    currently under development (h/t again to Luis Puerto). You may
    find these more suitable for your geospatial needs than the
    versions provided by homebrew-core.

4. Add [Seth Fore R tap](https://github.com/sethrfore/homebrew-r-srf):  
    ```
	brew tap sethrfore/r-srf
	```

5. `brew install` Cairo and R from `sethrfore/r-srf` tap, adding the
    optional arguments for R:   
    ```
	brew install sethrfore/r-srf/cairo
	```
	**NOTE** You need to install Cairo from this tap if you want to
	have X11 support.
	```
	brew install sethrfore/r-srf/r --with-openblas --with-java --with-cairo --with-libtiff
    ```
    
If everything has gone well, you should be able to open up R and see
the following when you run `capabilities()` (*i.e.*, all `TRUE`):
```
> capabilities()
       jpeg         png        tiff       tcltk         X11        aqua 
       TRUE        TRUE        TRUE        TRUE        TRUE        TRUE 
   http/ftp     sockets      libxml        fifo      cledit       iconv 
       TRUE        TRUE        TRUE        TRUE        TRUE        TRUE 
        NLS     profmem       cairo         ICU long.double     libcurl 
       TRUE        TRUE        TRUE        TRUE        TRUE        TRUE
```
### Set up ~/.Renviron and ~/.R/Makevars

Create `.Renviron` in home directory (`~`) and `Makevars` file in
`~/.R` directory that looks like the files below. **This step is
important.** If you don't add these files, you'll not be able to
install packages since they won't be able to find the system libraries
they need.  

{% gist 98f0501ceb21e1c8e7ff9dbaa5bf7b96 %}

## Install packages

Open R and install packages like normal using `install.packages()`. I
would recommend using the option, `dependencies = TRUE`, if you want
to make sure everything is compiled correctly.  

I have successfully installed the following packages (and their
dependencies) using this set up:  
- [data.table](https://CRAN.R-project.org/package=data.table)  
- [devtools](https://CRAN.R-project.org/package=devtools)  
- [Rcpp](https://CRAN.R-project.org/package=Rcpp)  
- [RcppArmadillo](https://CRAN.R-project.org/package=RcppArmadillo)  
- [RcppEigen](https://CRAN.R-project.org/package=RcppEigen)  
- [rstanarm](https://CRAN.R-project.org/package=rstanarm)  
- [sf](https://CRAN.R-project.org/package=sf)  
- [shiny](https://CRAN.R-project.org/package=shiny)  
- [tidyverse](https://CRAN.R-project.org/package=tidyverse)  


