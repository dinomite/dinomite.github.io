--- 
layout: post
comments: true
title: Setting Up Ubuntu for Building Kernel Modules
mt_id: 84
date: 2007-02-06 11:16:31 -08:00
---
When you build kernel modules or other programs that depend upon the kernel you need to have the kernel source configured per the currently running kernel.  To see what kernel your machine is running, simply run `uname -a`.  To setup your machine to allow things to build against the kernel, you first need the source for your currently running kernel:

<pre class="brush: bash;">
export KERNEL_VERSION=`uname -r|cut -d '-' -f 1`
sudo aptitude install linux-source-$KERNEL_VERSION
cd /usr/src/
sudo tar jxf linux-source-$KERNEL_VERSION.tar.bz2
sudo ln -s linux-source-$KERNEL_VERSION linux
ln -s /usr/src/linux /lib/modules/`uname -r`/build
</pre>

First, in order to get things to build against the kernel you have to alter a single file to match the kernel you're running.  Run `uname -r` and note everything following the first three decimal-separated numbers:

<pre class="brush: bash;">
$ uname -r
2.6.17-10-386
</pre>

Just use a text editor (vi!) and edit ` /usr/src/linux/Makefile`, changing the `EXTRAVERSION` variable to match yours from above:

<pre class="brush: bash;">
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 17
#EXTRAVERSION = .14-ubuntu1
EXTRAVERSION = -10-386
NAME=Crazed Snow-Weasel
</pre>

Next, you need to get the .config for the running kernel and setup the kernel source:

<pre class="brush: bash;">
sudo cp /boot/config-`uname -r` /usr/src/linux/.config
cd /usr/src/linux
make oldconfig
make prepare0
make scripts
</pre>

That's it.  Now you should be able to build things, like kernel modules, against the kernel source.
