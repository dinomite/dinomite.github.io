--- 
layout: post
comments: true
title: VPN Disconnects due to Altered Routing Table
mt_id: 145
date: 2007-09-15 11:06:34 -07:00
---
I was having trouble with my Nortel Contivity VPN client disconnecting giving an error message, "The routing table cannot be altered after the Contivity VPN Connection has been established. The Contivity VPN Connection has been Closed."  This would happen after 10-20 minutes of being connected and would cause all of my SSH sessions to drop, which made it hard to get work done.  After some searching, I found the solution to my problem, a simple registry addition.  I added the DWORD named "PerformRouterDiscovery" with the value 0 to the key `"HKEY_LOCAL_MACHINE_SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"`.  After rebooting, the VPN works without the random disconnects.  Download [this .reg file](http://dinomite.net/wp-content/uploads/2007/09/performrouterdiscovery.reg) and run it to add the aforementioned key.
