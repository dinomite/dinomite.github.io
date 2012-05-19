---
layout: post
comments: true
title: "Nmap Tutorial"
date: 2006-01-13 23:18
comments: true
categories: [Networking]
---
<p>Port scanning is a method of finding listening services (open ports) on a
computer.  In laymen's terms, port scanning is akin to checking if doors and
windows are unlocked on a house.  It is useful for locating vulnerable computers
on a network for security auditing purposes as well as attacking them.

<img src='http://dinomite.net/wp-content/images/TCP.bmp' alt='TCP diagram' align='right' />

</p><p>To understand port scanning, you first must know how the TCP protocol works.
TCP is called a connection oriented protocol, as it initiates a connection
between two machines when they want to transfer data.  This is compared to
connectionless protocols, like UDP, which don't initiate connections or gurantee
delivery of data.  To begin a connection, the client sends a packet to the
server with the SYN flag set which tells the server it wants to initiate a
connection and where to start numbering packets.  The server responds with a
packet that has the SYN and ACK flags set, acknowleding the connection.  The
client then completes the setup of the connection by responding with a packet
having the ACK flag set.  After this point, the client and server can
communicate as a stream, sending all the data they wish.  When they have
completed sending all of their data, the connection is terminated when one of
them sends a FIN/ACK packet and the other responds with an ACK.

</p><p>Now that we've covered the basics of TCP, we can move on to Nmap itself.
Nmap is a featureful port scanner supporting all of the popular scanning
mechanisms including TCP connect(), SYN, FIN, Xmas and null scans.  In addition,
Nmap supports ping sweeping, operating system detection, decoy and zombie hosts.

</p><p>The TCP connect() scan is the simplest and Nmap's default.  All it does is
check each port on the target machine by initiating a connection using the
operating system's connect() call.  Being that it only utilizes standard system
calls available to normal users, this type of scan does not require root or
administrator priveleges.  However, the connect() is easily detected because it
is fairly noisy; the port scanner must fully initiate a connection with each
port that it finds open.

</p><p>A SYN scan, also knowsn as a half-open scan, only sends the first packet of a
connection initiate, the SYN packet.  It never attempts to complete the
connection, rather it simply listens for the response of the target.  If it
replies with a SYN/ACK packet, the port is in listening mode.  If it responds
with a RST/ACK, the port is closed.  The SYN scan is considered to be a stealth
scan, as the connection is never completed and therefore never registered with
any listening services.  Most modern firewalls and monitoring systems can detect
SYN scans, however.

</p><p>FIN, Xmas tree and null scans all work in the same manner.  The port scanner
sends a packet to the target machine out of the blue, which doesn't make sense
out of the context of a connection.  RFC 793 stipulates that closed ports should
respond to this probe with a RST whilst open ports will ignore it.  Unfortunately, this doesn't
work against Microsoft operating systems because they don't comply to the standard,
ignoring such packets instead.

</p><p>Because of their nature, attempting to connect to numerous ports on a
computer, port scans can usually be detected quite easily.  Most port scanners
will scan in a random order, so that their activities aren't blatantly obvious,
 but the speed and manner with which they scan is usually still easily detected.
 Many firewalls have options to detect and slow or prevent port scans.  Linux's
 current kernel-based firewall, Netfilter (IPChains) has a number of rules that
 can do this, such as rules to limit port connections over a time period.
 There are also more advanced programs, like <a href="http://www.snort.org">snort</a> and <a href="http://www.cipherdyne.com/psad">Port Scan Attack Detector (PSAD)</a>
 which can monitor for port scans, notify you of them and take action (blocking
 the scanning hosts) to prevent such scans.</p>
