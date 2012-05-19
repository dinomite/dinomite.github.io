--- 
layout: post
comments: true
title: EXMAP on Ubuntu
mt_id: 142
date: 2007-09-11 17:05:46 -07:00
---
EXMAP is a shared memory analysis utility that makes it easy to determine exactly how much memory a process is using.  Unlike `top`, which counts all memory shared amongst programs toward each of those programs, EXMAP gives three numbers most notable of which is "Effective Resident" memory usage.  This number is the amount of memory mapped directly by a process, plus a portion of any shared memory pools it is part of, that is, the program is only counted as using an equal portion of shared memory as all other processes that are sharing the same.

On my system, both Gaim (Pidgin my foot) and Evolution are using aspell.  In top, they are both responsible for libaspell.so in its entirety, contributing 672K to each of their displayed memory usage.  EXMAP puts 338K towards Gaim and 334K to Evolution, a much more accurate tally, since only a single instance of libaspell is actually in memory, shared by the two other processes.  From my quick testing, it seems that subsequent users of shared memory take the larger share, 4K more in Gaim's case, since I started it after Evolution.  If I close Gaim, Evolution is then credited with the entire 632K of memory that libaspell occupies.

So, on to installing EXMAP which certainly isn't hard, but requires a kernel module which makes it non-trivial.  First, use `apt-get` (or really, it's better replacement `aptitude`) to install EXMAP, the required kernel module source and the stuff you'll need to build said module:

<pre>
sudo -i
aptitude install linux-headers-$(uname -r)
aptitude install module-assistant build-essential
aptitude install exmap exmap-modules-source
</pre>

Then, build the EXMAP module:

<pre>
module-assistant prepare
module-assistant update
module-assistant build exmap
module-assistant install exmap
depmod
modprobe exmap
echo exmap >> /etc/modules
</pre>

`module-assistant` automatically compiles and installs the module against the kernel headers that `aptitude` installed in the previous block and `depmod` calculates the dependencies amongst all modules, including the new EXMAP one.  `modprobe` installs the new module into the kernel and adding its name to `/etc/modules` ensures that it will be ready next time your system restarts as well.  Once all that is done, you can run `gexmap`.
