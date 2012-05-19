--- 
layout: post
comments: true
title: Altering many directories at once with CmdDirs
mt_id: 268
date: 2011-02-20 14:34:25 -08:00
---
<p>On any machine I use I create a directory, sandbox, at the root of my home directory to hold checkouts of source code I'm working on.  This directory often contains code from many different repositories, dozens of projects that I intermittently work on.  Many of these repositories depend on others, in particular Java submodules for <a href="http://clearspring.com/">Clearspring</a>, and I want to be able to easily update all of them at once.  With Subversion this is easy: the <code>svn</code> command allows you to act upon a checkout without being in the directory that contains it.  Simply issuing <code>svn up *</code> from <code>~/sandbox</code> ensures that I have the latest code revision in each of my checkouts and <code>svn st *</code> allows me to see if I have any uncommited changes.</p>

<p>While I love Git, it does not make such actions this simple.  Git requires you to be in the repository directory (or set a number of environment variables) to work wit that repo.  While the <a href="http://superuser.com/questions/235455/bash-script-to-perform-an-action-on-each-subdirectory-in-a-directory"><code>-exec</code> option of <code>find(1)</code></a> allows me to descend into each directory and perform an action, I wanted to make this easy, because such all-checkout-actions are something that I want to do a number of times each day.  Like most problems, this one is (best?) solved with Perl.  Enter <a href="https://github.com/dinomite/CmdDirs">App::CmdDirs</a>.</p>

<p><a href="https://github.com/dinomite/CmdDirs/raw/master/bin/cmddirs">CmdDirs</a> is a fairly simple Perl app that I have written to do what I describe above--descend into any number of directories and perform a command in each one.</p>

<pre>titus:~/sandbox$ ls
CmdAll                 mac-itunes             genius-os
scoreboard             GAE                    hf
uaParser               WebService-LOC-CongRec iTunes-Sync
titus:~/sandbox$ cmddirs "git st"
Performing `git st` in &lt;cmdall&gt;
## master
?? App-CmdDirs-1.00.tar.gz

Performing `git st` in &lt;itunes-sync&gt;
## master

Performing `git st` in &lt;uaparser&gt;
## master
 M uaParser/test/test_user_agent.py

Performing `git st` in &lt;webservice-loc-congrec&gt;
## master
</pre>

See the numerous directories? Note that there are 9 directories in my `sandbox` but `git st` was only performed in a few of them, those which are Git repositories.  CmdDirs has a modicum of intelligence: if it knows what your command is, the command will only be performed in applicable directories.  This can be overridden with `-all`, `-git`, or `-svn` doing what you expect.  Git and Subversion are the only two things supported right now, because that's all I have a need for. Writing new [Traversers](https://github.com/dinomite/CmdDirs/tree/master/lib/App/CmdDirs/Traverser) is simple--just copy the form of git.pm or svn.pm.  You can probably Achieve at this endeavor even without knowing Perl.

Here's a one-liner for installing `cmddirs`:

<pre>
curl https://github.com/dinomite/CmdDirs/raw/master/bin/cmddirs > ~/bin/cmddirs && chmod a+x ~/bin/cmddirs
</pre> 

