--- 
layout: post
title: Screen Presets
mt_id: 247
date: 2009-11-17 22:40:11 -08:00
---
Ubuntu's [Screen Profiles](https://wiki.ubuntu.com/ScreenProfiles) package taught a lot of folks about how GNU Screen can be so much more than a fancy replacement for [nohup(1)](http://en.wikipedia.org/wiki/Nohup).  Since GNU Screen's name is difficult enough to search for, they have thankfully renamed the package to [Byobu](https://launchpad.net/byobu).  Byobu provides users with a whole bunch of pre-defined aliases to make working within Screen easier, and make more sense by defining a useful status line.  There's more that can be done with screen, the most notable in my view is creating predefined working environments that make getting yourself up and running when logging into a system easy.

I've got a number of different things that I commonly do where I want a number of different screen windows: running the deamons on our development server, connecting to the DB servers in each of the different environments, and developing an experimental project.  For each of these applications, I have created a screenrc that I keep in my `.screen/` directory; the basic format is this:

<pre class="brush: bash;">
source $HOME/.screenrc

sessionname daemons
chdir /code/htdocs/dstephens/trunk/webroot/daemons

screen -t 'CONTROL' bash
screen -t 'aggregator' bash
screen -t 'autoEventWatcher' bash
screen -t 'emailReady' bash
screen -t 'sfUpload' bash
screen -t 'jmsCommandExecutor' bash
screen -t 'bouncedEmail' bash
select 0
</pre>

First, I source my global `.screenrc`, which includes setting a statusline, larger scrollback buffer, multiuser and utf8.  Next, giving the session a name makes it easier for me to figure out which one to reattach to later. Finally, I create and name all of the windows that I want to have in my session, in this case, one for each of the daemons that I want to be able to run.

To run a specific preset, just invoke screen with the `-c` option: `screen -c ~/.screen/daemons`.  Easy.
