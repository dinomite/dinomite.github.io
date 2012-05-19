--- 
layout: post
comments: true
title: mdadm Isn't Someone You Want to Hear From
mt_id: 165
date: 2007-11-28 09:08:56 -08:00
---
A server of mine, Claudius, sent me a very polite, though unpleasant email early this morning
<pre>
from:		mdadm monitoring <root@dinomite.net>
to:			root@dinomite.net,
date:		Nov 28, 2007 6:25 AM
subject:	Fail event on /dev/md0:claudius

This is an automatically generated mail message from mdadm
running on claudius

A Fail event had been detected on md device /dev/md0.

Faithfully yours, etc.
</pre>

Ugh; that means one of the drives in RAID set on Claudius has failed.  I only run [RAID0](http://en.wikipedia.org/wiki/RAID#Standard_levels) on the machine, so data loss isn't any issue unless the second drive gives up, too.  I try not to actively administer machines; I just get them setup in a solid state and then make use of them, no reason to waste time fiddling around.  I hadn't done anything of note with the machine in question in some time, so I wasn't even sure what the drive setup was, though `df` clears that up:

<pre>
claudius:/home/dinomite/public_html# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/md0              5.5G  1.7G  3.6G  32% /
varrun                506M  116K  506M   1% /var/run
varlock               506M  4.0K  506M   1% /var/lock
udev                  506M   88K  506M   1% /dev
devshm                506M     0  506M   0% /dev/shm
/dev/md1               68G   13G   54G  19% /home
/dev/hdd1              19G   13G  5.1G  72% /backup
tmpfs                 506M   18M  488M   4% /lib/modules/2.6.15-29-k7/volatile
</pre>

So, md0 is the root (/) filesystem and Claudius also has a second RAID device, md1, which supports the `/home` filesystem.  I used `mdadm --detail` to get some more information about `md0`:

<pre>
claudius:/home/dinomite/public_html# mdadm --detail /dev/md0
/dev/md0:
        Version : 00.90.03
  Creation Time : Sat Aug 26 11:50:00 2006
     Raid Level : raid1
     Array Size : 5855552 (5.58 GiB 6.00 GB)
    Device Size : 5855552 (5.58 GiB 6.00 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Wed Nov 28 11:35:45 2007
          State : clean, degraded
 Active Devices : 1
Working Devices : 1
 Failed Devices : 1
  Spare Devices : 0

           UUID : 16c480c4:6bbc2b89:189b2529:3af755b2
         Events : 0.16665869

    Number   Major   Minor   RaidDevice State
       0       0        0        -      removed
       1       3       65        1      active sync   /dev/hdb1

       2       3        1        -      faulty   /dev/hda1
</pre>

So it thinks there's a problem with `/dev/hda1`, one of the two partitions that makes up this RAID device.  At this point, I recall that Claudius has three disks in it, a 20G (/backup) and two 80G, the latter two support both of the systems RAID devices, `md0` and `md1`.  The notice that mdadm sent me was only concerning `md0` which is odd, because `md1` spans both of those physical disks as well:

<pre>
claudius:/home/dinomite/public_html# mdadm --detail /dev/md1
/dev/md1:
        Version : 00.90.03
  Creation Time : Sat Aug 26 11:50:07 2006
     Raid Level : raid1
     Array Size : 71778304 (68.45 GiB 73.50 GB)
    Device Size : 71778304 (68.45 GiB 73.50 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 1
    Persistence : Superblock is persistent

    Update Time : Wed Nov 28 11:38:25 2007
          State : clean
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

           UUID : 41d43030:23b3662d:c1c06634:4132ebc3
         Events : 0.2117050

    Number   Major   Minor   RaidDevice State
       0       3        2        0      active sync   /dev/hda2
       1       3       66        1      active sync   /dev/hdb2
</pre>

and it doesn't show any problems.  What does this mean?  Well, I'm not exactly sure, but it does mean that the disk `/dev/hda` which holds the failed partition (`hda1`) of `md0` isn't completely bad; it's still spinning away and working.  That probably means that the filesystem on `hda1` somehow got muddled up or that there's a physical error on the portion of the disk support `hda1`.  Either way, the first step for me is to simly rebuild the array as it was before.  This is as simple as removing the faulty partition and adding it back to the array:

<pre>
claudius:/home/dinomite/public_html# mdadm /dev/md0 -r /dev/hda1
mdadm: hot removed /dev/hda1
claudius:/home/dinomite/public_html# mdadm /dev/md0 -a /dev/hda1
mdadm: hot added /dev/hda1
</pre>

The RAID device will automatically begin rebuilding this partition and keep you informed of the status.

<pre>
claudius:/home/dinomite/public_html# mdadm --detail /dev/md0
/dev/md0:
        Version : 00.90.03
  Creation Time : Sat Aug 26 11:50:00 2006
     Raid Level : raid1
     Array Size : 5855552 (5.58 GiB 6.00 GB)
    Device Size : 5855552 (5.58 GiB 6.00 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Wed Nov 28 12:03:36 2007
          State : clean, degraded, recovering
 Active Devices : 1
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 1

 Rebuild Status : 3% complete

           UUID : 16c480c4:6bbc2b89:189b2529:3af755b2
         Events : 0.16666531

    Number   Major   Minor   RaidDevice State
       0       0        0        -      removed
       1       3       65        1      active sync   /dev/hdb1

       2       3        1        0      spare rebuilding   /dev/hda1
</pre>

Though a failed RAID device isn't the best way to start your morning, managing them in Linux is a fairly straightforward operation.  If the device actually had been bad, I would simply have to shut down the machine, replace the bad drive, partition it like the other one (`fdisk -l` helps) and then add it to the array as shown above.  In most cases, this wouldn't be much harder than what I had to do, though my case the server is a few hundred miles away, so that'd be quite a hike.
