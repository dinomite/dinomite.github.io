--- 
layout: post
title: here-documents in Perl
mt_id: 210
date: 2008-05-24 08:10:20 -07:00
---
[Here-documents](http://en.wikipedia.org/wiki/Here_document) are something that, once you know about them, you wonder how you ever got along without.  I first learned about here-docs in Python many years ago, but didn't know their proper name.  In Python, you define a here document with three single or double quotes:

<pre class="brush: python;">foo = """
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt 
mollit anim id est laborum.
"""</pre>

One day, when I wanted to put some large blocks of text amongst code, I searched for a way to do this in Perl and found the syntax:
<pre class="brush: perl;">my $foo =<< "EOF";
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et 
dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt 
mollit anim id est laborum.
EOF</pre>
Note the use of quotes for the string-terminating sentinel (EOF, in this case, though it can be anything), which affects how the sting is interpreted.  Just like with other strings in Perl, double-quotes mean that variables and escapes will be interpreted whereas they are ignored in single-quoted strings.
