--- 
layout: post
comments: true
title: Changing default paper size in Ubuntu
mt_id: 135
date: 2007-08-08 08:35:33 -07:00
---
Ubuntu's default paper size is the very international [A4](http://en.wikipedia.org/wiki/A4_paper_size).   Unfortunately, here in the United States the standard size of paper is Letter (8&#189; inches by 11 inches).  When trying to print, Ubuntu will tell printers to use A4 paper unless you select 'Letter' in the print dialog each time.  To change this default, simply run the following command which will set the value in `/etc/papersize`:

<code>
sudo dpkg-reconfigure libpaper1
</code>
