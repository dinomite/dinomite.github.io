--- 
layout: post
comments: true
title: "Apache Won't Start: No space left on device"
mt_id: 213
date: 2008-06-25 12:10:03 -07:00
---
I'm doing some development involving Apache handlers which involves lots of restarting it and occasionally Apache shutting down uncleanly.  After numerous restarts, the webserver refused to start printing the following in the error log:

<pre>
[Wed Jun 25 18:57:11 2008] [emerg] (28)No space left on device: Couldn't create accept lock
</pre>

After being confused because there certainly is enough disk space, I Googled for other possibilities and it turns out I had hit another limit, that of active semaphores.  When some of my processes were killed, they died uncleanly and didn't clean up their open semaphores, filling the maximum number available to my user.  It's easy to tell that this is the root of the issue; running `ipcs -s` showed a list of 95 open semaphores.  Clearing them up is just as easy:

<pre>
~$ for id in \`ipcs -s |awk '/USERNAME/ {print $2}'\`; do ipcrm -s $id; done
</pre>

That prints the list of semaphores, grabs the ID ({print $2}) for lines containing USERNAME (your own or that which the webserver runs under) and then `ipcrm`'s those semaphores. 
