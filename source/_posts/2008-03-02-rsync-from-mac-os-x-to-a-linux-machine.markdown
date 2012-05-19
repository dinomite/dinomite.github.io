--- 
layout: post
comments: true
title: Rsync from Mac OS X to a Linux Machine
mt_id: 190
date: 2008-03-02 08:15:25 -08:00
---
If you try to `rsync` from a Mac OS X machine using the `-E` switch (capture extended attributes & resource forks - you want this) to a Linux or BSD computer, you'll get something like the following error:

<pre>
rsync: on remote machine: -vlogDtprzE: unknown option
rsync error: syntax or usage error (code 1) at main.c(1108)
rsync: connection unexpectedly closed (0 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at /SourceCache/rsync/rsync-30/rsync/io.c(359)
</pre>

What's the holdup?  Well, [resource forks](http://en.wikipedia.org/wiki/Resource_fork) are a purely Mac OS construct (though NTFS has [Alternative Data Streams](http://www.securityfocus.com/infocus/1822) that aren't often used) allowing specific data, such as icons and application metadata, to be [shoved into a file](http://vafer.org/blog/20080215024239).  The standard version of `rsync` doesn't support these containers, so Apple includes a patched version in Mac OS X to handle them and in order to get this support on a non-Mac, you must install this patched version.  Doing so is a fairly simple affair, since Apple makes the patch readily available through their [Darwin source site](http://www.opensource.apple.com/darwinsource/).

Since I'm running Mac OS 10.5.2 (the latest update to Leopard), the files I need are in the 10.5.2 branch of the `darwinsource` directory; change that number to your version of OS X or navigate from the above mentioned Darwin source site.

<pre>
wget http://www.opensource.apple.com/darwinsource/10.5.2/rsync-30/rsync-2.6.3.tar.gz \
http://www.opensource.apple.com/darwinsource/10.5.2/rsync-30/patches/EA.diff
</pre>

Don't ask me why the directory is `rsync-30` when they're using `rsync-2.6.3`.  Now it's just a simple matter of unpacking the source, applying the patch and compiling `rsync`:

<pre>
tar zxf rsync-2.6.3.tar.gz && cd rsync-2.6.3 && patch < ../EA.diff && \
./configure --enable-ea-support && make && sudo make install
</pre>

By default, it installs to `/usr/local/bin/rsync` so installing this version won't trash that put in place by your sytem's package manager.  I also found a post on [macosxhints.com](http://macosxhints.com) concerning `rsync` interacting with the disk indexing of Spotlight.  If you are writing tons of files to a Spotlight-indexed disk on a Mac, the indexer can become overwhelmed.  The solution is to disable Spotlight on the disk in question with `mdutil -i off <mountpoint>` or to write into a directory appended with `.noindex`.
