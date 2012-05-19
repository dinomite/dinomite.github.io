--- 
layout: post
comments: true
title: Profiling Perl, part 1
mt_id: 139
date: 2007-08-17 11:05:30 -07:00
---
An important and often-overlooked part of programming is profiling of code to find out where the most time is being spent and then figuring out how the resulting sections of your program can be improved.  This aspect of writing code gets little attention from people writing user-bound applications because generally, computers are fast enough that even atrocious code can complete before the user is ready to respond.  Despite this fact execution speed is still important, especially in data processing code such as that which parses large datasets (which I often find myself doing) or converts videos, for instance.  If your code consists of a number of nested loops, you can probably benefit from profiling it and speeding up the most oft-used pieces.  Even if that doesn't apply, timing the execution of statements will certainly improve your understanding of which operations are fast and which drag you down.

The very simplest form of profiling code is using manually activated timers.  In Perl, this is accomplished with the `Benchmark::Timer` module as follows:
<pre class="brush: perl;">
use strict;
use warnings;

use Benchmark::Timer;
my $timer = Benchmark::Timer->new();

$timer->start('overall');

$timer->start('single');
sleep 5;
$timer->stop('single');

$timer->start('loop');
for (my $x = 0; $x < 5; $x++) {
    sleep 1;
}
$timer->stop('loop');

$timer->stop('overall');

print "The single 'sleep' took " . $timer->result('single') . " seconds.\n";
print "The 'sleep' loop took " . $timer->result('loop') . " seconds.\n";
print "Overall, this took " . $timer->result('overall') . " seconds.\n";
</pre>

Which, when run, produces something like the following output:
<pre>
~$ ./foo.pl
The single 'sleep' took 5.002198 seconds.
The 'sleep' loop took 5.020094 seconds.
Overall, this took 10.022404 seconds.
</pre>

Easy and quick.  Next time, Devel::DProf.
