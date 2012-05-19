--- 
layout: post
comments: true
title: Creating an OpenVPN Server on Ubuntu
mt_id: 264
date: 2010-12-01 17:16:01 -08:00
---
 I have long used an [SSH tunnel](http://embraceubuntu.com/2006/12/08/ssh-tunnel-socks-proxy-forwarding-secure-browsing/) (put simply: `ssh -D 8000 server` + [FoxyProxy](http://getfoxyproxy.org/)) to browse the web [securely](http://codebutler.com/firesheep) from unencrypted wireless access points and other [potentially hostile networks](http://www.wallofsheep.com/).  While this is secure, it isn't all that convenient and [has inherent problems](http://sites.inka.de/bigred/devel/tcp-tcp.html).  What I really want is a proper VPN, that will seamlessly encapsulate **all** traffic from my local machine and pass it through the tunnel to be emitted by the server.  [OpenVPN](http://openvpn.net/) is one of [those things](http://www.postfix.org/) that has a reputation for being difficult to setup,so I long avoided it.  Once I decided to actually make with the go, it turned out to not be terribly difficult, though I did have to do a bit of searching to get exactly what I wanted.

There are a number of [good](http://www.linux.com/learn/tutorials/304510:weekend-project-setting-up-a-vpn-on-your-linux-router-or-gateway) [tutorials](http://www.itsatechworld.com/2006/01/29/how-to-configure-openvpn/) for setting up OpenVPN, and the following instructions will mostly mirror those.  First, install the requisite packages:

<pre class="brush: bash">
caligula:~$ sudo aptitude install openvpn
</pre>

Then, setup a place to generate the requisite keys:

<pre class="brush: bash">
    caligula:~$ mkdir tmp/vpn && cd vpn
    caligula:~/tmp/vpn$ cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0/* .
</pre>

At this point, many tutorials (the above mentioned ones included) say that you should run `./init-config`, which doesn't exist in recent version OpenVPN.  With the scripts for generating keys in place, open up `vars` and edit the stuff at the bottom, which should be pretty straightforward:

<pre class="brush: bash">
    export KEY_COUNTRY="US"
    export KEY_PROVINCE="NY"
    export KEY_CITY="Rochester"
    export KEY_ORG="Dinomite-Net"
    export KEY_EMAIL="drew@dinomite.net"
</pre>

The `vars` file just sets up a bunch of environment variables, so you'll want to source it and then build the certificate authority:

<pre class="brush: bash">
    caligula:~/tmp/vpn$ source vars
    caligula:~/tmp/vpn$ ./clean-all
    caligula:~/tmp/vpn$ ./build-ca
</pre>

Building the certificate authority involves a few questions, for most of which the defaults defined from `vars` are all you need.  Next, build the keys for the server and client (I name my computers [after Roman emperors](http://dinomite.net/2009/caligulas-giant-ship/)):

<pre class="brush: bash">
    caligula:~/tmp/vpn$ ./build-key-server caligula
    caligula:~/tmp/vpn$ ./build-key vespasian
    caligula:~/tmp/vpn$ ./build-dh
</pre>

With all that done, you can copy the appropriate key files over to the client, in my case `vespasian`.  Since I already had [tunnelblick](http://code.google.com/p/tunnelblick/) on that machine, I put the files directly where they needed to go:

<pre class="brush: bash">
caligula:~/tmp/vpn$ cd keys
caligula:~/tmp/vpn/keys$ scp vespasian.crt vespasian.key \
    ca.crt vespasian:~/Library/Application Support/Tunnelblick/Configurations/
</pre>

Two steps left.  First, make the client configuration file.  For tunnelblick, this goes in the same directory as above, and you can name it whatever you want:

<pre class="brush: bash">
    vespasian:~$ cat Library/Application Support/Tunnelblick/Configurations/client.conf
    client
    dev tun
    proto udp
    remote caligula.dinomite.net 1194
    resolv-retry infinite
    nobind
    persist-key
    persist-tun
    ca ca.crt
    cert vespasian.crt
    key vespasian.key
    comp-lzo
    verb 3
</pre>

There are plenty of other sites that will explain what all of those options mean, so I won't go over it here.  The important things to change from above are the `remote` and the names for the `cert` and `key`.  Now on to the server config and the files that it needs:
    
<pre class="brush: bash">
    caligula:~/tmp/vpn/keys$ cp dh1024.pem caligula.key caligula.crt /etc/openvpn/
    caligula:~/tmp/vpn/keys$ cat /etc/openvpn/server.conf
    server 10.7.7.0 255.255.255.0
    push "redirect-gateway"

    dev tun0
    proto udp
    keepalive 10 120
    comp-lzo
    dh /etc/openvpn/dh1024.pem
    ca /etc/openvpn/ca.crt
    cert /etc/openvpn/caligula.dinomite.net.crt
    key /etc/openvpn/caligula.dinomite.net.key

    status /var/log/openvpn-status.log
    verb 3
</pre>

The secret sauce in that config is `push "redirect-gateway"` which is what tells the client to route all of its traffic through the tunnel to the server.  To make this work, the server needs to be set up to do [NAT](http://en.wikipedia.org/wiki/Network_address_translation):

<pre class="brush: bash">
    caligula:~/tmp/vpn/keys$ echo "1" > /proc/sys/net/ipv4/ip_forward
    caligula:~/tmp/vpn/keys$ iptables -t nat -A POSTROUTING -s 10.7.7.0/24 -o eth0 -j MASQUERADE
</pre>

That's all there is to it!  Just restart the server (`sudo /etc/init.d/openvpn restart`), connect, and all your traffic is now safely encrypted to the server. 
