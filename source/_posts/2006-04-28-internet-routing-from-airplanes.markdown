--- 
layout: post
comments: true
title: Internet routing from airplanes
mt_id: 65
date: 2006-04-28 13:33:59 -07:00
---
News to me: you can use The Internet from planes now; I knew that this was in the works, but I didn't think it had actually been implemented yet.  Apparently Lufthansa (others?) has WiFi planes that communicate with the outside world via satellite links.  As is thoroughly explained in [this post](http://www.renesys.com/blog/2006/04/tracking_plane_flight_on_inter.shtml), the plane connects to a geostationary satellite and has it's own /24 network.  The planes intelligently decide which satellite to use based upon which will produce shorter routing at the ground station and are able to dynamically change this throughout the flight.  As the Renesys blogger shows, the planes announce their route changes thus allowing graceful switches amongst the satellites.  Cool.

[This presentation](http://www.nanog.org/mtg-0405/abarbanel.html) explains the system that Boeing developed.
