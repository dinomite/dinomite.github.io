--- 
layout: post
comments: true
title: Installing Proggy Fonts in Ubuntu
mt_id: 205
date: 2008-05-06 13:56:56 -07:00
---
I don't recall how I came across the free [Proggy font family](http://www.proggyfonts.com/) but I wanted to try them out on my Ubuntu workstation for use in Eclipse.  After some searching, I figured out how to install TrueType (.ttf) fonts and the process is pretty straightforward.  I downloaded and unpacked the fonts into `~/.fonts`, created a fonts.dir metadata file, added them to the font cache and when I restarted Eclipse, they were available.

<pre class="brush: bash;">
~$ mkdir .fonts
~$ cd .fonts
~/.fonts$ wget http://www.proggyfonts.com/download/download_bridge.php?get=ProggyCl
ean.ttf.zip
~/.fonts$ wget http://www.proggyfonts.com/download/download_bridge.php?get=ProggySq
uare.ttf.zip
~/.fonts$ wget http://www.proggyfonts.com/download/download_bridge.php?get=ProggyS
mall.ttf.zip
~/.fonts$ ttmkfdir -o fonts.dir
~/.fonts$ fc-cache -f -v
</pre>
