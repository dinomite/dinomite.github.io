--- 
layout: post
comments: true
title: perl -MO=Lint
mt_id: 97
date: 2007-02-21 11:14:39 -08:00
---
It is generally accepted that when developing Perl, you should be using warnings (`use warnings`) and recommended that you go a step further with `use strict`, which forces the declaration of variables with `my` before they are used, among other things.  Beyond these two, however, is the [`B::Lint`](http://search.cpan.org/~nwclark/perl-5.8.8/ext/B/B/Lint.pm) module that performs [further checks on your code](http://www.perl.com/doc/manual/html/lib/B/Lint.html).  Using it couldn't be simpler; simply pass the option `-MO=Lint,all` to the Perl command when invoking your program.  The `-M` option tells Perl that you want to use the module specified, and '`,all`' is an option passed to the Lint module, telling it to perform all checks, which is probably what you want.  If you have some bad habit, or want it to specifically skip some checks, you can add that on to the argument list, prepending the option listed in [the documentation](http://search.cpan.org/~nwclark/perl-5.8.8/ext/B/B/Lint.pm) with 'no-'.
