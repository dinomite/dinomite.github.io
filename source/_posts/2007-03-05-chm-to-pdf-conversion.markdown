---
layout: post
title: "CHM to PDF conversion"
date: 2007-03-05 13:16
comments: true
categories: [Linux]
---
Have some CHMs that you'd rather browse as PDFs?  Easy.  To convert, you'll need `libchm-bin` and `htmldoc` on Ubuntu, probably the same on Debian and similar on others.  Then, do the following:

<code><pre>
$ extract_chmLib foo.chm foo/
$ htmldoc --webpage -f foo.pdf foo/*.html
</pre><code>

Done.
