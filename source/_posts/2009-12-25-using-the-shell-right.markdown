--- 
layout: post
comments: true
title: Using The Shell Right
mt_id: 251
date: 2009-12-25 13:03:14 -08:00
---
The most powerful part of Unix/Linux/BSD is the command line.  In stock trim, the Unix shells are all very effective, but your time can be more effective by customizing the shell.  I use `bash`, so I know that these things work in that shell, but they ought to be easily transferred to others as well.

## Aliases

A good friend of mine, [Jordan Sissel](http://semicomplete.com), once said that if you do something more than once, you're doing it wrong.  His conjecture applies as much to your shell as it does to your [browser](http://dinomite.net/2008/smart-bookmarks)â€”computers are great at repetitive tasks, so you shouldn't bore yourself with such things.  Therein lies the most important thing you can do with your shell: make common tasks easier with aliases.

First things first, I use `ls` a whole lot, and, despite it's simple makeup, I often mistype the command.  I don't care about being able to easily run [Steam Locomotive](http://www.freebsdsoftware.org/games/sl.html), and there's no `s` or `l` command, so I replace those all with `ls`:
<pre class="brush: bash; gutter: false">alias sl="ls"
alias l="ls"
alias s="ls"
alias ll="ls -l"
alias lh="ls -lh"
alias la="ls -la"</pre>
Another thing I do all the time is descend into directories, which means I need to get out of them, too:
<pre class="brush: bash; gutter: false">
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
</pre>

I always want extended regular expressions, and there are tons of things I don't want to search when I grep (though I use <a href="http://betterthangrep.com">ack</a> these days):

<pre class="brush: bash; gutter: false">
alias grep="egrep"
alias G="grep -n --color=always --binary-file=without-match --exclude=tags \
--exclude=*-min.js --exclude-dir='.[a-zA-Z]*' --exclude-dir='external' \
--exclude-dir='blib'"
</pre>

Furthermore, I often want to do recursive greps of a entire codebase, sometimes case insensitive, and like everything else, I mistype it:
<pre class="brush: bash; gutter: false">
alias GR="G -r"
alias RG="GR"
alias GRI="G -r -i"
alias GIR="GRI"
alias IGR="GRI"
alias IRG="GRI"
</pre>

If you do any sort of system administration, you need to grep the process list; make that easy:
<pre class="brush: bash; gutter: false">
alias paux="ps aux|grep -i"
</pre>

Is someone shoulder surfing?
<pre class="brush: bash; gutter: false">
alias c="clear"
alias logout="clear; logout"
</pre>

[Matt Behrens](http://asktherelic.com) tipped me off to this oneâ€”`type -a` tells you a lot more than the standard `which`:
<pre class="brush: bash; gutter: false">
alias which='type -a'
</pre>

When I'm writing in a language that requires compilation, I use cowsay to break up the output of each run, so that errors are easy to distinguish between this run and the previous one:
<pre class="brush: bash; gutter: false">
alias gcc='cowsay "Hello"; gcc'
alias g++='cowsay "Hello"; g++'
alias make='cowsay "Hello"; nice -n 10 make'
alias javac='cowsay "Hello"; javac'
</pre>

Machines that I SSH to often get their names as aliases; I've got a bunch more of these:
<pre class="brush: bash; gutter: false">
alias claudius="ssh -Y dinomite@dinomite.net"
alias caligula="ssh -Y dinomite@caligula.dinomite.net"
</pre>

## Prompt

There are numerous articles about pimping out your shell's prompt, many include previous command exit codes, the time, the current energy of the LHC, and the price of the S&P 500.  I have a web browser, so I don't need all that informationâ€”I only put in my prompt things that are pertinent to the task at hand.  The things that make up my prompt are a bit complicated, so I build it in stages.  First, since I work on a lot of different machines, I always have the hostname in my prompt.  To make it easy to tell which machine I'm on, I assign colors to the systems that I use most often:

<pre class="brush: bash; gutter: false">
HOSTNAME=`hostname|sed -e 's/\..*$//'`
if [ $HOSTNAME = 'Caligula' ] || [ $HOSTNAME = 'Caligula.local' ]; then
    export HOST_COLOR="\[\033[1;35m\]"
fi
if [ $HOSTNAME = 'claudius' ]; then
    export HOST_COLOR="\[\033[1;36m\]"
fi
if [ $HOSTNAME = 'dev1' ]; then
    export HOST_COLOR="\[\033[1;34m\]"
fi
if [ $HOSTNAME = 'svr-dev-rw1' ]; then
    export HOST_COLOR="\[\033[1;31m\]"
fi
if [ $HOSTNAME = 'drewfus' ]; then
    export HOST_COLOR="\[\033[1;30m\]"
fi
</pre>

Next, I capitalize the hostname and make the colon separating it from the path red if I'm currently acting as root via `sudo -s`.  This makes it very hard to forget that the consequences of actions are great at the current time:

<pre class="brush: bash; gutter: false">
COLON_COLOR='0m'
if [ ${UID} -eq 0 ]; then
    COLON_COLOR='1;31m'
fi
if [ ${UID} -eq 0 ]; then
    HOSTNAME="`echo $HOSTNAME|tr '[a-z]' '[A-Z]'`"
fi
</pre>

Finally, build the actual prompt:

<pre class="brush: bash; gutter: false">
PS1=`echo -ne "$HOST_COLOR$HOSTNAME\[\033[00m\]\[\e[$COLON_COLOR\]:\[\033[33m\]\
w\[\033[00m\]\\[\033[01;33m\]\$\[\033[00m\] "`
</pre>

What does this look like?<br>
<span style="color: #00ccff;">claudius</span>:<span style="color: #339966;">/usr/local$</span><br>
And when root:<br>
<span style="color: #00ccff;">CLAUDIUS</span><span style="color: #ff0000;">:</span><span style="color: #339966;">/usr/local$</span>

## History

There are a lot of complicated commands that I only use occasionally; having a big history means if I've used it once, I can easily search and find the command later.  The `histappend` options tells bash to append rather than overwrite the history file and `cmdhist` combines multi-line history commands into a single entry.  It's often useful to run the same command repeatedly, and I find myself typing `ls` whenever I stop to think; setting `HISTCONTROL` and `HISTIGNORE` keeps those actions from filling up my history.

<pre class="brush: bash; gutter: false">
#"I know I've used that command before, but I can't remember the syntax"
export HISTSIZE=50000
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:ll:la:lh:sl"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S - '
</pre>

## Environment Variables

A lot of linuxes come with lackluster program defaults (emacs, more, etc.); you can get better ones by setting environment variables:

<pre class="brush: bash; gutter: false">
export PAGER=/usr/bin/less
export EDITOR='vim -X'
export BROWSER='firefox'
export CC=/usr/bin/gcc
</pre>

Since we are in the 21st century, I use Unicode:

<pre class="brush: bash; gutter: false">
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
</pre>

## Functions

I use Perl a lot, and have to deal with keeping modules the same across different systems; this function makes getting the installed version of a module easy:

<pre class="brush: bash; gutter: false">
function perlmodver {
    perl -M$1 -e 'print "Version " . $ARGV[0]->VERSION . " of " . $ARGV[0] . " is installed.\n"' $1
}
</pre>

The thing I use `awk` for most often is '{print $n}', so I wrote [`fawk`](http://dinomite.net/2009/fawk/) which you give a number and it des just that:
<pre class="brush: bash; gutter: false">
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}
</pre>

`awk` also does math:
<pre class="brush: bash; gutter: false">
function calc {
    awk "BEGIN{ print $* }";
}
</pre>

## Tying It All Together

To keep things organized, I separate the above mentioned things into a few different files, so my `.bashrc` brings them all together.  Additionally, I check for a `.bash_local` file, which isn't <a href="http://dinomite.net/2008/keeping-your-home-directory-in-subversion/">checked into subversion</a>, so that I can have machine-specific alterations to my shell environment.

<pre class="brush: bash; gutter: false">
# .bashrc
source ~/.bash_global
source ~/.bash_aliases
source ~/.bash_functions
if [ -f ~/.bash_local ]
then
    source ~/.bash_local
fi
</pre>
