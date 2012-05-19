--- 
layout: post
comments: true
title: SSH Tunnels for Quick, Secure Net Access
mt_id: 144
date: 2007-09-09 18:06:58 -07:00
---
An SSH tunnel is a great way to quickly setup a secure method for browsing the web from an unsecure location, such as a public wireless network.  All you need is a machine running an SSH server.  I setup a tunnel from my Mac OS X laptop using the following command:

<pre>
ssh -C -D 7070 dinomite.net
</pre>

This sets up a tunnel, locally accessible on the laptop on port 7070 (`-D 7070`), that sends any traffic through the encrypted and compressed (`-C`) SSH stream to the server, where it is spit out onto the net as normal.  To use this tunnel, I simply instruct Firefox to connect via a SOCKS proxy on port 7070:

<a href='http://dinomite.net/wp-content/uploads/2007/09/settings.png' title='Firefox 2 Advanced Settings Window'><img src='http://dinomite.net/wp-content/uploads/2007/09/settings.png' alt='Firefox 2 Advanced Settings Window' /></a>
<a href='http://dinomite.net/wp-content/uploads/2007/09/proxy.png' title='Firefox 2 Proxy Settings'><img src='http://dinomite.net/wp-content/uploads/2007/09/proxy.png' alt='Firefox 2 Proxy Settings' /></a>

Many other applications, such as Adium, support SOCKS proxies and can be set up in a similar way to send their traffic to port 7070 and take advantage of an SSH tunnel.
