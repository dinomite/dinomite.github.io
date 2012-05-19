--- 
layout: post
comments: true
title: Crontab Files
mt_id: 239
date: 2009-04-08 23:20:47 -07:00
---
Crontabs are incredibly useful devices - the easiest way to regularly run a command at a specified time.  The unfortunate part is that, as an operating system level function, their content is easily lost if you aren't careful about backups, or haphazardly reinstall your Unix system.  A simple trick I learned is to keep your crontab entries in a file, say, `.crontab` in your home directory, rather than just editing your crontab directly (i.e. `crontab -e`).  That way, you can be sure that all your important data, including your own user crontab, is in your home directory, and that's the one important thing to backup.  To install a new crontab, simply run `crontab ~/.crontab` after having edited that file and your cron system will install your changes.
