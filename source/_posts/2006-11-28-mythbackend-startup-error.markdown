--- 
layout: post
comments: true
title: mythbackend startup error
mt_id: 78
date: 2006-11-28 14:50:48 -08:00
---
My MythTV installation hasn't been working for a couple of weeks and I hadn't gotten around to fixing it until today; shows you how much TV matters to me when I'm busy.  It was a really easy error to fix - simply a crashed table which was quick to diagnose and fix even though I hadn't ever encountered anything of the sort before.  For Google-searchers, the error from mythbackend was as follows:

<code><pre>
&lt;snip&gt;
2006-11-28 17:38:35.805 DB Error (UpdateMatches):
Query was:
DELETE FROM program WHERE manualid = -1 OR  (manualid <> 0 AND -1 = -1)
Driver error was [2/145]:
QMYSQL3: Unable to execute query
Database error was:
Table './mythconverg/program' is marked as crashed and should be repaired
&lt;/snip&gt;
</pre></code>

To fix it, I simply had to login to the database, 'use mythconverg;', and issue the command 'repair table program;'.  As noted below, make sure you see those semicolons.  Simple.
