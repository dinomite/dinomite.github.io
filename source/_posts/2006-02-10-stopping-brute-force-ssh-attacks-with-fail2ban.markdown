--- 
layout: post
comments: true
title: Stopping Brute Force SSH Attacks with fail2ban
mt_id: 40
date: 2006-02-10 10:40:34 -08:00
---
I noticed a lot of network and forking activity while using my computer last week, thanks to [GKrellM](http://members.dslextreme.com/users/billw/gkrellm/gkrellm.html)  I checked around and noticed a constant series of hits in my auth.log from someone trying common names to login via SSH.  I blocked the offender, but from looking through the log, this happened quite often and, though I have very strong passwords, this was very annoying to me to see all that crap in the logs.  I searched around and found a daemon called fail2ban that simply watches the logs and blocks hosts who have more than a specified number of failed login attempts.  It's in the Debian repositories, so just `apt-get install fail2ban` and then configure it in `/etc/fail2ban.conf`.

I also saw some cool tips on the [CLUG Wiki](http://wiki.clug.org.za/index.php/Defending_Against_Brute_Force_SSH_Attacks).
