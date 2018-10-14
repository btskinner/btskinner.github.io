---
layout: post
title: Add variable and value labels to IPEDS data in R
category: code
tag: data
lang: r 
---

The purpose of this script is to add Stata variable and value labels
to IPEDS data in R and save the result. One could also use Stata to
(1) read in the data, (2) assign the labels, (3) save the result as a
`*.dta` file, and then (4) use the
[`haven`](https://cran.r-project.org/package=haven) package to read
the labelled data into R. This script represents a pure R
solution. You will need the
[`tidyverse`](https://cran.r-project.org/package=tidyverse) and
[`labelled`](https://cran.r-project.org/package=labelled) packages.

To use, download the Stata version of each required data file from
[IPEDS](https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx)
(`*_Data_Stata.zip`, which is really just a CSV file) along with its
accompanying labelling file, `*_Stata.zip`). Do not unzip the
files. By default, the script assumes these two sets of files and all
output will be in the same directory. If you want to use separate
folders for the Stata data, Stata label, and output R data files, you
can set the paths in the script.

(You can batch download the IPEDS files you need using
[`downloadipeds.r`](https://github.com/btskinner/downloadipeds). Simply
comment out or erase the files you don't want in the accompanying
`ipeds_file_list.txt` and make sure you set the option `stata_data ==
TRUE` in the main script.)

Due to changes across IPEDS data files over the years, it's probable
that some files will not be labelled correctly. That said the script does
run (that is, assign labels) for all IPEDS zip files available as of
mid-June 2018.

{% gist c8654a4369900d7914310fbb77103c14 %}
