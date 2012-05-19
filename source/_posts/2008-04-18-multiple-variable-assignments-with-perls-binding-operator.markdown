--- 
layout: post
comments: true
title: Multiple Variable Assignments with Perl's Binding Operator
mt_id: 203
date: 2008-04-18 08:29:55 -07:00
---
I learned something new in the world of Perl regular expressions today when I came across this line:

<pre class="brush: perl;">
 my ($foo, $bar, $baz) = $string =~ /(.oo)(.*?r)(.*?z)/;
</pre>

The operative side of the line, `$string =~ /(.oo)(.*?r)(.*?z)/` is a normal Perl regex binding statement - apply the regular expression `/(.oo)(.*?r)(.*?z)/` to `$string`.  What's interesting is that the binding operator returns the things matched within the capturing parenthesis as an array, allowing you to assign them all at once, as demonstrated by the left hand side of that `=` expression.  The above statement does the same as the more verbose:

<pre class="brush: perl;">
$string =~ /(.oo)(.*?r)(.*?z)/;
my ($foo, $bar, $baz) = ($1, $2, $3);
</pre>

Used in a scalar context along with the `/g` modifier, this is an easy way to count count occurences:

<pre class="brush: perl;">
my $count = $string =~ m/\./g;
</pre>
