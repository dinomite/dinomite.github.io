--- 
layout: post
comments: true
title: Marvell Gigabit ethernet adapter
mt_id: 58
date: 2006-03-29 14:01:21 -08:00
---
I bought a Shuttle SB86i a few months ago, which is an Intel based small form factor system ([reviewed by Silent PC Review](http://www.silentpcreview.com/article230-page1.html)) which came with an on-board gigabit ethernet adapter.  This piece is referred to by <code>lspci</code> as a "Marvell Technology Groupl Ltd. 88E8053 Gigabit Ethernet Controller (rev 15)" and by <code>dmesg</code> as a "Yukon Gigabit Ethernet 10/100/1000Base-T Adapter".  Either way, the chipset is made by SysKonnect and the driver in the kernel tree (sk98lin) just plain doesn't work.  A quick search  (via Google, what else?) turned up [this post](http://www.grad.name/blog/2006/01/28/marvell-gigabit-on-linux/) which referenced [SysKonnect's driver page](http://www.skd.de/e_en/support/driver.html).  Fromt the driver page (I chose the 'SK-9E21D 10/100/1000Base-T Adapter' under 'PCI Express Desktop Adapter') I was able to get their very simple package to build the kernel module on my Ubuntu system, all you need are the compiled kernel sources for the kernel you're running.  If you don't know anything about your kernel and you're running Ubuntu (Dapper Drake, probably others), run this command as root to get and compile the kernel sources:

<pre><code>
~# KERNEL_VERSION=`uname -r|grep -o "2\.[4|6]\.[1|2|][0-9]"` &&\
 apt-get install linux-source-$KERNEL_VERSION &&\
 cd /usr/src && /bin/tar jxf linux-source-$KERNEL_VERSION.tar.bz2 &&\
 ln -s linux-source-$KERNEL_VERSION linux &&\
 cd linux-source-$KERNEL_VERSION &&\
 cp /boot/config-$KERNEL_VERSION-* .config &&\
 make oldconfig && make
</code></pre>

...and then install the driver from SysKonnect.  If you don't know what the above comman does, pick it apart and figure it out!  That's what Linux is all about.
(cool regex, eh?)
