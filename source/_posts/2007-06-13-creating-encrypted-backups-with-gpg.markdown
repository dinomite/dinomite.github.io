--- 
layout: post
comments: true
title: Creating Encrypted Backups with GPG
mt_id: 117
date: 2007-06-13 05:14:08 -07:00
---
With large hard drives becoming cheap and external enclosures easy to find, many people are finally beginning to perform backups of their data.  While an external drive is a good step that will mitigate the risk of the main drive's failure or an accidental deletion, it doesn't protect from the worse, albeit more rare risks of fire and theft.  I say this and now I'm about to delve into some Linux jazz that doesn't apply to normal users.  Oh well.

I keep regular backups (I'm actually lucky enough to have an offsite location to put them) but want to keep my most important data in another place as well and to do so, I occasionally burn a DVD with said data.  My only concern with this is that if I, say, leave it in my car now my potentially private data is even more susceptible to theft.  In order to make this a non-issue, I use the following command to create encrypted and gzipped tar archives:

<code><pre>
tar -chf - foo/ | gzip - | gpg -e -r Drew > foo.tar.gz.gpg
</code></pre>

Quite simple, really.
