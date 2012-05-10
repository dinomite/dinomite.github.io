--- 
layout: post
title: Splitting MP3s in Perl
mt_id: 225
date: 2008-09-26 10:35:19 -07:00
---
I listen to some podcasts daily that have annoying messages in them that never change.  With a bit of research, I came across the [MP3::Splitter](http://search.cpan.org/~ilyaz/MP3-Splitter-0.04/Splitter.pm) module on [CPAN](http://search.cpan.org/) which has somewhat confusing documentation but provides a method `mp3split()` that pulls specified pieces of a file.  You provide `mp3split()` with the input MP3 filename, options as a hash and then any number of arrays that specify which portions of the MP3 to copy into new files.  The easiest syntax for specifying a portion is to pass the start position and the length of the desired chunk, both in seconds.  From the command line, I did this:

<pre class="brush: bash;">
perl -MMP3::Splitter -e "mp3split('foo.mp3', {}, [20,25], [95,600], [950,INF])"
</pre>

which creates three new MP3 files, 01_foo.mp3, 02_foo.mp3 and 03_foo.mp3.  These can then be joined to create a new MP3:

<pre class="brush: bash;">
cat 01_foo.mp3 > new.mp3
cat 02_foo.mp3 >> new.mp3
cat 03_foo.mp3 >> new.mp3
</pre>

Which will leave you with `new.mp3` that is a concatenation of the three pieces.  Using `cat` to join them means the resulting file will probably have some artifacts at the join points but that's not a problem for my use.  If it is, you can use something like `mp3join` to properly join the files.
