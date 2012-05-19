---
layout: post
comments: true
title: "Darwin Kernel Compile"
date: 2006-01-13 22:37
comments: true
categories: [Linux]
---
<h1>Compiling the Darwin Kernel</h1>

I'm writing this how-to beause when I wanted to enable MAC address spoofing on my Powerbook, it was a little bit more of an adventure than I had hoped for.  I had to look through a number of different tutorials, picking and choosing what I knew from my experience with Mac OSX and Linux/BSD to be correct; there are a number of conflicting directions in other tutorials.  Hopefully mine makes sense the whole way through.

<h2>Prepare the Build Environment</h2>

To build a Mach kernel you need a number of things, namely, XCode, bootstrap_cmds, Libstreams, cctools, kext-tools, IOKitUser and xnu.  The former is included on any new Mac (run the "Developer Tools" installer in the Applications folder) and the latter must be obtained from the Apple developers site, which requires a (free) membership login.

1. Assuming you have XCode installed, the first thing to do is grab the packages that you'll need for building the kernel.  They can be obtained from the abovementioned location, <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl">http://www.opensource.apple.com/darwinsource/tarballs/apsl</a>.  You'll need the following packages:
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/bootstrap_cmds-44.tar.gz">bootstrap_cmds</a>
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/Libstreams-23.tar.gz">Libstreams</a>
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/cctools-525.tar.gz">cctools</a>
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/kext_tools-42.tar.gz">kext-tools</a>
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/IOKitUser-184.tar.gz">IOKitUser</a>
 - <a href="http://www.opensource.apple.com/darwinsource/tarballs/apsl/xnu-517.11.1.tar.gz">xnu</a>
Just grab those packages (get the latest versions) and toss them into a directory where we can work.  I used /usr/local/src.

2. Untar all of those packages:  <pre># cd /usr/local/src; for i in $(ls); do tar zxvf $i; done</pre>  Whew, that was tough.  Go make a sandwich before continuing.

3. Let's build what we need in `bootstrap_cmds` and `Libstreams`, because they're easy.
<br />**Note**: I'm performing all of these commands as root, which isn't enabled be default on Mac OS X (I think).  Most people will probably more comfortable with untarring/building all of these things in their own userspace (say, your home directory) and then using sudo when you need to be root.  I come from Linux, where _Real Men_ use su.
<br />`# cd bootstrap_cmds-*/relpath.tproj`
<br />`# make`
<br />`# make install`
<br />Now, Libstreams:
<br />`# cd ../../Libstreams-*`
<br />`# make`
<br />`# make install`

4. Time to build cctools, it's a little bit more involved.
<br />`# cd ../cctools-*`
<br />`# cp /usr/include/sys/unistd.h /System/Library/Frameworks/Kernel.framework/Headers/sys/`
We only care about some of what cctools has to offer, so bust open it's `Makefile` and lets edit it a little.  We're going to comment out the two lines (28 and 29) that define `COMMON_SUBDIRS` and redefine it as` COMMON_SUBDIRS = libstuff libmacho misc`.
<br />`#COMMON_SUBDIRS = libstuff as gprof misc libmacho ld libdyld \`
<br />`#                mkshlib otool profileServer RelNotes man cbtlibs`
<br />`COMMON_SUBDIRS = libstuff libmacho misc`
That's what it should look like when you're done, at which point you're ready to build and install it.
<br />`# make RC_OS=macos`
<br />`# cp misc/seg_hack.NEW /usr/local/bin/seg_hack`
<br />`# cd ld`
<br />`# make RC_OS=macos kld_build`
<br />`# cp static_kld/libkld.a /usr/local/lib`
<br />`# ranlib /usr/local/lib/libkld.a`

