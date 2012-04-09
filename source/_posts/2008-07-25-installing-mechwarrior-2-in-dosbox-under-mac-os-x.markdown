---
layout: post
title: "Installing Mechwarrior 2 in DOSBox Under Mac OS X"
date: 2008-07-25 09:17
comments: true
categories: [Mac]
---
Put the Mechwarrior 2 CD into your Mac's CD drive; it will show up as two mounted discs, one for the audio and one for the game data.  The disc I have is for Mechwarrior 2 v1.1, so the game data is mounted as `/Volumes/MECH2_V1_1`; if you have a different version, the mount point will be slightly different and subsequent commands should be adjusted to match.  To access the disc in DOSBox, you must mount it.  Start DOSBox and type:
<pre>mount d /Volumes/MECH2_V1_1 -t cdrom -usecd 0</pre>
You will also need a place to act as a fake `C` drive, where the game will be installed.  I created a directory `dosprog` in my home directory and mounted it in DOSBox like so:
<pre>mount c ~/dosprog</pre>
To install the game simply go to the mounted CD and run the setup:
<pre>
d:
INSTALL.EXE
</pre>
Follow the installation program, clicking happy things like "yes", "continue" and "full install".  Choose the top-most audio devices in the list.  Next, download the NOCD crack [from here](http://vogons.zetafleet.com/viewtopic.php?t=4454), unzip it in Mac OS and use the files from the crack to replace those in your `dosprog/mech2` folder.  Now, back in DOSBox, go to the c:\MECH2 directory and play:
<pre>
c:
cd c:\MECH2
MECH2.EXE
</pre>
See also: [Vogons](http://vogons.zetafleet.com/viewtopic.php?t=4454)
