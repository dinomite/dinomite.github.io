--- 
layout: post
comments: true
title: Remote Oracle Connections
mt_id: 113
date: 2007-04-25 13:17:16 -07:00
---
Like many 'enterprise solutions,' Oracle is a despicable piece of software that has a tendency to eat copious amounts of memory and processor time.  Alas, ranting on my hatred of enterprise hardware and software is not the subject of this post.  A big part of enterprise applications is that they are usually accompanied by abundant amounts of documentation, sadly, much of it useless.  The tomes (physical or electronic) included often overlook the simplest of functions delving straight into the guts of the system and focusing on minutiae.  Despite the fact that everyone needs to perform these elementary tasks that are buried deep within the documentation, it's often difficult to find a solution by searching the internet.  My search for how to use `sqlplus` to connect to a remote database (I had previously only used it locally, on the server running Oracle) turned up a few results and led me to this solution:

<code>
~$ sqlplus uname/pass@[//hostname[:port]/]sid
</code>

Really, it's quite straightforward.