5. Compiling kextsymboltool is where I ran into trouble, well, because I grabbed the wrong IOKit version (I didn't have the newest one), so watch out for that.  If you get the right version, everything should go smoothly.
<br />`# cd ../../`
<br />`# mv IOKitUser* IOKit`
<br />`# mv IOKit /usr/include`
<br />`# mv /usr/include/IOKit/kext.subproj /usr/include/IOKit/kext`
<br />`# cp -fpr cctools*/include/mach-o /usr/include`
<br />`# cp -fpr cctools*/include/mach/* /usr/include/mach`
<br />`# cd kext_tools*`
<br />`# gcc kextsymboltool.c -o kextsymboltool`
<br />`# cp kextsymboltool /usr/local/bin`
<br />`# chmod 755 /usr/local/bin/kextsymboltool`

__Done!__  Well, sort of.  The build environment is all set up, so now if you ever want to build a new kernel, you can start on the next step.


<h2>Building the Kernel</h2>

1. The first thing to do is apply any patches that you desire.  You'll probably be adding some patches; otherwise, why would you be rebuilding the kernel?  I'm using a patch to enable setting the MAC address of my network cards manually (for MAC address spoofing), one that boots my mac in verbose mode by default and a third that allows all users (not just root) to craft and send raw packets.  They are available from the following locations (the direct links are for xnu version 517):
 - <a href="http://cerberus.sourcefire.com/~jeff/archives/patches/macosx/BIOCSHDRCMPLT-panther.patch">BIOCSHDRCMPLT</a> - MAC address patch by <a href="http://cerberus.sourcefire.com/%7Ejeff/security.html">Jeff Nathan</a>
 - <a href="http://slagheap.net/etherspoof/517/FORCE_VERBOSE.patch">FORCE_VERBOSE</a> - Verbose booting patch by <a href="http://slagheap.net/etherspoof/">Peter Bartoli</a>
 - <a href="http://slagheap.net/etherspoof/517/RAW4ALL.patch">RAW4ALL</a> - Raw packet creation patch also by <a href="http://slagheap.net/etherspoof/">Peter Bartoli</a>
<br />To begin with, let's move to the kernel source directory:
<br />`# cd ../xnu*`
<br />Grab the three patches:
<br />`# wget http://cerberus.sourcefire.com/%7Ejeff/archives/patches/macosx/BIOCSHDRCMPLT-10.3.3.patch`
<br />`# wget http://slagheap.net/etherspoof/517/FORCE_VERBOSE.patch`
<br />`# wget http://slagheap.net/etherspoof/517/RAW4ALL.patch`
<br />and patch the kernel source:
<br />`# patch -p0 -b --verbose --suffix=.orig < RAW4ALL.patch`
<br />`# patch -p0 -b --verbose --suffix=.orig < FORCE_VERBOSE.patch`
<br />`# patch -p0 -b --verbose --suffix=.orig < BIOCHSHDRCMPLT-10.3.3.patch`
Pay attention to the output of those patches; if the source changes significantly from the time I wrote this page, they might not apply properly.  If they work fine, you can move on.

2. Finally, we will actually build the kernel:
<br />`# make exporthdrs`
<br />`# make`
<br />The new kernel is now in `BUILD/obj/RELEASE_PPC/mach_kernel` under the current directory.  Next, we'll install and prepare to boot with the new kernel.

3. To install, just copy the new kernel to the root (/) directory.  We'll name it differently from the stock kernel, so that you have something to fall back on if your new kernel fails to boot properly.
<br />`# cp BUILD/obj/RELEASE_PPC/mach_kernel /mach_kernel.new`
<br />`# chmod 644 /mach_kernel.new`
<br />`# chown root.wheel /mach_kernel.new`
<br />Now configure the machine to boot from the new kernel:

<br />`# nvram boot-file=\`nvram boot-device | awk -F , '{print $1}' | awk '{print $2}'\`,mach_kernel.new`

**Note**: That is supposed to work, but really, didn't for me.  I had  to make a leap-of-faith and replace the stock kernel with the one that I just built.
<br />`# cp mach_kernel mach_kernel.bak`
<br />`# cp mach_kernel.new mach_kernel`
<br />`# nvram boot-file=""`
<br />and then reboot.

You should be all set!  Upon reboot, the computer should boot with your new kernel.  In the event something goes wrong, you can zap the PRAM by holding
option-apple-p-r through <b>three</b> startup chimes.  Alternatively, hold option-apple-o-f which will boot into OpenFirmware; type "reset-all" and then "mac-boot".  If neither of those fixes the problem, hold option-apple-n-v during boot to reset the NVRAM.

<h2>Sources</h2>
<ul>
	<li><a href="http://www.labo-apple.org/en/print/242/">Compile Mac OS X
	Kernel</a></li>
	<li><a href="http://opendarwin.org/~jpm/xnu.html">building xnu on darwin/mac
	os x</a></li>
	<li><a href="http://slagheap.net/etherspoof/">MAC Spoofing on the Mac</a></li>

	<li><a href="http://www.bur.st/~paul/compile_xnu.html">Compiling a Mach/xnu kernel for MacOSX</a></li>
</ul>
