--- 
layout: post
comments: true
title: Caps Lock to Control on Ubuntu
mt_id: 119
date: 2007-06-17 18:51:48 -07:00
---
If you've ever used a Sun workstation, you know the joys of having a control key where most keyboards position the caps lock key.  If you're an experienced user of the Interweb, you know that there is nary an occasion that calls for the caps lock.  The fact that you have to hold down the shift key is a good moment to reconsider any yelling.  Though I don't use the console often, it is endlessly annoying to find that I don't have a <em>properly</em> positioned control key when I do.  I went searching for the right way to change the keyboard's layout, since I hadn't ever bothered to do it previously.  I found [this](http://www.vollink.com/gary/deb_ctrlcaps.html) how-to by Gary Vollink which describes how to replace the worthless caps lock with the useful control key in all operating systems anyone ever uses.

For Ubuntu's console, it's a simple change in `/etc/console-setup/boottime.kmap.gz`, which can be edited directly with `vi`; no need to un-gzip it first.  Keycode 29 is the left control key and #58 is the caps lock.  If you want another control, just copy the contents of 29 to 58 and if, for some reason (lots of SQL?) you care to swap the two rather than be rid of caps lock entirely, simply swap the values after the equals signs.

In X, I had previously used Gnome's keyboard preferences to change the caps lock setting, but the above-mentioned howto showed that it could be done by adding the following option to the 'InputDevice' section of one's `xorg.conf`:

<pre><code>
Option		"XkbOptions"	"lv3:ralt_switch, ctrl:nocaps"
</code></pre>
