--- 
layout: post
comments: true
title: Obfuscated code
mt_id: 67
date: 2006-05-06 10:27:59 -07:00
---
I'm doing a project on MD5 collisions for my parallel computing class and, like all cryptography, the code involves a lot of hex numbers (in standard notation, 0xf00d, 0xbeef, etc.) which naturaly makes parts of the code difficult to read.  That's simply the nature of [the algorithm](http://en.wikipedia.org/wiki/MD5#Algorithm).  Some programmers (often just mathematicians) insist on making the code even more illedgible with things like this:

<code>while (counter < (1 << 9))</code>

The bigger problem is that when I see something like that I'm confused; I am both impressed by their cleverness (that loops while counter is less than 512) but also annoyed by their needless obfuscation.  I guess one could argue that a left shift is more ledgible, because if it were a number larger than 10 or so, people wouldn't know the significance.  Who really knows of the top of their head that 262144 is 2^18?  So, in the end, it's not necessarily just obfuscation but really, most programmers will recognize at least up to 2^10 and those who know the internets should know 2^16 as well.
