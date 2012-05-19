--- 
layout: post
comments: true
title: Fast Downloads with Metalink
mt_id: 118
date: 2007-06-20 16:24:20 -07:00
---
Reading the [Slashdot thread](http://bsd.slashdot.org/article.pl?sid=07/06/19/1847206) about [PC-BSD](http://en.wikipedia.org/wiki/PC-BSD) someone mentioned that there was a VMWare image pre-installed for playing around with it.  On the [download page](http://www.pcbsd.org/?p=download#vmware), in addition to being able to select mirrors, as one expects with a large file, there was a [Metalink](http://en.wikipedia.org/wiki/Metalink).  Not to be confused with Oracle's worthless support website, Metalinks are files that describe methods for obtaining a file, in this case, HTTP and FTP locations where it is available and hashes for pieces of the file.  After first trying a couple of mirrors and only getting ~60Kb/s I grabbed the Metalink file and installed [Aria2](http://aria2.sourceforge.net/), a command-line Metalink downloader.  I simply pointed aria2 to the Metalink file (it can also take the URL of the Metalink) and it started downloading from 15 of the servers in the list simultaneously.  Needless to say, this resulted in a *much* faster download.  More information about Metalinks, including projects that employ them, can be found at the [Metalink website](http://metalinker.org/).
