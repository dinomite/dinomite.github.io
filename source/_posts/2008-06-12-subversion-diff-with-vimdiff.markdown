--- 
layout: post
title: Subversion diff with vimdiff
mt_id: 214
date: 2008-06-12 11:03:40 -07:00
---
Side by side diffs are much more legible and useful than those in [unified format](http://en.wikipedia.org/wiki/Diff#Unified_format) or any other linear diff.  By default, the `svn diff` command presents output in the unified format, though it has an option, `--diff-cmd`, which allows you to specify the program that will perform the diff.  Passing `vimdiff` as the diff command doesn't work as the options passed by `svn diff` are a bit complicated:

<pre>
~/code/perllib/MG$ cat foo.sh
\#!/bin/bash
echo $*
~/code/perllib/MG$ svn diff --diff-cmd foo.sh Proxy.pm
Index: Proxy.pm
-u -L Proxy.pm (revision 21095) -L Proxy.pm (working copy) .svn/text-base/Proxy.pm.svn-base /tmp/svndiff.tmp
</pre>

Subversion is telling diff to output context (`-u`), show pretty names for the files (`-L`) and then the two files to diff.  To make this work with `vim`, we simply need to cut out the extra options.  To do so, I wrote a simple script:

<pre class="brush: bash;">
\#!/bin/bash
shift 5
vimdiff "$@"
</pre>

I put that in `~/bin/svnvimdiff` and now I can do `svn diff --diff-cmd ~/bin/svnvimdiff Proxy.pm` and view the diff in `vimdiff`.  Since this is a command I use often, I aliased it in my `.bashrc`:
<pre class="brush: bash;">
alias svndiffvim='svn diff --diff-cmd ~/bin/svnvimdiff'
</pre>
