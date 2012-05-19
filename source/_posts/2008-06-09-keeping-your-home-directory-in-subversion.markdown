--- 
layout: post
comments: true
title: Keeping Your Home Directory in Subversion
mt_id: 211
date: 2008-06-09 23:25:46 -07:00
---
I've heard of doing this for a long time, but always figured it'd be a huge jump to put my home directory into a revision control system.  For years I've scp'd files to a new machine when I moved in and when I made changes to my vimrc or ssh config, it was hell to propagate the changes to my other machines.  No more is this an issue, since I've commited my home directory.  The process is really quite trivial.

I first created a subversion repository on my Linux server.  A special machine isn't required, nor is root access; you just need somewhere that can be accessed with SSH from the intertubes.

<pre>
~$ svnadmin create subversion
</pre>

It's as easy as that.  To begin with, let's create the standard subversion directory structure.

<pre>
~$ svn co file://$home/subversion/ foo
~/foo$ cd foo
~/foo$ mkdir homedir
~/foo$ svn add homedir
~/foo$ svn commit
~/foo$ cd ..
~$ rm -rf foo
</pre>

So now we have a repository with a homedir directory in the root; this is where all of the files from your home directory will be checked into the repository.  To begin with, check out this new project into the root of your home directory.

<pre>
~$ svn co file://$home/subversion/homedir .
</pre>

Since there isn't anything in there, nothing will actually be checked out, but subversion will setup source control on `.`, your home directory.  So let's add something to it.  I have a `.vimrc` that ought to be identical across environments, so I'll check that and my `.vim` support directory into the repository

<pre>
~$ svn add .vim*
A         .vimrc
A         .vim/colors/drew.vim
A         .vim/plugin/feraltogglecommentify.vim
~$ svn commit -m "adding stuff for the first time!"
</pre>

Easy as that, all of my vim configuration files are in subversion.  Now for the awesome part.  Like I mentioned, I have a number of machines and, things like vim configuration files should be the same on all systems.  So now, I hop onto another machine and checkout the homedir project.  First I remove the existing `.vim*` files since they will be replaced with the repository versions.

<pre>
Caligula:~$ rm -rf .vim*
Caligula:~$ svn co svn+ssh://dinomite.net/home/dinomite/subversion/homedir .
A    .vim
A    .vim/colors
A    .vim/colors/drew.vim
A    .vim/plugin
A    .vim/plugin/feraltogglecommentify.vim
Updated to revision 1.
</pre>

Bam.  I've now got the exact same files on both machines.  If I'm at the office and find some flash vim option that I want to use, I simply add it to my `.vimrc`, check it in with `svn ci .vimrc` and when I `svn up` from the other machines, they'll get the new changes.  In reality, I keep a bunch of stuff in my homedir subversion repository: `.bashrc`, `.screenrc`, `bin` directory and many others.  Subversion helps me keep all of my config files in sync across a number of different machines that I use on a daily basis; if you use more than one system with any frequency, I highly suggest checking in your home directory.
