---
layout: post
title: "iTunes Library Statistics"
date: 2006-03-19 18:41
comments: true
categories: [Programming]
---
I wrote a little program to print some statistics about your iTunes library while watching the Malaysian GP today.  It doesn't really do the whole XML thing, and only prints a couple of things that iTunes itself won't tell you, but It's a start of something that could be good.  Right now it will tell you which artists and genres you have the most songs of, the average length of songs in your library and their average size.

Update: Now produces output based upon how many times tracks have been played, which was really the point of this whole thing.

<pre class="brush: bash;">Number of tracks: 2964  Total size: 24181 MB
Avg. length: 6:41       Avg. size: 8 MB
File types: 2954 files, 10 URLs

Most popular genres, by number of tracks:
Trance: 420
Ska: 337
Techno: 326
Dance: 300
Rock: 260

Most popular artists, by number of tracks:
blink-182: 116
Griffin Technology: 102
Paul Oakenfold: 82
DJ Miko &#38; Mini Me: 81
Anabolic Frolic: 79

Most popular genres, by playcount:
Ska: 2210
Dance: 1755
Trance: 1331
Techno: 1078
Rock: 987

Most popular artists, by playcount:
blink-182: 621
DJ Miko &#38; Mini Me: 438
Goldfinger: 380
Paul Oakenfold: 362
Big D and the Kids Table: 347</pre>

[Check it out.](http://dinomite.net/wp-content/attic/parser.txt)
