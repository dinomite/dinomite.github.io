--- 
layout: post
comments: true
title: vBulletin login with WWW::Mechanize
mt_id: 57
date: 2006-04-03 12:45:46 -07:00
---
This is just part of a script that I wrote to...do something.  The pertinent part here is using WWW::Mechanize to login to a vBulletin web forum.  I figure Googlebot will guide someone trying to figure out how to use WWW::Mechanize this way.

<pre class="brush: perl;">
use WWW::Mechanize;
my $username = "foo";
my $password = "bar";
my $forum = "http://www.foo.com/forum/";

my $mech = WWW::Mechanize->new  (
                                    autocheck   =>  1,
                                    agent       =>  'Perl WWW::Mechanize',
                                );

$mech->get( $forum );
$mech->submit_form(
                        form_number =>  1,
                        fields      =>  {
                                            vb_login_username => $username,
                                            vb_login_password => $password
                                        }
                    );
$mech->follow_link(
    text => "Click here if your browser does not automatically redirect you."
    );
</pre>
