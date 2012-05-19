--- 
layout: post
comments: true
title: Shell Command Substitution
mt_id: 221
date: 2008-09-09 17:08:07 -07:00
---
The other day I wanted to diff a pair of files on two different hosts, stg1 and stg2.  Normally, I would do so by copying on of the files to the other host, or grabbing them both onto my workstation with `scp`; "there must be a better way," I thought.

Enter command substitution, a process by which you use the output from an executed command as the input to another.  Many people have used this in a simple manner such as ``ls /usr/src/linux-`uname -r` ``which takes the output of `uname -r`, namely the kernel release you're running, and uses that to flesh out the `ls` command.  There is a more complicated form, however, that I use for diffing remote files.  In the aforementioned example, I used the following command to diff the files:

<pre>
vimdiff <(ssh stg1 cat /etc/rc.d/init.d/httpd) <(ssh stg2 cat /etc/rc.d/init.d/httpd)
</pre>

Much like a subselect in MySQL, the `cat` commands are executed on the remote machine and then piped to `vimdiff` allowing for single command, no-file-copying diffs.
