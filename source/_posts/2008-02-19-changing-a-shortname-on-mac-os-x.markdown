--- 
layout: post
comments: true
title: Changing a Shortname on Mac OS X
mt_id: 192
date: 2008-02-19 06:35:06 -08:00
---
When you install Mac OS X, it asks you for your full name, which is what it will use for what it calls the username.  Despite calling it the username, it is not actually field 1 in `/etc/passwd`, which is what Unix users would call the username.  Mac OS X refers to the first field of `/etc/passwd` as a user's "short name," normally a concatenated and lowercased version of your full name.  As one would expect, your Unix username, what you would use to login at a console or via SSH, is actually the short name; your files are stored in /Users/<shortname> and are owned by <shortname>.

Like many Unix users, I have a username (dinomite) that is different from my real name (Drew Stephens) and I like it that way.  Having a username on one machine that doesn't match that on all of my others is a hassle, requiring me to specify a username whenever I SSH to or from said machine.  After having reinstalled OS X recently I wanted to change my short name on the system to rectify this problem.  Though some tutorials make it seem like an [involved process](http://docs.info.apple.com/article.html?artnum=106824), it's actually fairly straightforward if you have some Unix and OS X experience.  Here's how I did it in 10.5 (Leopard).

First, you must enable the root user; we will make all the username changes while logged in as root.  You could also login as another user and use sudo (hint: `sudo -i`) to do this, but I had no other users on my machine.  To enable root, open Applications > Utilities > Directory Utility, then click the lock in the Directory Utility window and enter your username & password.  Choose "Enable Root User" from the Edit menu and supply a password for root when prompted.

Now that root is enabled, log out of your own account, click "Other..." in the login window and supply root's credentials.  Once logged in, we need to create a the new user with the desired short name.  Open System Preferences and select the Accounts pane.  Add a new user by clicking the '+' at the bottom and fill in the Name & short name fields as desired; I used a temporary name (Drew) and the short name I wanted (dinomite), since you can't have two identically named users and the name can be easily changed later.

Open a terminal (Applications > Utilities > Terminal) and change to /Users.  `ls` ought to show directories for both your current short name and the newly created one.  Now you just have to move your files from your old short name to the new one: `mv <old short name>/* <old short name>/.* <new short name>/`.  Once that completes, you need to change the ownership to the new short name: `chown -R <new short name> /Users/<new short name>`.  Since everything is now in the new users' domain, you can now delete your old username, log out of root and log in using your newly short named account.
