--- 
layout: post
comments: true
title: CHM to PDF conversion
mt_id: 100
date: 2007-03-05 13:16:24 -08:00
---
Have some CHMs that you'd rather browse as PDFs?  Easy.  To convert, you'll need `libchm-bin` and `htmldoc` on Ubuntu, probably the same on Debian and similar on others.  Then, do the following:

<code><pre>
$ extract_chmLib foo.chm foo/
$ htmldoc --webpage -f foo.pdf foo/*.html
</pre><code>

Done.
