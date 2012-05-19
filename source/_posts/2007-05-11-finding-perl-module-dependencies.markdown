--- 
layout: post
comments: true
title: Finding Perl Module Dependencies
mt_id: 110
date: 2007-05-11 06:48:14 -07:00
---
So you've written a Perl program and want to give it to someone else.  The only problem is, like any good Perl program, you've made good use of modules, some of which may be non-standard.  The person in question may not be able to install modules on the machine they're going to be running your script on, or maybe you just don't want to hassle them with that.  The easy way is to give them the modules in the proper directory structure right alongside your program; they simply toss the group of modules in the same directory as the script and when it's run the Perl interpreter searches . (the current directory) for the modules, finds them and goes about its merry way.

The only hiccup, some of the modules you've used depend on other modules...which may have further dependencies.  Rather than suffer through dependency reminiscent of Red Hat (even the newest version...), you can use the Devel::Modlist module which will tell you which modules are required to run the program.  Invoked with the 'nocore' option, Devel::Modlist will ignore standard modules, which ought to be installed with any Perl distribution.  Here is an example from a program I wrote; the only module I invoke directly is XML::SAX.

<pre><code>
~/code$ perl -d -MDevel::Modlist=nocore merge.pl foo.xml bar.xml

Loading DB routines from perl5db.pl version 1.28
Editor support available.

Enter h or `h h' for help, or `man perldebug' for more help.

XML::NamespaceSupport   1.09
XML::SAX               0.14
XML::SAX::Base         1.04
XML::SAX::DocumentLocator
XML::SAX::Exception    1.01
XML::SAX::ParserFactory   1.01
XML::SAX::PurePerl     0.90
XML::SAX::PurePerl::DTDDecls
XML::SAX::PurePerl::DocType
XML::SAX::PurePerl::EncodingDetect
XML::SAX::PurePerl::Productions
XML::SAX::PurePerl::Reader
XML::SAX::PurePerl::Reader::Stream
XML::SAX::PurePerl::Reader::String
XML::SAX::PurePerl::Reader::URI
XML::SAX::PurePerl::Reader::UnicodeExt
XML::SAX::PurePerl::UnicodeExt
XML::SAX::PurePerl::XMLDecl
~/code$
</code></pre>
