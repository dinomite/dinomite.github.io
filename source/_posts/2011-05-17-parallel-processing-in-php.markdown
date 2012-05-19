--- 
layout: post
comments: true
title: Parallel Processing in PHP
mt_id: 267
date: 2011-05-17 08:30:00 -07:00
---
Though not a first choice for long-running processes, many web shops end up writing daemons or batch processing scripts in PHP.  As business grows, the need to process records more quickly to deal with traffic becomes an issue.  Often times, the processing is limited by something other than raw processing power--network latency and database query times being the usual slowdowns.  When this is the case, the easiest way to increase throughput is with multiprocessing: multiple children that spread the time waiting so as the fully utilize the processing power available.

To this end, I have created a simple framework for managing child/worker multiprocessing in PHP.  Like other high-level interpreted languages, the most straightforward way to spin things up is using `fork(2)` to create new processes.  While not as Hardcore and Awesome as the lightweight threads that other languages provide, OS-level process creation isn't a huge hindrance if you code for it: make the child processes long running so as to mitigate the startup cost.  

The framework is part of the [Team Lazer Beez Open Source](https://launchpad.net/genius) project--you can find it in the [utility](http://bazaar.launchpad.net/~genius.com/genius/trunk/view/head:/php/Utility/) package.  The entire thing is simple enough to fit in a single class, [gosUtility_Parallel](http://bazaar.launchpad.net/~genius.com/genius/trunk/view/head:/php/Utility/lib/gosUtility/Parallel.cls.php), the basics of which can be credited to [chaos'](http://stackoverflow.com/users/47529/chaos) [post on Stack Overflow](http://stackoverflow.com/questions/752214/php-daemon-worker-environment/752255#752255).

Using the library is simple--extend gosUtility_Parallel and override the `doWorkChildImpl()` method:
<pre class="brush: php">
// Include the Genius config file
require_once dirname(dirname(__FILE__)) .'/Core/testConfig.inc.php';

class Minimal extends gosUtility_Parallel {
    protected function doWorkChildImpl() {
        gosUtility_Parallel::$logger->debug($this->workerID . " started");
        usleep(2000000);

        gosUtility_Parallel::$logger->debug($this->workerID . " doing work");
        usleep(2000000);

        gosUtility_Parallel::$logger->info($this->workerID . " finishing");
        exit(1);
        return;
    }
}
</pre>

This class creates simple workers that print a couple of debug messages with some sleeping in between, and then announce that they are done working.  Now you can instantiate the class with a single argument: the number of children to run.  gosUtility_Parallel will take care of all the details.

<pre class="bursh: php">
// Make with the go
$minimal = new Minimal(2);
$minimal->go();
</pre>

If children `exit` with a non-zero status, the parent will spin up a replacement.  The parent will continue to run until all children have exited normally, or it gets `INT` (say, ctrl+c) or `TERM` (the default signal sent by kill(1)), in which case it will pass that signal on to the children, ensure they shut down, and then end itself.  gosUtility_Parallel provides ample logging information; running the above produces the following output:

<pre>
INFO - Started worker 0 (pid 42093)
DEBUG - 0 started
INFO - Started worker 1 (pid 42094)
DEBUG - 1 started
DEBUG - 0 doing work
DEBUG - Checking worker 0 (pid 42093)
DEBUG - Checking worker 1 (pid 42094)
DEBUG - 1 doing work
INFO - 0 finishing
INFO - 1 finishing
DEBUG - Checking worker 0 (pid 42093)
INFO - Worker 0 (pid 42093) exited normally
DEBUG - Checking worker 1 (pid 42094)
INFO - Worker 1 (pid 42094) exited normally
</pre>

gosUtility_Parallel provides a number of overrideable methods whose names explain their purpose: `parentSetup()`, `parentCleanup()`, and `childCleanup()`.  Children can also get their `$workerID` and the `$maxWorkers` number making processing based upon modular division trivial.  The [example parallel class](http://bazaar.launchpad.net/~genius.com/genius/trunk/view/head:/php/Utility/parallel.php) in the distribution demonstrates some of these features:

<pre class="brush: php">
// Include the Genius config file
require_once dirname(dirname(__FILE__)) .'/Core/testConfig.inc.php';

class Par extends gosUtility_Parallel {
    public function __construct($maxWorkers) {
        parent::__construct($maxWorkers);

        // Redefine the logger
        gosUtility_Parallel::$logger = Log5PHP_Manager::getLogger('gosParallel.Par');
    }

    protected function doWorkChildImpl() {
        gosUtility_Parallel::$logger->debug($this->workerID . " started");

        // Run until told not to
        global $run;
        while ($run) {
            gosUtility_Parallel::$logger->debug($this->workerID . " doing work.");
            usleep(2000000);
            if ($this->workerID == 0 && rand(0,10) == 7) {
                gosUtility_Parallel::$logger->info($this->workerID . " returning");
                return;
            }
        }
    }

    protected function parentCleanup() {
        gosUtility_Parallel::$logger->debug("Parent cleaning up");
    }

    protected function childCleanup() {
        gosUtility_Parallel::$logger->debug($this->workerID . " cleaning up");
    }
}
</pre>

The example above runs out-of-the-box (provided your PHP was built with <a href="http://us.php.net/pcntl">`--enable-pcntl`</a>, so I encourage you to [download the source](https://launchpad.net/genius) and take it for a test drive.

Incidently, if you're in the Perl world you can just use <a href="http://search.cpan.org/dist/Parallel-ForkManager/lib/Parallel/ForkManager.pm">Parallel::ForkManager</a> and be on your way. 
