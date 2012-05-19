--- 
layout: post
comments: true
title: Creating a Perl Module in Modern Style
mt_id: 276
date: 2011-10-22 09:00:00 -07:00
---
One of the very best things about Perl is [CPAN](https://metacpan.org/), a repository of modules to do everything from [browse the web](https://metacpan.org/module/WWW::Mechanize) to [manipulating image files](https://metacpan.org/module/Image::Magick).  CPAN provides a consistent method for installing modules ([install cpanminus](https://metacpan.org/module/App::cpanminus#Installing-to-system-perl) and then `cpanm <Module::Name>`) and the largest number of modules of all the scripting languages.  More often than not, what you are trying to do has already been done and exists as a CPAN module.  In the event you are doing something new, the best way to give back to the community and get free help is to encapsulate your work and distribute it as a module on CPAN.

Historically, creating a module suitable for general consumption was a confusing.  Tutorials [from years past](http://world.std.com/~swmcd/steven/perl/module_mechanics.html) abound, [each one longer](http://www.perlmonks.org/?node_id=431702) [than the previous](http://members.pcug.org.au/~rcook/PerlModule_HOWTO.html), and [always employing a different toolchain](http://mathforum.org/~ken/perl_modules.html), making synthesis of common concepts impossible.  These days, however, things are much easier.  In the past 6 years or so the Perl community has tried on a [number](https://metacpan.org/module/ExtUtils::MakeMaker) of [methods](https://metacpan.org/module/Module::Build) for [building](https://metacpan.org/module/Module::Install) modules.  The focus of this article will be a recent (circa late 2009...the Perl ecosystem takes a measured pace) build system, [Dist::Zilla](https://metacpan.org/module/Dist::Zilla).

Whereas [ExtUtils::MakeMaker](https://metacpan.org/module/ExtUtils::MakeMaker) and [Module::Build](https://metacpan.org/module/Module::Build) are systems for building, testing, and installing a release, Dist::Zilla sits at a higher level.  With Dist::Zilla, you create a single file that controls the build & test flow (using [ExtUtils::MakeMaker](https://metacpan.org/module/Dist::Zilla::Plugin::MakeMaker) under the hood) but also provide functionality for generating semi-boilerplate files (LICENSE, MANIFEST, META.yml) and releasing the code via CPAN.  The configuration file, `dist.ini`, is easy-to-read and short in contrast to prior build systems.

To start using Dist::Zilla, install it using the standard CPAN shell command (`cpan -i Dist::Zilla`) or with cpanminus (`cpanm Dist::Zilla`).  You utilize Dist::Zilla through the command `dzil`; if that's not in your path (`which dzil`), then you'll want to find it and symlink it somewhere useful or add it to your path.  Global setup of dzil is done by invoking `dzil setup` and answering the questions it poses.  With that done you can very easily mint a new distribution:

<pre class="brush: perl">
Titus:~/sandbox$ dzil new Number::Cruncher
[DZ] making target dir /Users/dinomite/Dropbox/sandbox/Number-Cruncher
[DZ] writing files to /Users/dinomite/Dropbox/sandbox/Number-Cruncher
[DZ] dist minted in ./Number-Cruncher
</pre>

In the newly created Number-Cruncher directory you'll find a `lib` directory containing `Number/Cruncher.pm` and a `dist.ini`
:
<pre class="brush: perl">
name    = Number-Cruncher
author  = Drew Stephens [drew@dinomite.net]
license = Perl_5
copyright_holder = Drew Stephens
copyright_year   = 2011

version = 0.001

[@Basic]
</pre>

At this point, code and tests are the only things needed to have a Perl module.  Here's some simple code for `lib/Number/Cruncher.pm`:

<pre class="brush: perl">
use strict;
use warnings;
package Number::Cruncher;

=head1 NAME

Number::Cruncher - crunch numbers

=cut

sub new {
    my $class = shift;
    my $self = {
        first => shift,
        second => shift,
    };
    bless $self, $class;
    return $self;
}

sub crunch {
    my $self = shift;
    return $self->{first} + $self->{second};
}

1;
</pre>

And the associated test file that I created, `t/number-cruncher.t`:

<pre class="brush: perl">
#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 2;

BEGIN { use_ok 'Number::Cruncher'; }

my $first = 1;
my $second = 7;
my $cruncher = Number::Cruncher->new($first, $second);
ok (($first + $second) == $cruncher->crunch());
</pre>

In three files--`dist.ini`, `lib/Number/Cruncher.pm`, and `t/number-cruncher.t`--we have a module.  Run the test with `dzil test` and you'll see Dist::Zilla build your module into a temporary directory and run the test suite from there:

<pre class="brush: shell">
Titus:~/sandbox/Number-Cruncher$ dzil test
[DZ] building test distribution under .build/mgJsQhkFi6
[DZ] beginning to build Number-Cruncher
[DZ] guessing dist's main_module is lib/Number/Cruncher.pm
[DZ] extracting distribution abstract from lib/Number/Cruncher.pm
[DZ] writing Number-Cruncher in .build/mgJsQhkFi6
Checking if your kit is complete...
Looks good
Writing Makefile for Number::Cruncher
cp lib/Number/Cruncher.pm blib/lib/Number/Cruncher.pm
Manifying blib/man3/Number::Cruncher.3
PERL_DL_NONLAZY=1 /usr/local/Cellar/perl/5.12.3/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/number-cruncher.t .. ok   
All tests successful.
Files=1, Tests=2,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.02 cusr  0.00 csys =  0.05 CPU)
Result: PASS
[DZ] all's well; removing .build/mgJsQhkFi6
</pre>

To build a distributable tarball, just run `dzil build`:

<pre class="brush: shell">
Titus:~/sandbox/Number-Cruncher$ dzil build
[DZ] beginning to build Number-Cruncher
[DZ] guessing dist's main_module is lib/Number/Cruncher.pm
[DZ] extracting distribution abstract from lib/Number/Cruncher.pm
[DZ] writing Number-Cruncher in Number-Cruncher-0.001
[DZ] building archive with Archive::Tar::Wrapper
[DZ] writing archive to Number-Cruncher-0.001.tar.gz
Titus:~/sandbox/Number-Cruncher$ ls Number-Cruncher-0.001*
Number-Cruncher-0.001.tar.gz

Number-Cruncher-0.001:
LICENSE     META.yml    README      lib
MANIFEST    Makefile.PL dist.ini    t
</pre>

If you already have a PAUSE account, you can use `dzil release` to upload that tarball to PAUSE for inclusion in CPAN.  If you haven't authored a Perl module before, [request an account](http://pause.perl.org/pause/query?ACTION=request_id) for uploading modules to CPAN.  With PAUSE and Dist::Zilla, creating widely-available Perl modules is easy.

## See Also

* [dzil.org](http://dzil.org)
* [Dist::Zilla::Tutorial](https://metacpan.org/module/Dist::Zilla::Tutorial)
* [Shell::Verbose](https://metacpan.org/release/Shell-Verbose), my first Dist::Zilla-powered module 
<p><br /> </p>
