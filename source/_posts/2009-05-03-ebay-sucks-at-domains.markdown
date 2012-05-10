--- 
layout: post
title: eBay Sucks at Domains
mt_id: 246
date: 2009-05-03 17:58:22 -07:00
---
If you go to [http://ebay.com](http://ebay.com) you will briefly see a naked text page with the following text, broken sentence structure and all:

<pre>
The page you are looking for has been moved. If this page does not redirect you in 10 Secs,lease click here.
</pre>

It will only be visible for a fleeting moment, because your browser will be redirected to [www.ebay.com](http://www.ebay.com).  The world's flea market fails the [no-www](http://no-www.org/faq.php) test in the worst way - if you try to go to their website without a www subdomain, your are sent to said subdomain.  eBay fails in a special way; rather than simply using an Apache RewriteRule:

<pre class="brush: bash;">
RewriteEngine On
RewriteCond %{HTTP_HOST} ^example.com$ [NC]
RewriteRule ^(.*)$ http://www.example.com/$1 [R=301,L]
</pre>

they send a web page containing an HTML [meta refresh](http://en.wikipedia.org/wiki/Meta_refresh) to send you to [www.ebay.com](http://www.ebay.com).  This is a clumsy and slow way to perform a redirect, particularly for the front-page of your website.  If you are a website administrator or webmaster, please, don't be as hackish as eBay - embrace [Class A no-www compliance](http://no-www.org/faq.php) or at least redirect using [HTTP status codes](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#3xx_Redirection) rather than browser redirection.
