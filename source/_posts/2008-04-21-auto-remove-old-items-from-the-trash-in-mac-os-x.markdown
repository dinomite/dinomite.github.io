--- 
layout: post
comments: true
title: Auto-remove Old Items from The Trash in Mac OS X
mt_id: 204
date: 2008-04-21 11:37:20 -07:00
---
Having a purgatory for files that are on their way to deletion, such as the trash can in Mac OS or the recycle bin in Windows, is a great idea, for even the most careful users occasionally delete something only to find that they later need it.  Unfortunately, the two aforementioned implementations, as well as those in Gnome and KDE, only allow you to empty the trash all at once.  Much more useful is to have a timeout where files that are sent to the trash are automatically removed after a period of time.  I finally got around to implementing this myself in Mac OS by putting the following in my [crontab](http://www.oreilly.com/pub/a/mac/2001/12/14/terminal_one.html):

<pre>
0 5 * * * /usr/bin/find /Users/<username>/.Trash -mindepth 1 -maxdepth 1 -mtime +14 -exec rm -rf {} \;
</pre>

Every day at 0500 any item more than 14 days old is delete from the trash can.  To install it, read the linked article above or, if you know the command line, open a terminal, type `crontab -e`, paste the above (substituting your username) and save the file.

<strong>Edit:</strong> In the comments, Matt mentioned [Compost](http://www.fastforwardsw.com/compost/), a preference pane for OS X that provides the functionality I describe, but also the ability to limit the trash based upon size, and also manage the Trash on other volumes.  Neat!  It's $20, but definitely makes this process easier and understandable if you aren't a Unix person. 
