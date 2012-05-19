--- 
layout: post
comments: true
title: Changing the Physical Interface for a VMware Bridged Interface
mt_id: 143
date: 2007-09-13 15:36:20 -07:00
---
I use VMware to run a virtual Windows machine for my company's VPN and the occasional game of Starcraft.  When I moved and switch from a wired network to wireless, the device with which I connect to the internet changed from good old `eth0` to the new-fangled `ath0`.  VMware was setup to tie its virtual interface for bridged networking to `eth0`.  Since `eth0` no longer has a network connection, the virtual machine lost the internet as well.  To fix this, I had to open `/etc/vmware/locations` and change the reference to `eth0` to `ath0`.  The virtual interface that I use is `vmnet0` so the line in the file referenced `VNET_0_INTERFACE`.  Simply changing that line and restarting the VMware backend (`/etc/init.d/vmware restart`) fixed everything.
