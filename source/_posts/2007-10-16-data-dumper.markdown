--- 
layout: post
comments: true
title: Data::Dumper
mt_id: 155
date: 2007-10-16 11:08:04 -07:00
---
[Data::Dumper](http://perldoc.perl.org/Data/Dumper.html) is one of the most useful Perl modules when developing code, providing quick and easy access to the contents of data structures.  Are you unsure whether you're setting the values of a hash correctly?  Don't understand how someone has organized an object that you're 'use'ing?  Data::Dumper to the rescue.

<pre>
use Data::Dumper;

my %foo;
$foo{'bar'} = 'This is bar';
$foo{'baz'}{'foo'} = 'This is foo, stored under baz in %foo';
$foo{'qux'} = 'This is qux';

print "The hash '%foo' looks like this:\n";
print Dumper(\%foo);
</pre>

When executed:
<pre>
The hash '%foo' looks like this:
$VAR1 = {
          'bar' => 'This is bar',
          'baz' => {
                     'foo' => 'This is foo, stored under baz in %foo'
                   },
          'qux' => 'This is qux'
        };
</pre>

Note that I passed Dumper() a reference to the 'foo' hash by using a backslash, which is what you will want most of the time with anything other than a scalar.  Passing a reference causes Dumper() to print the entire variable's contents in the same scope.  If you pass 'foo' directly, instead of its reference, you end up with this:
<pre>
The hash '%foo' looks like this:
$VAR1 = 'bar';
$VAR2 = 'This is bar';
$VAR3 = 'baz';
$VAR4 = {
          'foo' => 'This is foo, stored under baz in %foo'
        };
$VAR5 = 'qux';
$VAR6 = 'This is qux';
</pre>

Which doesn't make it clear that 'foo' is a hash.
