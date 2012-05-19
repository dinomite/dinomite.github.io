--- 
layout: post
comments: true
title: Random number generators
mt_id: 66
date: 2006-05-01 16:25:42 -07:00
---
As I read more about cryptography (I'm currently making my way through the great tome, [Applied Cryptography](http://www.amazon.com/gp/product/0471117099/sr=8-1/qid=1145849010/ref=pd_bbs_1/102-6924799-8398511?%5Fencoding=UTF8)) I've been thinking more about random number generators.  Whenever you read about cryptography or how they build slot machines (Kevin Mitnick covers this in [The Art of Intrusion](http://www.amazon.com/gp/product/0764569597/sr=8-1/qid=1145849136/ref=pd_bbs_1/102-6924799-8398511?%5Fencoding=UTF8)) there is talk of how bad computer random number generators are, particularly the standard functions that are part of Java, libc or .NET.  Even if you take the time to seed them, the pseudo-randomness is of quite low quality.  I just found an article on some [random number generators you can implement yourself](http://www.qbrundage.com/michaelb/pubs/essays/random_number_generation).  Cool.
