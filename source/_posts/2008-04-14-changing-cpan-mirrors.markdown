--- 
layout: post
title: Changing CPAN Mirrors
mt_id: 201
date: 2008-04-14 17:24:06 -07:00
---
I wanted to change the mirrors that CPAN was set to use because it seemed that the first one on the list wasn't responding.  I figured there must be a way to do this from the CPAN command line and indeed, a quick Google search [turned up a result](http://sial.org/howto/perl/life-with-cpan/#s5).  To do what I wanted, I first printed the current URL list, shifted off the offending host and then wrote the altered configuration to disk for next time
<pre>
cpan> o conf urllist
    urllist
        ftp://archive.progeny.com/CPAN/
        ftp://carroll.cac.psu.edu/pub/CPAN/
        ftp://cpan.calvin.edu/pub/CPAN
        ftp://cpan.cse.msu.edu/
        ftp://cpan.mirrors.redwire.net/pub/CPAN/
Type 'o conf' to view configuration edit options
cpan> o conf urllist shift
cpan> o conf urllist
    urllist
        ftp://carroll.cac.psu.edu/pub/CPAN/
        ftp://cpan.calvin.edu/pub/CPAN
        ftp://cpan.cse.msu.edu/
        ftp://cpan.mirrors.redwire.net/pub/CPAN/
Type 'o conf' to view configuration edit options
cpan> o conf urllist commit
</pre>

To completely reconfigure CPAN, you can use the command `o conf init`.
