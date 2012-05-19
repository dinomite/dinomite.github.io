--- 
layout: post
comments: true
title: Linksys WUSB54G in Ubuntu
mt_id: 141
date: 2007-09-01 14:50:04 -07:00
---
Since we're going all-wireless in my new house, I had to setup my Ubuntu machine with a wireless card.  All of the slots on the computer are filled, so I grabbed a Linksys WUSB54G USB (hence the model number) adapter.  Installing it required some terminal work, unusual for Ubuntu.  [This thread](http://ubuntuforums.org/showthread.php?t=478558) gives a somewhat cryptic outline of the steps required to get the card working and following them requires a bit of Linux experience.  For the unexperienced, read on.

After plugging the card in on my Feisty machine, it came up in the network manager (System > Administration > Network) but wouldn't connect to any networks, be they open or encrypted, G or B, nothing.  So I retreated to the interwebs and found that [ndiswrapper](http://ndiswrapper.sourceforge.net/joomla/) was the solution to my problems.  To begin, install `ndiswrapper-utils-1.9`:

<pre>
~$ sudo aptitude install ndiswrapper-utils-1.9
</pre>

Then, download the latest driver from the Linksys site, unzip it and find the WUSB54Gv4 directory under the Drivers directory.  Run `ndiswrapper -v` and check to make sure there aren't any errors.  Then, install the new Linksys driver.

<pre>
~$ sudo ndiswrapper -i rt2500usb.inf
utils version: 1.9
driver version:        1.38
vermagic:       2.6.20-16-generic SMP mod_unload 586
~$ sudo depmod -a
~$ sudo modprobe ndiswrapper
~$ sudo ndiswrapper -m
</pre>

You have to blacklist the standard kernel driver so that it won't override the `ndiswrapper` driver.  To do so, add the following to the end of `/etc/modprobe.d/blacklist`:

<pre>
# WUSB54G driver
blacklist rt2570
</pre>

Then, restart your machine and you should be able to configure wireless using the Gnome GUI tools.
