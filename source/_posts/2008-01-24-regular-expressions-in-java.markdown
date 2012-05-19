--- 
layout: post
comments: true
title: Regular Expressions in Java
mt_id: 176
date: 2008-01-24 07:04:55 -08:00
---
Perl is my favorite language in part because of the fluidity with which regular expressions fit in.  To loop through a file grabbing content out of matching lines is absolutely trivial:

<pre class="brush: perl;">
my @found;
for my $line (<infile>) {
    # Match lines and capture 'jazz' and everything that follows
    if ( /match this (jazz.*)$/ ) {
        # Save the captured stuff in an array
        push @found, $0;
    }
}
</pre>

Most other languages make such matching more difficult and Java is one of them.  Like in Python, regular expressions must first be compiled before they can be used for matching.  This multi-step process is significantly more cumbersome and if I haven't dealt with it for any length of time, I have to look up the procedure.  Here's a quick rundown of the same matching from above, this time in Java:

<pre class="brush: java;">
String regex = "match this (jazz.*)$";
Pattern myPattern = Pattern.compile( regex );

Vector<string> found = new Vector();
String line = null;
while ( (line = infile.readLine()) != null ) {
    Matcher myMatcher = myPattern.matcher( line );
    if ( myMatcher.find() ) {
        found.add( myMatcher.group(1) );
    }
}
</pre>

That's a bit of a hassle.
