--- 
layout: post
comments: true
title: Installing VMware Workstation on Ubuntu Feisty (7.04)
mt_id: 115
date: 2007-06-01 09:43:31 -07:00
---
I found a new, easy process for installing VMware on Ubuntu, having updated the kernel on my Feisty machine since the last time I used the virtual machine.  Whenever the kernel changes, VMware needs to rebuild it's kernel module to suit, via the script `vmware-config.pl`.  This involves a few steps such that VMware can correctly build it's module against the kernel you're running.  First, you need to grab the headers for your running kernel and set them up to support building:

<pre>
~$ sudo -i
~# aptitude install linux-headers-`uname -r`
~# cd /usr/src/
/usr/src# ln -s linux-headers-2.6.20-16-`uname -r` linux
/usr/src# cd linux
/usr/src/linux# cp /boot/config-`uname -r` .config
/usr/src/linux# make oldconfig && make prepare0 && make scripts
</pre>

The above installs the kernel headers for your current kernel (`uname -r' gives the running kernel's version), gets the `.config` for said kernel and preps the headers per the `.config`.  Now, on to the VMware part of things.

Installing VMware is really easy, thanks to [this patch](http://ftp.cvut.cz/vmware/vmware-any-any-update109.tar.gz).  You simply need to get the patch, untar and run it; the script included invokes the VMware configurator automatically.

<pre>
/usr/src# wget http://ftp.cvut.cz/vmware/vmware-any-any-update109.tar.gz
/usr/src# tar zxf vmware-any-any-update109.tar.gz
/usr/src# cd vmware-any-any-update109
/usr/src/vmware-any-any-update109# ./runme.pl
</pre>

Follow the directions provided by the VMware configuration script (the defaults are safe, but read the information) and you're done.
