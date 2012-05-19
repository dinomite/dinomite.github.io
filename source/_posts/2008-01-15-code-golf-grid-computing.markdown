--- 
layout: post
comments: true
title: "Code Golf: Grid Computing"
mt_id: 171
date: 2008-01-15 09:58:52 -08:00
---
[A new puzzle](http://codegolf.com/grid-computing) went up on [Code Golf](http://codegolf.com) a few weeks ago and I finally got some time to sit down and hack on it, so here's another annotated instalment of my pruning process.  I haven't gotten anywhere near the smallest solutions which are half of my 109 characters.  See the action below, but don't look if you don't want hints! 


Initially, a straightforward `for` loop that reads from standard input or a passed file; huzzah for Perl's built-in flexibility.  Within this loop, a counter, `$n`, is incremented to fill an array, `@c`, with the sum of each column; the sum of the row is stored in `$r`.  At the end of each iteration of the loop, the greatest row sum, `$a`, is set to the just-completed row if said row is greater than what has been seen previously or the answer is `undef`, as it is the first time through.  The lower loop puts the greatest column sum into `$b`.

My first pass through is 190 characters:
<pre class="brush: perl;">
for (<>) {
	$n = $r = 0;
	for (split ' ', $_) {
		@c[$n] += $_;
		$r += $_;
		$n++;
	}

	$a = $r if ($r > $a);
}

for (@c) {
	$b = $_ if ($_ > $b);
}

($b > $a) ? print $b.$/ : print $a.$/;
</pre>

Note that Perl is flexible; by using `<>`, input can be passed as a file on the command line or via stdin.  With some quick re-ordering of the top loop and turning the lower loop into a `map`, 20 characters are saved.  170 characters:
<pre class="brush: perl;">
for (<>) {
	$n = $r = 0;
	@c[$n++] += $_, $r += $_ for (split ' ', $_);

	$a = $r if ($r > $a);
}

map {$b = $_ if ($_ > $b)} @c;

($b > $a) ? print $b.$/ : print $a.$/;
</pre>

Much of the whitespace can be removed (though I'll leave the newlines for now).  Down to 138 characters:
<pre class="brush: perl;">
for(<>){
	$n=$r=0;
	@c[$n++]+=$_, $r+=$_ for split' ',$_;
	$a=$r if $r>$a;
}

map{$b=$_ if $_>$b} @c;

$b>$a ? print $b.$/ : print $a.$/;
</pre>

The `print` can be simplified, dropping 6 characters:
<pre class="brush: perl;">
for(<>){
	$n=$r=0;
	@c[$n++]+=$_, $r+=$_ for split' ',$_;
	$a=$r if $r>$a;
}

map{$b=$_ if $_>$b} @c;

print $b>$a ? $b.$/ : $a.$/;
</pre>

At which point I'm stuck.  After beating out the last bits of whitespace, that is 109 characters.
