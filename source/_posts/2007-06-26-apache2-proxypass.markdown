--- 
layout: post
comments: true
title: Apache2 ProxyPass
mt_id: 123
date: 2007-06-26 12:02:05 -07:00
---
If you're trying to setup a proxy on Apache2 in Ubuntu Feisty, by default it disallows all access to any proxy URLs, which is good.  What isn't good, however, is that nowhere I could find mentioned that this could be found in the `proxy.conf` file located in `/etc/apache2/mods-enabled`.  I spent some time wondering why my Allow and Deny orders were being ignored until I looked at this file and found that it has the final say.  To allow access to your proxy, you must edit this file adding 'Allow' orders within the `<proxy *>` block.  Simply use hostnames, IP addresses or [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation:

<code><pre>
Allow from foo.com
Allow from 192.168.1.52
Allow from 10.1.0
Allow from 10.1.0.0/255.255.0.0
Allow from 192.168.0.0/16
</pre></code>

For more detail, see the [`mod_access` documentation](http://httpd.apache.org/docs/1.3/mod/mod_access.html).
