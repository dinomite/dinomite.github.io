--- 
layout: post
comments: true
title: Perl's Taint Mode
mt_id: 132
date: 2007-08-15 06:35:29 -07:00
---
Perl is a great language for web programming and one of the features that makes it well suited is *Taint Mode*.  Perl's Taint Mode, quite simply, restricts what the programmer can do with variables that are acquired from user input.  If a programs relies on the user to specify something, it's a bad assumption to treat those values as safe for use in operations that may affect the outside world, such as opening files and using tainted values in `system()` calls.  Perl wont restrict you from using tainted values in innocuous things such as print statements but it does pass taintedness on to other variables that a tainted value touches.  Furthermore, modules such as DBI support recognizing taintedness of variable for safety.

To learn more, check out these articles:

- [Perl's Taint Mode to the Rescue](http://www.oreillynet.com/onlamp/blog/2006/11/perls_taint_mode_to_the_rescue.html)
- [Introduction to Perl's Taint Mode](http://www.webreference.com/programming/perl/taint/)
