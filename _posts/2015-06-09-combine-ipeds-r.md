---
layout: post
title: Combine IPEDS data files into a single dataset
category: code
tag: data
lang: r 
---

The purpose of this file is automate the process of combining:

1. yearly versions of IPEDS survey files (e.g., HD2010.csv, HD2011.csv)  
2. datasets created in (1) into a single master dataset.

The code assumes you've downloaded the zipped files you will need from the [IPEDS datacenter](http://nces.ed.gov/ipeds/datacenter/DataFiles.aspx) and placed this code in the same directory.

{% gist f42c87507169d0ba773c %}
