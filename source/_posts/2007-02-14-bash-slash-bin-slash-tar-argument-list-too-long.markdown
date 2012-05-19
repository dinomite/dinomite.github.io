--- 
layout: post
comments: true
title: "bash: /bin/tar: Argument list too long"
mt_id: 91
date: 2007-02-14 06:25:27 -08:00
---
Anyone who has worked with large numbers of files has seen the error '`Argument list too long`' returned by a command before, usually something like `cp` or `rm`.  Eventually, they find `xargs` and all is well again; rather than globbing directly, you use `find` and `xargs` to feed the intended command:

<pre>
~/tmp$ ls | wc -l
77029
~/tmp$ cp * /foo/bar/
bash: /bin/cp: Argument list too long
~/tmp$ find . -print0 | xargs -0 -I {} cp {} /foo/bar/
</pre>

For those who don't know, that final command is running find, which simply prints a list of the files in the current directory.  `xargs` then passes a not-too-long subset of that list to `cp` in batches, replacing the {} with said list.  The `-print0` tells `find` to terminate each filename with a null character rather than the default newline, so that weird filenames work; the corresponding option `-0` must be used with `xargs` so that it looks for that syntax.  Now, on to the problem of the day.

I know `xargs`, but for the problem I had, I didn't think it would help (more on that later).  I wanted to `tar` up a whole bunch of files, too many for the command line to handle.  The solution was simple, for `tar` provides an option to receive its list of files that makeup an archive from a file:

<pre>
~/tmp$ find . -print > baz.lst
~/tmp$ tar -cf baz.tar --files-from baz.lst
</pre>

Simple.  There's probably a way to one-line that, but simply piping the output of `find` to tar with `--files-from -` didn't work, and I didn't spend any more time trying to figure it out.  As I said previously, I didn't think `xargs` would help, but I pulled up the `tar` manpage and, using the `-r` option, you can append to an existing archive, which could work in conjunction with `xargs` just fine.
