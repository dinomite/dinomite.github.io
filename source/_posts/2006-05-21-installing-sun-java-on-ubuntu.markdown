--- 
layout: post
comments: true
title: Installing Sun Java on Ubuntu
mt_id: 68
date: 2006-05-21 17:12:57 -07:00
---
I installed Azureus on my Ubuntu machine recently and found it to absolutely *peg* the CPU when downloading more than a few torrents at once.  I know that Bittorrent is a pretty CPU intensive protocol, but I had been running similar numbers of torrents on the same machine using [bittornado](http://packages.ubuntu.com/breezy/net/bittornado) with much less ado.  By default, Ubuntu installs the [GCJ Java virtual machine](http://packages.ubuntu.com/breezy/interpreters/java-gcj-compat), which is a perfectly serviceable JVM, but I suspected it wasn't as good as Sun's own.  I'll shall not decree that Sun's JVM is better than GCJ, as I didn't actually run any tests, but Azureus runs faster now that I'm using the Sun machine.  Onward.

Overall this is a pretty simple install. First, because of how Sun's JVM is licensed, you need to manually download it from [the Sun site](http://java.sun.com/j2se/1.5.0/download.jsp).  If you plan on compiling Java code, get the Java Development Kit (JDK); if you don't write software, you can just get the Java Runtime Environment (JRE).  Either way, make sure you get the vanilla package, not the RPM (RedHat package).

Once you have that, you need to install `java-package` using apt-get.  You will first need to change two lines in your `/etc/apt/sources.list` file, adding `universe` and `multiverse` as is shown below:

<code>
deb http://us.archive.ubuntu.com/ubuntu/ dapper main restricted <b>universe multiverse</b><br />
deb-src http://us.archive.ubuntu.com/ubuntu/ dapper main restricted <b>universe multiverse</b>
</code>

Open a terminal and type this in, answering "yes" to any questions the program asks:

`sudo apt-get install java-package`

Now, you just need to make a .deb out of Sun's Java package that you grabbed.  In the same terminal, change to the directory where said package resides and run the following, once again choosing happy answers like 'y' and 'yes' when you are presented with quesions:

`chmod +x *.bin; fakeroot make-jpkg *.bin; sudo dpkg -i sun-j2sdk*.deb`

Easy as that.  To make this the default JVM simply run the following command:

`sudo update-java-alternatives --config java`
