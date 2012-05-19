--- 
layout: post
comments: true
title: Writing your own Perl modules
mt_id: 104
date: 2007-03-13 14:33:35 -07:00
---
Making your own Perl modules is actually really easy, only involving a few special alterations to a script and an environment variable to make them easy to utilize.  To make Perl modules, you first need to understand Object Oriented Perl, so if that's new to you, check out [Tom's object-oriented Perl Tutorial](http://search.cpan.org/dist/perl/pod/perltoot.pod).  Onward.

For this example, I'll just use a simplified version of the 'Person' class from the above-mentioned tutorial:
<pre class="brush: perl;">
package Person;
use strict;

sub new {
	my $self  = {
		NAME => undef,
		AGE => undef,
		PEERS => [],
	};
	bless($self);
	return $self;
}
sub name {
	my $self = shift;
	if (@_) { $self->{NAME} = shift }
	return $self->{NAME};
}
sub age {
	my $self = shift;
	if (@_) { $self->{AGE} = shift }
	return $self->{AGE};
}
sub peers {
	my $self = shift;
	if (@_) { @{ $self->{PEERS} } = @_ }
	return @{ $self->{PEERS} };
}
1;
</pre>

To begin with, let's make a directory where you will put all the modules you make; say, `~/perl-modules`.  Take the code above and save it as `Person.pm` in your new `perl-modules` directory.  Notice the `.pm` extension that `perl` will look for when you go to `use` this module.  Now, we need to let `perl` know where to look for the modules you write.  When you ask for a Perl module by writing `use foo` in a script, `perl`, by default, it looks in a bunch of system directories and in the current directory for anything named `foo.pm`.  You can tell it to look other places by adding to the `PERL5LIB` environment variable.  For ease, I simply put this into my `.bashrc`:

<pre>
export PERL5LIB=~/perl-modules
</pre>

Now, anywhere that I write a perl script, I can simply say `use Person` and the Person class will be grabbed from my `perl-modules` directory.

Another thing to keep in mind when writing modules is that you should load the `Carp` module and use the functions `carp` and `croak` rather than `warn` and `die` respectively.  `Carp`'s functions produce errors that reference the proper context in the user's code when an error occurs, rather then saying there is a problem in your module.
