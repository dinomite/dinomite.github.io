--- 
layout: post
comments: true
title: Connecting to Oracle Without a Password on Windows
mt_id: 166
date: 2007-12-04 07:56:27 -08:00
---
If you have forgotten, were never given or otherwise don't have the password to an Oracle database, never fear, there is a method to accessing the database.  From the local machine you must be a user in the group "ora_dba".  Run "sqlplus" (the command line version) with the option "/nolog", which tells SQL*Plus not to login.  At the "SQL>" prompt, type "connect / as sysdba" which ought to log you in.  At that point, you can change the password for any account (`sys` would be a good one to change, since apparently you don't know it) using the command `alter user <username> identified by "<password>";`.  Make sure to `commit;` after doing that.
