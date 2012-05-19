--- 
layout: post
comments: true
title: Custom Weather Radar Images
mt_id: 167
date: 2007-12-07 05:19:38 -08:00
---
<a href='http://dinomite.net/wp-content/uploads/2007/12/base_reflectivity.jpg' title='NWS base reflectivity for LWX' class='right'><img src='http://dinomite.net/wp-content/uploads/2007/12/base_reflectivity.jpg' alt='NWS base reflectivity for LWX' /></a>
If you know the slightest bit about weather and the geography of the area which you are observing, you can, in the short term, forecast more accurately than what a weather website provides.  I often want to be able to bring a radar image up quickly and clicking around websites takes time.  Sure I could bookmark the weather page directly, but this was an interesting exercise and will prove useful when I get an iPhone.

The [National Weather Service](http://nws.noaa.gov) doesn't have a simple image of the weather on their [radar page](http://radar.weather.gov/radar.php?rid=lwx&product=N0R&overlay=11101111&loop=no), rather, it is an image that is dynamically generated from a set of standard overlays using Javascript.  This allows them to more efficiently distribute radar images, since the terrain and maps that are the background never change.  The organization they use is [well documented](http://www.srh.noaa.gov/srh/jetstream/doppler/ridge_download.htm), making it easy to find the overlays for you local radar.  In my case, I wanted the topographical map, counties and highways in the image.    I found the URL for each of these components using the aforementioned documentation and grabbed the appropriate images with `wget`.
<pre>
wget http://radar.weather.gov/ridge/Legend/N0R/LWX_N0R_Legend_0.gif\
http://radar.weather.gov/ridge/Overlays/County/Short/LWX_County_Short.gif\
http://radar.weather.gov/ridge/Overlays/Highways/Short/LWX_Highways_Short.gif\
http://radar.weather.gov/ridge/Overlays/Topo/Short/LWX_Topo_Short.jpg\
http://radar.weather.gov/ridge/RadarImg/N0R/LWX_N0R_0.gif
</pre>

The only layer that will change will be the last one, the actual radar data, so in my script that is the only one that will be `wget`d on subsequent runs.  To build the image, I used the `composite` program that is part of the ImageMagick package:
<pre>
composite -compose atop LWX_N0R_0.gif LWX_Topo_Short.jpg base_reflectivity.jpg
composite -compose atop LWX_Highways_Short.gif base_reflectivity.jpg base_reflectivity.jpg
composite -compose atop LWX_County_Short.gif base_reflectivity.jpg base_reflectivity.jpg
composite -compose atop LWX_N0R_Legend_0.gif base_reflectivity.jpg base_reflectivity.jpg
</pre>

I want the counties, highways and legend to show up on top of the weather data which itself is pasted atop the topographical map.  To achieve this, I first toss the radar data onto the topographical image creating a new image, `base_reflectivity.jpg`.  Then, I add each of the other layers to the `base_reflectivity.jpg` image in sequence.
