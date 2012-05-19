--- 
layout: post
comments: true
title: Signal Handling in Perl
mt_id: 256
date: 2010-09-27 18:54:29 -07:00
---
Perl signal handling is easy.  Simply create a subroutine to handle a signal and register it as handler in the <a href="http://perldoc.perl.org/perlvar.html#%25SIG">%SIG</a> hash:

<pre class="brush: perl">
#!/usr/bin/env perl
$SIG{'INT'} = \&sigIntHandler;

sleep 100;

sub sigIntHandler {
    print "INT caught!\n";
    exit;
}
</pre>

While this is better than nothing, its fairly limited.  Your program is yanked out of its scope, making it difficult to clean up.  Without any state information, how are you supposed to know what to do when you get the signal?  The easiest thing to do is note that you have received a signal in the handler, then check and deal with that fact within any parts of your program that need to do things when signals occur.

<pre class="brush: perl">
#!/usr/bin/env perl
$SIG{'INT'} = \&sigIntHandler;

# Flags for signals that have been caught
my %caught;

while (1) {
    print "Sleeping 5\n";
    sleep 5;
    print "More sleeping\n";
    sleep 5;

    # If we got SIGINT (2), exit
    exit if ($caught{'INT'} == 1);
}

# When we get a signal, set a flag in %caught
sub sigIntHandler {
    print "INT caught!\n";
    $caught{'INT'} = 1;
}
</pre>

In this setup, all the signal handler does it set a flag in the <a href="http://www.effectiveperlprogramming.com/blog/630">package global</a> <tt>%caught</tt> that the program received a signal.  The main loop checks each time through to see if a signal has been issued and does what is appropriate; in this case, simply exiting.  Play around with this simple program and notice that when the signal happens, the statement that was being executed is interrupted and Perl starts back up with the next statement once the signal handler returns.


In a real-world example makes things much clearer, demonstrating how you can actually use signals for program management.  At <a href="http://eng.genius.com">Genius.com</a> we have a daemon that starts worker children to perform tasks.  The main loop for each of these children looks something like this:

<pre class="brush: perl">
# Worker class for daemon
package ExampleDaemon::Worker;
use Moose;

# Declare the global
our $SIG_CAUGHT = 0;

# Explicit constructor in Moose
sub BUILD {
    $SIG{'INT'} = \&sigHandler;
    $SIG{'TERM'} = \&sigHandler;
}

# Main loop
sub doWork {
    my ($self) = @_;
    my $widgetsMade = 0;

    while (1) {
        # Make a widget

        # Check for signals each time through
        last if $SIG_CAUGHT
    }

    return $widgetsMade;
}

sub sigHandler {
    my ($sigName) = @_;

    $SIG_CAUGHT = 1;

    return 1;
}
</pre>

Under normal circumstances the parent creates a child and invokes the <tt>doWork()</tt> subroutine.  This subroutine does some work and returns the number of widgets it created.  If the child receives a signal while building widgets, the handler logs and sets a flag.  The main loop checks for this and halts work, returning if a signal has been caught.  Why, you may ask, would a child receive a signal?  Surely <a href="http://www.theregister.co.uk/odds/bofh/">no one</a> will go around kill(1)ing children, right?  I think it's a reasonable assumption.  The real thing I made child signal handlers for is allowing the parent to relay signals, cleanly shutting down the daemon.

<pre class="brush: perl">
# Main class for daemon
package ExampleDaemon::Main;
use Moose;

# Package global so that the signal handlers have access
our @children;

# Explicit constructor in Moose
sub BUILD {
    $SIG{'INT'} = \&cleanupAndShutdown;
    $SIG{'TERM'} = \&cleanupAndShutdown;
    $SIG{'HUP'} = \&restartChildren;
}

sub run {
    my ($self) = @_;

    my $pfm = Parallel::ForkManager->new($self->numChildren);
    while (1) {
        my $pid = $pfm->start;

        if ($pid != 0) {
            # Parent process
            push @children, $pid;

            # Start children judiciously
            sleep 1;
            next;
        }

        # Child process; do some work
        $self->startWorker();

        # Worker finished, clean up the $pfm instance
        $pfm->finish();
    }

    # Parent waits here for children to run
    $pfm->wait_all_children();

    return $widgetsMade;
}

sub startWorker {
    my ($self) = @_;
 
    my $worker = ExampleDaemon::Worker->new();
    return $worker->doWork();
}

# Send TERM to children when we get INT or TERM
sub cleanupAndShutdown {
    my ($sigName) = @_;

    kill 15, @children;

    exit;    
}

# Kill the children, which will respawn, and re-read the logging config file
sub restartChildren {
    my ($sigName) = @_;

    kill 15, @children;
    @children = [];

    my $loggingConfigFile = '/etc/daemonLogging.conf';
    Log::Log4perl->init($loggingConfigFile);

    return 1;
}
</pre>

The parent process utilizes <a href="http://search.cpan.org/perldoc/Parallel::ForkManager">Parallel::ForkManager</a> to spin off children.  We store the PIDs of these children in a package global, <tt>@children</tt>, because the signal handler gets no state information (i.e. it isn't given <tt>$self</tt>), so it can only access things that are global to the package.  As before, we register signal handlers, which do whatever is required.  In the case of <tt>cleanupAndShutdown()</tt> (which handles INT and TERM), we kill all of the children and then <tt>exit</tt> in the parent process.  If the parent process receives a HUP instead, we kill the children and then simply <tt>return</tt> from the signal handler, which returns to the main loop of the parent which will respawn the children. 
