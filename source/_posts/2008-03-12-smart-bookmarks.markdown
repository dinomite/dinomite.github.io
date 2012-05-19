--- 
layout: post
comments: true
title: Smart Bookmarks
mt_id: 194
date: 2008-03-12 22:15:46 -07:00
---
[Jeff Atwood of Coding Horror](http://www.codinghorror.com/blog/) made a very good point recently about [browser shortcuts](http://www.codinghorror.com/blog/archives/001037.html) that make browsing the web quicker because they reduce your dependence upon the mouse.  If you have any semblance of [RSI](http://en.wikipedia.org/wiki/Repetitive_strain_injury) caused by mouse usage, like mine is, then learning to maximize use of the keyboard in place of the mouse is paramount.  Following on this I will share a number of [smart bookmarks](http://en.wikipedia.org/wiki/Smart_bookmark) that I have found to be indispensible since I started using them way back when [Galeon](http://galeon.sourceforge.net/Main) was my browser of choice and Firefox nÃ©e Phoenix wasn't even on the drawing board.

Smart bookmarks are bookmarks that you call with a keyword and an argument; the argument is shoved into the appropriate place within the bookmark and the resulting URL is then retrieved.  Their function is similar to the manner in which a fresh installation of Firefox will automatically bring up a Google search results page if you type something that isn't a URL into the address bar.  To create a smart bookmark in Firefox, first bookmark a page such as a Google Search results page in the normal fashion.

<a href='http://dinomite.net/wp-content/uploads/2008/03/google-foo.png' title='Google foo'><img src='http://dinomite.net/wp-content/uploads/2008/03/google-foo.png' alt='Google foo' /></a>

Then, open the "Organize Bookmarks" window by selecting it from the Bookmarks menu in Firefox.

<a href='http://dinomite.net/wp-content/uploads/2008/03/bookmarks.png' title='Organize Bookmarks'><img src='http://dinomite.net/wp-content/uploads/2008/03/bookmarks.png' alt='Organize Bookmarks' /></a>

Select "Properties" for the bookmark you created and enter something into the "Keyword" field; for Google, I use the letter "g".  To actually make it a smart bookmark, you need to tell your browser where the string you pass needs to end up by placing "%s" (a percent sign and an "s") in the appropriate place.  For my Google search bookmark, the resulting URL string is this: http://www.google.com/search?hl=en&q=%s&btnG=Google+Search

<a href='http://dinomite.net/wp-content/uploads/2008/03/properties.png' title='Bookmark properties'><img src='http://dinomite.net/wp-content/uploads/2008/03/properties.png' alt='Bookmark properties' /></a>

What does this get you?  Well, now you can select the address bar (Apple+L in MacOS, Ctrl+L or Alt+D in Windows & Linux) type "g foo" in order to search for "foo".  A lot of people use the search bar in Firefox to do just that already, but I find my method better because I have a ton of smart bookmarks for performing different searches.  Alongside that one for Google, I have a [Wikipedia smart bookmark](http://en.wikipedia.org/wiki/%s) (bookmark that link and add a keyword such as "w") which will take me directly to the Wikipedia article for the string I enter, a [Wikipedia search bookmark](http://www.google.com/search?hl=en&q=%s%20site%3Aen.wikipedia.org&btnG=Google+Search) that does a Google search of just Wikipedia ("ws") and a [Google Finance search bookmark](http://finance.google.com/finance?q=%s) ("gf").

Others that I use include:
<ul>
<li>a - <a href="http://amazon.com/s/ref=nb_ss_gw/102-2288794-0413724?url=search-alias%3daps&field-keywords=%s&go.x=0&go.y=0&go=go">Amazon</a></li>
<li>p - <a href="http://packages.ubuntu.com/cgi-bin/search_packages.pl?keywords=%s&searchon=names&subword=1&version=feisty&release=all">Ubuntu package search</a></li>
<li>pc - <a href="http://packages.ubuntu.com/cgi-bin/search_contents.pl?word=%s&searchmode=searchfiles&case=insensitive&version=feisty&arch=i386">Ubuntu package contents search</a></li>
<li>d - <a href="http://dictionary.reference.com/search?q=%s&x=0&y=0">Dictionary</a></li>
<li>t - <a href="http://thesaurus.reference.com/search?q=%s">Thesaurus</a></li>
<li>pd - <a href="http://perldoc.perl.org/search.html?q=%s">Perldocs</a></li>
<li>pm - <a href="http://search.cpan.org/search?query=%s&mode=all">CPAN</a></li>
<li>y - <a href="http://youtube.com/results?search_query=%s&search=Search">YouTube</a></li>
</ul>

By far the ones that I use the most are those for Google and Wikipedia searching but having ultra-quick access to a thesaurus and dictionary greatly heightens my writing skill.  Smart bookmarks are something where, once you start using them, you'll wonder how others ever get stuff done while they waste time reaching for the mouse.
