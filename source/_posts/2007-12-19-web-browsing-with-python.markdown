--- 
layout: post
comments: true
title: Web Browsing With Python
mt_id: 169
date: 2007-12-19 17:52:53 -08:00
---
Python provides a stateful web browsing module called [`mechanize`](http://wwwsearch.sourceforge.net/mechanize/), named after Perl's mature and featureful [`WWW::Mechanize`](http://search.cpan.org/author/PETDANCE/WWW-Mechanize-1.34/lib/WWW/Mechanize.pm).  Though it isn't as powerful as the Perl version, `mechanize` provides an easy-to-use framework for browsing web pages including interacting with forms and accessing SSL content.  The documentation for `mechanize` on the web is sparse, but viewing the source file (`/usr/lib/python2.5/site-packages/mechanize/_mechanize.py` on my Ubuntu machine) provides some needed insight.  Here's a quick overview of the operation of `mechanize`:

<pre class="brush: python;">
#!/usr/bin/python
import re
from mechanize import Browser
br = Browser()

# Ignore robots.txt
br.set_handle_robots( False )
# Google demands a user-agent that isn't a robot
br.addheaders = [('User-agent', 'Firefox')]

# Retrieve the Google home page, saving the response
br.open( "http://google.com" )

# Select the search box and search for 'foo'
br.select_form( 'f' )
br.form[ 'q' ] = 'foo'

# Get the search results
br.submit()

# Find the link to foofighters.com; why did we run a search?
resp = None
for link in br.links():
    siteMatch = re.compile( 'www.foofighters.com' ).search( link.url )
    if siteMatch:
        resp = br.follow_link( link )
        break

# Print the site
content = resp.get_data()
print content
</pre>

That's a pretty straightforward and simple usage.  The `get_data()` method gives you the HTML content of the pages, which I often find suitable to run a `.split('\n')` and then do some regex on line by line.
