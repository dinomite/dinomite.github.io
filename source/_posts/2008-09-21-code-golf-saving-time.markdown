--- 
layout: post
comments: true
title: "Code Golf: Saving Time"
mt_id: 222
date: 2008-09-21 21:57:55 -07:00
---
After a new challenge, [Saving Time](http://codegolf.com/saving-time) was posted a few weeks ago, I'm finally getting to another round of [Code Golf](http://codegolf.com/).  As usual, my preferred language is Perl; don't read below if you don't want hints! 


My first draft grabs the hour and minutes using capturing in a regex, then turns them both into positions on a twelve hour clockface.  The clock location is passed to the function `symbol` which, through use of some nasty nested ternaries, what should be printed at the passed position on the clock face. (470 characters):

<pre class="brush: perl;">
<> =~ /(\d+):(\d+)/;
$H = $1 % 12;
$M = ($2 - ($2 % 5)) / 5;

$;=' ';

$z = $;x8 . symbol(0) . $/;
$z .= $;x4 . symbol(11) . $;x7 . symbol(1) . $/.$/;
$z .= $; . symbol(10) . $;x13 . symbol(2) . $/.$/;
$z .= symbol(9) . $;x15 . symbol(3) . $/.$/;
$z .= $; . symbol(8) . $;x13 . symbol(4) . $/.$/;
$z .= $;x4 . symbol(7) . $;x7 . symbol(5) . $/;
$z .= $;x8 . symbol(6);

print $z;

sub symbol {
    $_ = shift;
    $H==$_ ? ($H==$M ? 'x' : 'h') : ($M==$_ ? 'm' : 'o');
}
</pre>

Perl provides the automatic variables ``$` `` and `$'` (aka  `$PREMATCH` and `$POSTMATCH` with `use English`) which are, unsurprisingly, the portions of a scalar before and after what your regex matched.  I simplified the input regex by simply matching the colon and grabbing the hours & minutes from ``$` `` and `$'`.    shorten subroutine name (398 characters):

<pre class="brush: perl;">
<> =~ /:/;
$H = $` % 12;
$M = int $'/5;

$;=' ';

$z = $;x8 . sy(0) . $/; 
$z .= $;x4 . sy(11) . $;x7 . sy(1) . $/.$/;
$z .= $; . sy(10) . $;x13 . sy(2) . $/.$/;
$z .= sy(9) . $;x15 . sy(3) . $/.$/;
$z .= $; . sy(8) . $;x13 . sy(4) . $/.$/;
$z .= $;x4 . sy(7) . $;x7 . sy(5) . $/;
$z .= $;x8 . sy(6);

print $z;

sub sy {
    $_ = shift;
    $H==$_ ? ($H==$M ? 'x' : 'h') : ($M==$_ ? 'm' : 'o');
}
</pre>

I spun off the drawing of most lines into a single function, which takes the number of preceding spaces, the leftmost hour mark on the line, the number of interstitial spaces and the final hour mark on the line (380 characters):

<pre class="brush: perl;">
<> =~ /:/;
$H = $` % 12;
$M = int $'/5;

$;=' ';

$z = $;x8 . sy(0) . $/; 
$z .= li(4,11,7,1) . $/;
$z .= li(1,10,13,2) . $/;
$z .= li(0,9,15,3) . $/;
$z .= li(1,8,13,4) . $/;
$z .= li(4,7,7,5);
$z .= $;x8 . sy(6);

print $z;

sub li {
    $;x$_[0] . sy($_[1]) . $;x$_[2] . sy($_[3]) . $/;
}   
sub sy {
    $_ = shift;
    $H==$_ ? ($H==$M ? 'x' : 'h') : ($M==$_ ? 'm' : 'o');
}
</pre>

Before getting totally mucked up (311 characters):

<pre class="brush: perl;">
<> =~ /:/;
$H = $` % 12;
$M = int $'/5;
print ' 'x8 . sy(0) . $/ . li(4,11,7,1) . $/ . li(1,10,13,2) . $/ . li(0,9,15,3) . $/ . li(1,8,13,4) . $/ . li(4,7,7,5) . ' 'x8 . sy(6);

sub li {' 'x$_[0] . sy($_[1]) . ' 'x$_[2] . sy($_[3]) . $/;}
sub sy {$_ = shift; $H==$_ ? $H==$M ? 'x' : 'h' : $M==$_ ? 'm' : 'o';}
</pre>

My final effort which is 244 characters when concatenated onto a single line:

<pre class="brush: perl;">
<>=~/:/;
$H=$`%12;
$M=int $'/5;
sub li{' 'x$_[0].sy($_[1]).' 'x$_[2].sy($_[3]).$/}
sub sy{$_=shift;$H==$_?$H==$M?'x':'h':$M==$_?'m':'o'}
print ' 'x8 .sy(0).$/.li(4,11,7,1).$/.li(1,10,13,2).$/.li(0,9,15,3).$/.li(1,8,13,4).$/.li(4,7,7,5).' 'x8 .sy(6)
</pre>
