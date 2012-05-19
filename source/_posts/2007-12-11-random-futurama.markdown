--- 
layout: post
comments: true
title: Random Futurama
mt_id: 168
date: 2007-12-11 19:36:17 -08:00
---
I like [Futurama](http://en.wikipedia.org/wiki/Futurama).  All of it.  Though I occasionally have a hankering for a specific episode, I often just want /any/ episode, so I wrote a quick Perl script to play one at random.  I have a directory filled with all of Futurama, so this is an easy proposition:

<pre class="brush: perl;">
#!/usr/bin/perl
use strict;
use warnings;

my @files = split /\n/, `ls *avi`;

my $num = rand(scalar(@files));

system "mplayer "$files[$num]"";
</pre>
