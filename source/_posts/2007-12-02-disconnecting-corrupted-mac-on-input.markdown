--- 
layout: post
comments: true
title: "Disconnecting: Corrupted MAC on input."
mt_id: 162
date: 2007-12-02 18:25:03 -08:00
---
I woke up to find the entitled error in the `rsnapshot` logs on one of my machines, which occurred as it was trying to remotely backup, via SSH, another.  A quick search and reading through a number of threads revealed [this message](http://monkey.org/openbsd/archive/misc/0207/msg02592.html) stating that this problem was encountered with a Linksys router involved.  Lo and behold, my home network was just switched to a Linksys BEFSR41 when the problem began.

I think the router may also be the culprit for the occasional "error establishing encrypted connection code -12192" that Firefox has been giving me since the switch.
