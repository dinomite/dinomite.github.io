#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

# Sample post:
# AUTHOR: dinomite
# TITLE: Arctic weather
# BASENAME: arctic-weather
# STATUS: Publish
# ALLOW COMMENTS: 1
# CONVERT BREAKS: markdown
# ALLOW PINGS: 1
# PRIMARY CATEGORY: Uncategorized
# CATEGORY: Uncategorized
# DATE: 02/19/2006 10:46:54 AM
# TAGS: Science
# -----
# BODY:
# So, I knew it was going to be cold on Thursday...
# -----
# EXTENDED BODY:
#
# -----
# EXCERPT:
#
# -----
# KEYWORDS:
#
# -----
#
# COMMENT:
# AUTHOR: Mark Mayo
# EMAIL: mark@vmunix.com
# IP: 207.216.162.145
# URL: http://www.vmunix.com/mark/blog/
# DATE: 01/21/2006 10:53:02 PM
# Thanks for the TrackBack. Nice site! I particularly like the filesystems summary post.
# --------

my $POST_END_SENTINEL = "--------";
my $BODY_END_SENTINEL = "-----";

my $infile = shift @ARGV;
open my $fh, "<", $infile;

my %post;
my $inBody = 0;
my $body = '';
for (<$fh>) {
    %post = {} && next if (/^$POST_END_SENTINEL$/);

    unless ($inBody) {
        given ($_) {
            when (/^TITLE: (.*)/) { $post{title} = $1; }
            when (/^CATEGORY: (.*)/) { $post{category} = $1; }
            when (/^DATE: (.*)/) { $post{date} = $1; }
            when (/^BODY:$/) { $inBody = 1; }
        }
    } else {
        # In the BODY; accumulate until end 
        if (/^$BODY_END_SENTINEL$/) {
            $post{body} = $body;

            $inBody = 0;
            $body = '';
        } else {
            $body .= $_;
        }
    }

    if (defined $post{body}) {
        # We have title, category, date, and body

        %post = ();
    }
}
