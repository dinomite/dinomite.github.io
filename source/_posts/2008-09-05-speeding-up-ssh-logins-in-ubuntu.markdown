--- 
layout: post
title: Speeding up SSH Logins in Ubuntu
mt_id: 218
date: 2008-09-05 10:23:05 -07:00
---
After getting access to some new machines, I noticed that SSHing too them was excruciatingly slow, taking 5-10 seconds to ask for a password and no faster using keys.  I pulled open the global SSH config file, `/etc/ssh/ssh_config` on my Ubuntu machine and found a couple of [GSSAPI](http://en.wikipedia.org/wiki/Generic_Security_Services_Application_Program_Interface) things that were enabled by default:

<pre>
GSSAPIAuthentication yes
GSSAPIDelegateCredentials yes
</pre>

The machines I was SSHing to don't do GSSAPI, so every time I tried to connect my client had to wait a short timeout before trying other authentication methods.  Since I don't care about GSSAPI (few people use it), I simply set those options to `no` and now my SSH sessions start much more quickly.
