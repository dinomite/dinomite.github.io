--- 
layout: post
comments: true
title: psad on Ubuntu
mt_id: 105
date: 2007-04-08 18:33:11 -07:00
---
`psad` (PortScan Attack Detector) is a useful tool for detecting portscans against a system and, optionally, blocking the offending host.  To use `psad` you configure your firewall to drop and log all packets that are not specifically allowed, i.e., those that are handled by services on the machine.  The configuration for `psad` can cause a little bit of grief because it depends on some quite particular firewall setup and, if you don't want massive logfiles, some editing of `syslog.conf`.  To begin with, you'll need to install `psad` which can be done via apt:

<code><pre>
$ sudo aptitude install psad
</pre></code>

There are some configuration details that should be changed in `/etc/psad/psad.conf`, most notably the hostname and email variables.  Make sure that if you set the email address to something other than one of the accounts on the machine that your mail daemon is setup to deliver mail to the outside world.  Next, setup the firewall to accept packets for the services that your machine runs then drop and log all others.  In this example, the machine runs a web server (port 80) and ssh (port 22):

<code><pre>
$ sudo iptables -F INPUT
$ sudo iptables -P INPUT ACCEPT
$ sudo iptables -A INPUT -i lo -j ACCEPT
$ sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
$ sudo iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
$ sudo iptables -A INPUT -j LOG --log-prefix "DROP " --log-level debug
$ sudo iptables -A INPUT -j DROP
</pre></code>

Which should probably be put into a script that will be run on startup.  Finally alter the `/etc/syslog.conf` so that your `/var/log/messages` doesn't fill up as the second-to-last rule above  writes a logline each time a packet is dropped.  First, I changed the line that controls `kern.log` from this:

<code><pre>
kern.*				-/var/log/kern.log
</pre></code>

to this:

<code><pre>
kern.info;kern.!debug		-/var/log/kern.log
</pre></code>

and adding this line at the end:

<code><pre>
*.=debug	|/var/lib/psad/psadfifo
</pre></code>

The first syslog change keeps your /var/log/kern.log and /var/log/messages from getting a line each time a packet is dropped (which is quite often) and the latter change sends all those dropped packet notifications (which are at the 'debug' loglevel) to psad.
