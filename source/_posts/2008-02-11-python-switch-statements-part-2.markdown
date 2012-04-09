---
layout: post
title: "Python Switch Statements - part 2"
date: 2008-02-11 24:22
comments: true
categories: [Programming]
---
My friend Lex read my post on [Python's lack of switch statements](http://dinomite.net/archives/dictatorial-leadership-is-sometimes-the-best) and sent me a note that the normal method for implementing something along the lines of a `switch` in Python is to use a dictionary.  First, let's define some functions:

<pre class="brush: python;">
def fooFunc():
    print 'Got foo?'
def barFunc():
    print 'Not foo.'
def nomatch():
    print 'No function to speak of!'

string = 'foo'
</pre>

Now we can create a dictionary and just lookup the variable you want to switch upon:

<pre class="brush: python;">
# Make a dictionary and call it switch
switch = {
    'foo': fooFunc,
    'bar': barFunc
    }

# Find the string in the dictionary, thereby calling the function
switch[string]()
switch['bar']()

# Another way to do the dictionary lookup
switch.get(string, nomatch)()
switch.get('bar', nomatch)()
</pre>

Which will call the function in the switch dictionary, or call `nomatch` if none of the dictionary entries match.  Or create an anonymous dictionary and do it all at once, more like a traditional `switch`:

<pre class="brush: python;">
{
    'foo' : fooFunc,
    'bar' : barFunc
}[string]()
</pre>
