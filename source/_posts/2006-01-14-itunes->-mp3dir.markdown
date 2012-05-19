---
layout: post
comments: true
title: "iTunes -> MP3dir"
date: 2006-01-14 11:51
comments: true
categories: [Programming]
---
Bery Rinaldo made a <a href="http://homepage.mac.com/beryrinaldo/AudioTron/Export_Playlist_to_M3U/"> script to export iTunes playlists as M3Us</a>, which is great and the first thing you need in order to make use of my script.  So, grab that off of his web page and install it into `/Users/<username>/Library/iTunes/Scripts` (create that directory if you don't already have it).

I wrote this script because I wanted to be able to make a playlist and give give a friend the associated files for said playlist.  To start, use Bery's script from above and export a playlist.  Then grab [my script](http://dinomite.net/wp-content/attic/playlist.txt) and run it, passing the name of the M3U file that you just created.  My script will create a directory in the same place as the M3U that you passed to it, fill that with the MP3s from said playlist, and create a new M3U for the directory.</username>
