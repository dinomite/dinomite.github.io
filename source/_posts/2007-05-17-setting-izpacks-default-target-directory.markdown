--- 
layout: post
comments: true
title: Setting IzPack's Default Target Directory
mt_id: 111
date: 2007-05-17 09:44:11 -07:00
---
[IzPack](http://www.izpack.org) is a great installer written in Java and configured with XML files, though the documentation can be a little bit lacking.  This OK because the variables are all named well so one can easily look to an existing installer (such as that for IzPack itself or 7-zip) and copy needed bits of code.  One thing that I found elusive was how to set the default install directory to something other than "C:\Program Files\&lt;product name&gt;".  The &lt;info&gt; element provides an &lt;appsubpath&gt; element that allows you to specify something other than &lt;product name&gt;, but you're still limited to something within the default Windows installation directory.  Alas, mailing lists to the rescue!  [This post](https://lists.berlios.de/pipermail/izpack-users/2006-November/002928.html) describes declaring a resource in the install.xml and after a bit of fiddling I came up with the following.

First, create a file TargetDir.txt with nothing more than the path you want to install at, for me that file simply contained "C:\foo".  Next, point to the resource in the install.xml:

<code><pre>
&lt;resources&gt;
    &lt;!-- Set the default installation directory shown in the TargetPanel --&gt;
    &lt;res id="TargetPanel.dir" src="TargetDir.txt" /&gt;
&lt;/resources&gt;
</pre></code>

Rebuild the installer and you're set.
