--- 
layout: post
comments: true
title: Watching iPad Applications
mt_id: 271
date: 2011-04-09 09:00:00 -07:00
---
Shortly after the release of [The Daily](http://www.thedaily.com), [Andy Baio](http://waxy.org) created [The Daily: Indexed](http://thedailyindexed.tumblr.com) and, more importantly, described how he created that index in [a blog post](http://waxy.org/2011/02/how_i_indexed_the_daily/).  The crux of his reverse engineering of The Daily app was [Charles](http://www.charlesproxy.com), which he describes how to use in the aforementioned blog post.  Since reading that post, I've wanted to explore a number of applications on my iPad and iPhone to see what they're really doing when they cause the network indicator to spin.

First things first, I setup Charles and started up [Reeder](http://reederapp.com/), an RSS feed reader that integrates tightly with Google Reader.  My main interest was to see when it actually marked posts as read--I often read in short spurts on my iPhone, which results in pulling up a post only to switch out of Reeder or lock my phone seconds later.  Sometimes the posts would be marked read if I pulled up Google Reader, but sometimes they were still marked unread.  Was this a network latency problem when the phone was using 3G/Edge internet, or was it Reeder doing some fanciness with when it marked posts read?

I didn't get to my goal right away because the first thing I noticed upon starting up Reeder is that it hits the original blog for every single one of the feeds that I subscribed to in Google Reader.  As someone who hasn't cleaned up a number of blogs that don't post anymore, this was a few hundred feeds.  I shouldn't have been surprised by this, as it doesn't really make sense for Google to pull all of the content for all of those blogs and package it up for my convenience.

Getting back to my initial focus, Reeder attempts to mark a post read as soon as you open a post--any failure of a post being marked read is because the network was slow or inoperative at the time you were reading.  Reeder periodically refreshes all of your feeds, as indicated by the spinning icon on the iPad or the replaced battery display on the iPhone, but it actually spends much longer doing this than the icon's state would lead you to believe.  From day-to-day usage the update to the feeds I care about (read: those that actually have updates) is done in short order, but Charles reveals that Reeder is still pulling data from individual websites.  My guess is that Reeder pulls the feed list from Google, gets the new posts mentioned therein, and then proceeds to do its own checking of feeds.

Reeder was the only app that had really crossed my mind after Andy Baio's post, and it fulfilled my desire to experiment with Charles, which is a very good tool that I'll turn to if I have future questions that need answering. 
