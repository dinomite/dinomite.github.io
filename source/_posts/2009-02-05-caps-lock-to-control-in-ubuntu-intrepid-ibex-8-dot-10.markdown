--- 
layout: post
comments: true
title: Caps Lock to Control in Ubuntu Intrepid Ibex (8.10)
mt_id: 235
date: 2009-02-05 09:53:11 -08:00
---
I've [written this post before](http://dinomite.net/2007/caps-lock-to-control-on-ubuntu/), but things have changed since the 7.04 Feisty Fawn release, so it's worth an update.  In recent releases of Ubuntu the Gnome Control Center has made it easy to simply click away the unneeded caps lock key, turning it into whatever you want.  I wanted to try KDE 4.2 a few days ago and found no way to turn off the caps lock key.  From my previous post, I knew that it's easy to add a line to the `xorg.conf`which will turn the caps lock into another control, but when I opened the file on my Ubuntu 8.10 machine, I was surprised to find very little in it:
<pre class="brush: bash;">
Section "Files"
EndSection

Section "Module"
    Load  "glx"
EndSection

Section "Monitor"
    Identifier   "Configured Monitor"
EndSection

Section "Device"
    Identifier  "Configured Video Device"
    Driver      "fglrx"
EndSection

Section "Screen"
    Identifier "Default Screen"
    Device     "Configured Video Device"
    Monitor    "Configured Monitor"
    DefaultDepth     24
    SubSection "Display"
        Virtual   1680 1050
    EndSubSection
EndSection
</pre>

If you come from a long line of Linux use, this is a very odd X config indeed since it lists no input devices, but such is the magic of <a href="http://en.wikipedia.org/wiki/HAL_(software)">HAL</a> which takes care of all that for you.  The option to turn you caps-lock key into a control is set in the keyboard's `InputDevice` section.  The above-listed stock Ubuntu 8.10 xorg config doesn't have an `InputDevice` section, nor does it have the associated `ServerLayout` block.  The following can be appended to your `/etc/X11/xorg.conf`:

<pre class="brush: bash;">
Section "InputDevice"
    Identifier  "keyboard"
    Driver      "keyboard"
    Option      "CoreKeyboard"
    Option      "XkbOptions"    "ctrl:nocaps"
EndSection

Section "ServerLayout"
    Identifier  "Default Layout"
    Screen      "Default Screen"
    InputDevice "keyboard"
EndSection
</pre>

With that, you will now have a caps lock key no matter what window manager or desktop system you use.  I love the caps lock as a control because I use vi extensively and make use of ^f & ^b, which move up and down pages, and ^e & ^y that move the buffer's view up and down without moving the cursor.  I'm sure emacs users will appreciate this change as well, since they use control alongside 6 or 7 other keys whenever they want to do something.
