--- 
layout: post
comments: true
title: Time Machine for Linux
mt_id: 159
date: 2007-11-15 07:22:27 -08:00
---
Since Apple's recent release of Leopard, which comes with the wonderful backup solution <em>Time Machine</em>, I've seen more than a few articles explaining how those with Linux/Unix machines can create there own incremental backups using `rsync`.  This is great and, short of hard-linked directories, exactly like Apple's <em>Time Machine</em> backend.  Furthermore, this has always been possible on systems with `rsync` available and filesystems that support hardlinks.  I've been doing incremental backups for years but, unlike all of the recent articles in question, I didn't roll my own solution: I use 'rsnapshot' to do all of the hard work for me.

There are a [number](http://www.debian-administration.org/articles/217) of [tutorials](www.mikerubel.org/computers/rsync_snapshots/) for setting up `rsnapshot` and the process is really quite simple.  First, install `rsnapshot`; if you're using a system with a [good](http://www.debian.org) [package](http://www.ubuntu.org) [manager](http://www.freebsd.org), then this is a trivial operation:

<pre>
~$ sudo aptitude install rsnapshot
</pre>

Next, you must edit the `rsnapshot.conf` file which, in most Linux distributions, resides in `/etc`.  Note that the key/value pairs in this file must be <b>tab</b> delimited.  The file is well commented; the major things that need to be changed are:

* `snapshot_root` - where the backups will be stored
* backup intervals - how many of each interval to keep around (I do 7 dailys, 4 weeklys and 3 monthlys)
* backup points - what to backup

The last point requires some elaboration, as this is what `rsnapshot` will be backing up.  for a server that is only backing up it's own stuff this can be fairly simple:

<pre>
backup    /etc/            servername/
backup    /var/lib/svn/    servername/
backup    /home/           servername/
</pre>

Which tells `rsnapshot` to backup `/etc`, `/home` and the subversion repository and place them in the directory `servername` under the `snapshot_root` directory.  `rsnapshot` is also capable of backup up remote hosts via ssh:

<pre>
backup    root@remote:/etc/     remote/     +rsync_long_args=--bwlimit=120
backup    root@remote:/home/    remote/     +rsync_long_args=--bwlimit=120
</pre>

As above, this will backup the contents of the specified directories under the `remote_host` directory in your `snapshot_root` directory.  This also gives an example of passing arguments to `rsync` for that host.  I use this to backup my home machine to my server; since I'm on a residential internet link, I tell `rsync` to limit its bandwidth usage to 120 kilobytes per second when it is backing up this host to keep from saturating the pipe.
