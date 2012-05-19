--- 
layout: post
comments: true
title: Synchronizing an iTunes Library Between Two Computers
mt_id: 262
date: 2010-10-26 14:14:03 -07:00
---
Like many folks, I have a desktop that I use for most of my computing, and a laptop that I use while travelling, at a coffee shop, or perhaps while <a href="http://www.suntimes.com/technology/ihnatko/2745228,ihnatko-multitasking-twitter-internet-092510.article">watching tv</a>.  The other thing I have is a lot of music, all nicely rated and organized in iTunes. The problem is that new music I get goes onto my desktop, but I would like to have the exact same stuff on my laptop.  Enter <a href="http://github.com/dinomite/iTunes-Sync">iTunes-Sync</a>, a simple script that I wrote to synchronize the iTunes library file and all of the content (music, etc.) that it depends upon between the two machines.  

Using iTunes-Sync is simple:

<pre lang="bash">
laptop:~/$ perl itunes_sync.pl dinomite 192.168.1.100
</pre>

That's all there is to it.  The script copies the `iTunes Library` file wholesale, and uses `rsync(1)` to pull over the album art, mobile applications, and music directories.

I only care about getting everything from my desktop to the laptop--if you want to go both ways, or perhaps preserve metadata changes made on the laptop the process will be a bit more involved.  Before you use your laptop, close iTunes on both machines, and then run iTunes-Sync from the laptop.  Go out and have fun.  When you get back, close iTunes on both machines and run iTunes-Sync from the desktop.

You can get iTunes-Sync on [GitHub](http://github.com/dinomite/iTunes-Sync); the only thing you need is the [itunes_sync.pl](http://github.com/dinomite/iTunes-Sync/raw/master/itunes_sync.pl) file itself. 
