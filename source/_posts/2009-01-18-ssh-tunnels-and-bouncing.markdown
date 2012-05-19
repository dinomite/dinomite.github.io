--- 
layout: post
comments: true
title: SSH Tunnels and Bouncing
mt_id: 234
date: 2009-01-18 13:51:19 -08:00
---
I have a workstation at my office, drewble, that has a non-routable IP address.  Our network is setup such that, even from the VPN, I can't access that machine directly â€” I have to go through one of our dev servers to get to it.  Obviously, having to hop from one machine to another is a bit cumbersome, but as with many thing, this can be alleviated with some simple Unix magic.  A simple alias in my `.bashrc` makes the bouncing simple:
<pre>
alias drewble="ssh -f -N dev1 -L 9999:drewble.genius.local:22; ssh -D7070 -p 9999 drew@localhost"
</pre>

The first SSH command in this alias goes to the dev server, `dev1`, setting up a forward of the local port `9999` to the SSH port, `22`, on my workstation, `drewble`, found via its zeroconf hostname.  The `-f` options causes SSH to background after logging in and `-N` means that SSH won't run any commands after loggging in; I only care about forwarding ports.  The second command utilizes the tunnel setup on port 9999 to get me to the workstation, setting up a dynamic tunnel on port 7070 which can be used as a SOCKS proxy by things like my web browser.
