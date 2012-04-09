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

# HACK
my $today = '2012-04-08';

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

        # Let the rake task generate an appropriate title for us
        my $rakeTask = 'rake new_post["'. $post{title} .'"]';
        my $postFile = `$rakeTask`;
        $postFile =~ s/Creating new post: //;
        chomp $postFile;

        # I should probably learn the standard Date module
        $post{date} =~ m!(\d\d)/(\d\d)/(\d{4}) (\d\d):(\d\d):(\d\d) (\w\w)!;
        my $postDate = "$3-$1-$2";
        my $hour = $4;
        $hour += 12 if ($7 eq "PM");
        my $postTime = "$hour:$5";

        # Update the postfile
        my $newPost = '';
        open my $POST, "<", "$postFile";
        for (<$POST>) {
            if (/^date: /) { $_ =~ s/^date: .*/date: $postDate $postTime/; }
            elsif (/^categories: /) { $_ =~ s/^categories: /categories: [$post{category}]/; }

            $newPost .= $_;
        }
        close $POST;
        # Remove the rake-generated postfile
        unlink $postFile;

        # TODO change date on postfile path
        my $newPostFile = $postFile;
        $newPostFile =~ s/$today/$postDate/;
        open $POST, ">", "$newPostFile";
        print $POST $newPost;
        print $POST $post{body};
        close $POST;

        %post = ();
    }
}
