--- 
layout: post
comments: true
title: tar over SSH (part 2)
mt_id: 112
date: 2007-04-26 19:50:18 -07:00
---
[In our last episode](http://dinomite.net/archives/tar-over-ssh) we used tar to move a file structure across the network.  This time, to create a tarball directly onto another machine the following command can be used:

<code>
tar czf - foo/ | ssh user@host "cat > /path/to/foo.tgz"
</code>

This is useful if the machine you're taring from doesn't have enough disk space to hold the tarball.  Furthermore, it's probably faster because the tarball is only being written once, directly to its final location.
