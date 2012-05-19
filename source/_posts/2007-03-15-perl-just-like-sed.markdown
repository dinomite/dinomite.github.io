--- 
layout: post
comments: true
title: Perl Just Like sed
mt_id: 103
date: 2007-03-15 08:23:19 -07:00
---
I came across a post today in which someone mentioned that they used Perl for text replacement and, despite the simplicity of the solution, I hadn't ever thought of it.  By simply using three options with the `perl` command, you can run a quick script to do regex replacement in a file.  The `-p` option tells Perl to treat your script as a loop, reading in from the diamond (`<>`) operator.  `-i` makes it do in-place editing of files and `-e` allows you to script from the command line.  For example:

<code><pre>
~$ perl -p -i -e "s/foo/bar/g" baz.txt
</code></pre>

The above command will replace 'foo' with 'bar' throughout the file 'baz.txt'
