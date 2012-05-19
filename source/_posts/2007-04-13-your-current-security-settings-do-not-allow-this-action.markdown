--- 
layout: post
comments: true
title: Your current security settings do not allow this action
mt_id: 107
date: 2007-04-13 08:34:58 -07:00
---
Windows Server 2003 (or maybe it's just Internet Explorer 7) has a number of wonderful features that will make every day a cheery adventure.  Among them are draconian security policies that, beyond making little sense, are controlled from places they don't belong.  Apparently a mapped network share is considered a web page.  Who would have guessed that?  Well, if you get the error in the title when trying to run or even right-click something from a share on the network, it can be fixed from Internet Options.  From IE7, press 'alt' to show the menu, go to Tools>Internet Options.  In the Internet Options window, go to the security tab, select the 'Internet' zone and click 'Custom' near the bottom right.  In the resulting window under 'Miscellaneous', set things that say 'disable' to 'prompt' or 'enable'.  I'm not sure which one controls the above mentioned behavior, but it ought to be fairly obvious which are involved; just allow them. 
