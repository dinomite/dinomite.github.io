--- 
layout: post
comments: true
title: Perl and Dubstep
mt_id: 277
date: 2011-10-26 08:30:00 -07:00
---
In the past year, I have come to quite like [dubstep](http://en.wikipedia.org/wiki/Dubstep), a burgeoning electronic music genre.  Perhaps [this](http://www.youtube.com/watch?v=LXO-jKksQkM) is a more interesting introduction than an article.  Dubstep's current phase reminds me of generalized techno (mostly house & dance) during the mid-90's--a huge variety of styles, many small artists, much of it distributed through non-traditional channels.  In the late 90's the distribution was via early filesharing networks, most notably Napster.  For Dubstep, [YouTube](http://www.youtube.com/results?search_type=&search_query=dubstep%20remix&aq=f), [Mixcloud](http://www.mixcloud.com/dubstep/), and [Soundcloud](http://www.mixcloud.com/dubstep/) seem to be the preferred ways of getting new tracks out.

To chronicle and share this growth of a genre, I started [@DailyWub](https://twitter.com/dailywub), a Twitter account that posts a new dubstep track every day.  Being an engineer, I found the idea of manually keeping a queue and posting a track every day to be a dreadful task.  For some time, the account has been powered by [Buffer](www.bufferapp.com), a simple webapp that allows you to create a queue of tweets that are metered out at a schedule of your choosing.  Buffer is ok, but they limit the queue to 10 tweets, and at some point started shortening URLs even when not needed, which breaks the YouTube thumbnails in many Twitter clients.  Having a queue that is regularly plucked from and emitted to Twitter is a fairly simple operation, so I wrote my own program to do it--[Net::Twitter::Queue](https://metacpan.org/module/Net::Twitter::Queue).

Net::Twitter::Queue is a simple Perl module that employs [Net::Twitter](https://metacpan.org/module/Net::Twitter) to do the heavy lifting.  To use it, I have a queue of tweets in a file, `tweets.yaml`:

<pre class="brush: bash">
- Caspa - Where's My Money? http://www.youtube.com/watch?v=myZU2DZoD9w
- Skrillex - First Of The Year http://www.youtube.com/watch?v=2cXDgFwE13g
- Rusko - Everyday http://www.youtube.com/watch?v=xDAX2aVWAag
</pre>

When run, Net::Twitter::Queue will remove the top item from that YAML file and post it to Twitter using the account information specified in `config.yaml`:

<pre class="brush: bash">
consumer_key: [consumer_key]
consumer_secret: [consumer_secret]
access_token: [access_token]
access_token_secret: [access_token_secret]
</pre>

Where do those values come from?  Two places: the consumer information is on the page for your application at [dev.twitter.com](https://dev.twitter.com) (go ahead, make one!) and the access tokens are specific to the account you want to post as.  To generate them, I used [Twurl](https://github.com/marcel/twurl).  With the consumer key & secret in hand, simply run Twurl:

<pre class="brush: bash">
Titus:~/$ twurl authorize --consumer-key [consumer_key] \
--consumer-secret [consumer_secret]
</pre>

Twurl will respond with a URL that you can visit in a web browser, login to Twitter with the account you want to post as, and get a PIN back.  Give the PIN to Twurl and it will complete the authentication process, saving the access token & associated secret in your `~/.twurlrc`.  Grab those two, toss them into `config.yaml` and run Net::Twitter::Queue from the directory that has `config.yaml` & `tweets.yaml` in it:

<pre class="brush: bash">
caligula:~/twitter/dailywub$ ls
config.yaml  tweets.yaml
caligula:~/twitter/dailywub$ perl -MNet::Twitter::Queue -e \
'$q=Net::Twitter::Queue->new->tweet'
</pre>

Easy as that--the top entry in `tweets.yaml` has been popped and posted to Twitter. 
