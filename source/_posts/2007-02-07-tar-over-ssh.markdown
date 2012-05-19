--- 
layout: post
comments: true
title: tar Over SSH
mt_id: 89
date: 2007-02-07 06:10:45 -08:00
---
`scp` is great for ease of use, but if you're transferring numerous files, small ones in particular, it isn't the fastest method.  `tar`, however, is very well suited to gathering small files into a single unit, but `tar`ing the files, `scp`ing the tarball and then un-`tar`ing on the other end is inefficient; we have pipes in unix for a reason.  Like all good command line utilities, tar can dish out and accept input from a pipe, so this is really quite straightforward:

<code>
tar cf - sourcedir/ | ssh user@dest_host tar xf - -C /destination/path
</code>

Make note of those naked dashes - they are the secret to this whole operation.  First we call the `tar` command with the options to <b>c</b>reate a tarball and that the <b>f</b>ilename to output immediately follows the options; in this case, we tell it to pipe the output to `stdout`.  Finally, we give the first `tar` command the list of files (a directory in this example) that we want sent.  The output of that tar command (the tarball itself, since we directed output to `stdout`) gets piped to `ssh` which is invoked like you normally would, except with a command to run tacked on the end.  As soon as `ssh` connects to the destination host, it simply runs `tar`, which listens for an input file coming from `stdin` that it will unpack into the directory given by `-C`.

<addendum>
I noticed that a lot of people Google for "tar over scp", which might be your first thought if you've never done this before.  This note is just to help those people out, because this is most likely the solution they are in search of.
