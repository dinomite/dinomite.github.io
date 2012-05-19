--- 
layout: post
comments: true
title: Oracle Repository GPG/PGP Key
mt_id: 122
date: 2007-06-25 12:59:36 -07:00
---
If you're using the Oracle apt repository (`deb http://oss.oracle.com/debian/ unstable main non-free`) with Ubuntu or a recent version of Debian and don't have their GPG key, you'll get the following error when running `apt-get update`:

<code><pre>
W: GPG error: http://oss.oracle.com unstable Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 2E2BCDBCB38A8516
W: You may want to run apt-get update to correct these problems
</pre></code>

To fix this, you need to add Oracle's key to apt, which is straightforward, if you can find the key.  After some searching, I found it at http://oss.oracle.com/el4/RPM-GPG-KEY-oracle; to import this, run the following:

<code><pre>
sudo wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle -O- | sudo apt-key add -
</pre></code>
