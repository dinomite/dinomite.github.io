---
layout: post
comments: true
title: "Filesystems"
date: 2006-01-13 23:24
comments: true
categories: [Linux]
---
<p>This is the outline to a seminar that I gave at <a href="http://www.csh.rit.edu">CSH</a> on filesystems.  The impetus was simply my lack of knowledge for how filesystems work and the misconceptions (particularly about journaling) that most people have.  Synopsis: use ReiserFS, but don't believe the <a href="http://funroll-loops.org">Gentoo kiddies</a> who say you'll get a massive performance boost; you wont.  ReiserFS is slightly faster than EXT3, a little bit more space efficient and gets beyond the 2GB filesize limit.  I run EXT2 because  it's a touche faster than all the journaling filesystems and I know that my systems aren't going to go down uncleanly.  Most people, however, aren't as meticulous as I am so a Journaling filesystem is a better fit.

   <ol>
    <li dir="ltr" style="text-align:left">&#xA0;<span lang="en-US">Filesystem writes</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Non-journaling (EXT2, FAT)</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Update meta-data (size)</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Update indirect mapping blocks</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Write data</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Journaling modes</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Journal</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Logs data and metadata changes</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Slowest, most secure</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Requires each write to be made twice</span>
	   <ol>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Written to journal</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Then written to disk</span></li>
	   </ol>
	  </li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Log line only deleted once the transaction is done</span></li>
	 </ol>
	</li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Ordered (default for EXT3)</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Only logs changes to metadata</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Writes data updates before metadata is changed</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	If metadata wasn't updated, the change never happened</span></li>
	 </ol>
	</li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Writeback (default for ReiserFS and XFS)</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Only logs changes to metdata</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Uses regular write process</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Causes problems if metadata is written but data isn't</span></li>
	 </ol>
	</li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	EXT2 - non-journaling Linux</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum file size of 2GB</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Supports maximum filesystem size of 4TB</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum file name size of 255 characters</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Supports regular files, directories, devices and symlinks</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Files created within a directory inherit attributes (permission, owner, group)</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Allows user defined block sizes</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Typically 1024, 2048 or 4096 bytes</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Larger blocks speed up I/O; fewer requests issued, less head movement</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Fast symlinks</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Target name stored in inode, not data area</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Max size of link is 60 character</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Superblocks track clean/not clean state of filesystem</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Marked not clean when mounted read/write</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Marked clean on unmount or remounted read only</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Uses mount counter; after X mounts, ignores state and forces fsck</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Includes support for secure deletion; random data written to deleted blocks</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Physical structure - disk divided into number block groups (see Fig. 1)</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Each block group contains redundant filesystem info and data for the block (see Fig. 2, reference 3)</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Super block - total number of blocks in filesystem, check counter, etc.</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Group descriptor - pointers to block bitmap, inode bitmap, and inode table</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Block bitmap - tells which blocks are in use</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Inode bitmap - tells which inodes are in use</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Inode table - each file has an inode; stores file attributes</span>
	   <ol>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Create time (ctime)</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Modify time (mtime)</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Permissions</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Owner</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Type (regular file, directory, device, symlink)</span></li>
	    <li dir="ltr" style="text-align:left"><span lang="en-US">	Where file is stored on disk (see Fig. 3)</span>
	     <ol>
	      <li dir="ltr" style="text-align:left"><span lang="en-US">	Fifteen pointers in each inode</span></li>
	      <li dir="ltr" style="text-align:left"><span lang="en-US">	First thirteen point to actual data blocks</span></li>
	      <li dir="ltr" style="text-align:left"><span lang="en-US">	Fourteenth is indirect pointer - points to a block of pointers</span></li>
	      <li dir="ltr" style="text-align:left"><span lang="en-US">	Fifteenth is doubly indirect - points to a block of pointers which point to blocks of pointers</span></li>
	     </ol>
	    </li>
	   </ol>
	  </li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Data blocks - actual data is here</span></li>
	 </ol>
	</li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	EXT3 - EXT2 with journaling</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Built on top of EXT2; it just adds journaling</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Supports all three modes of journaling</span></li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	ReiserFS - Journaling with good small file performance</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum file size of 8TB</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum filesystem size of 16TB</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Writeback journaling by default; supports ordered and journaled modes</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Metadata organized in B+ trees</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Allocates space for file size exactly, rather than in blocks</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Tail packing</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Small files and less-than-block-sized tails are stored in the B+ tree</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Small file accesses are much faster</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Slightly more efficient use of storage space (~5% comp. to EXT2)</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Overall performance hit (it's always repacking)</span></li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	XFS</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum file size of 9 exabytes</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Maximum filesystem size of 18 exabytes (64-bit mode)</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Metadata organized in B+ trees</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Dynamically allocated inodes</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Block size 512 bytes to 64 kilobytes</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Uses writeback journaling</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Delayed allocation</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Data to be written is cached in RAM</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Space is reserved for data, but location is not</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Once enough data is collected (or an entire file) extents are found and data is written to the disk</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Helps improve allocation of single, contiguous regions for files</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Guranteed rate I/O - allows apps to reserve bandwidth</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Physically arranged into allocation groups (much like EXT2 block groups)</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Each group is mostly independent, managing it's own free space</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Act like transparent sub-filesystems</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Each allocation group has two B+ trees</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	One manages extents (ranges) of free space</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Another to manage inodes</span></li>
	 </ol>
	</li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	UFS - BSD loves thee</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Physical Structure</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Boot block</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Only in first cylinder group</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	8k, contains information for booting from this filesystem</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Blank if said filesystem isn't used for booting</span></li>
	 </ol>
	</li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Superblock</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Size of the filesystem</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Label (name)</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Size in blocks</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Date of last update</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Cylinder group size</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Data blocks per cylinder group</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Summary</span></li>
	 </ol>
	</li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Cylinder group structure</span>
	 <ol>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Copy of the superblock</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Cylinder group header (free/used table, etc.)</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Inodes</span></li>
	  <li dir="ltr" style="text-align:left"><span lang="en-US">	Data blocks</span></li>
	 </ol>
	</li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	ZFS - Hott</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Endian-neutral - magic allows the filesystem to work on SPARC and x86</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Fully 128-bit - More addressable bits than god can count</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Negates the need for external volume managers</span></li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	NTFS - very little known</span></li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	FAT 12/16/32, VFAT - like EXT, but stupid</span></li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	ISO 9660 - CD-ROM Filesystem</span></li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	Comparison</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Small files</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	UFS and EXT2/3 have to allocate at least 1 kilobyte blocks; lost storage efficiency</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	ReiserFS significantly faster</span></li>
       </ol>
      </li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	Tweaks (see reference 4)</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Noatime</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	ReiserFS - notail; swap usage for efficiency</span></li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Tmpfs - /dev/shm</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Filesystem stored in RAM/swap space</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Like ramdisks, but hotter</span></li>
       </ol>
      </li>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	Stack mounting - mount an already-mounted filesystem somewhere else</span></li>
     </ol>
    </li>
    <li dir="ltr" style="text-align:left"><span lang="en-US">	Not covered</span>
     <ol>
      <li dir="ltr" style="text-align:left"><span lang="en-US">	OCFS - Oracle filesystem</span>
       <ol>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Hybrid filesystem/raw device access</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">	Databases do their own caching/read ahead; having an FS cache is bad</span></li>
	<li dir="ltr" style="text-align:left"><span lang="en-US">&#xA0;</span><a href="http://otn.oracle.com/tech/linux/pdf/Linux-FS-Performance-Comparison.pdf"><span lang="en-US">http://otn.oracle.com/tech/linux/pdf/Linux-FS-Performance-Comparison.pdf</span></a></li>
       </ol>
      </li>
     </ol>
    </li>
   </ol>
   </p><p class="ww-preformatted_text" dir="ltr" style="text-align:center;margin-bottom:14pt"><span lang="en-US">&#xA0;</span><span style="font-weight:bold;font-size:14pt;font-family:'Times New Roman'" lang="en-US">Sources</span></p>
   <ol>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-weight:bold;font-size:14pt;font-family:'Times New Roman'" lang="en-US">&#xA0;</span><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">A Non-Technical Look Inside the EXT2 File System.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://www.linuxgazette.com/issue21/gx/ext/layout.gif"><span style="font-family:'Times New Roman'" lang="en-US">http://www.linuxgazette.com/issue21/gx/ext/layout.gif</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	Filesystems HOWTO.</span><a name="_Hlt496279260"><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span></a><a href="http://www.tldp.org/HOWTO/Filesystems-HOWTO.html"><span style="font-family:'Times New Roman'" lang="en-US">http://www.tldp.org/HOWTO/Filesystems-HOWTO.html</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	Analysis of the EXT2fs Structure.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://www.nondot.org/sabre/os/files/FileSystems/ext2fs/"><span style="font-family:'Times New Roman'" lang="en-US">http://www.nondot.org/sabre/os/files/FileSystems/ext2fs/</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	Advanced Filesystem Implementor's Guide.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US"></span><a href="http://www-106.ibm.com/developerworks/library/l-fs.html"><span style="font-family:'Times New Roman'" lang="en-US">http://www-106.ibm.com/developerworks/library/l-fs.html</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	ReiserFS Docs</span><span style="font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://p-nand-q.com/download/rfstool/reiserfs_docs.html"><span style="font-family:'Times New Roman'" lang="en-US">http://p-nand-q.com/download/rfstool/reiserfs_docs.html</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	Scalability in the XFS File System.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://oss.sgi.com/projects/xfs/papers/xfs_usenix/index.html"><span style="font-family:'Times New Roman'" lang="en-US">http://oss.sgi.com/projects/xfs/papers/xfs_usenix/index.html</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">	Getting Started with XFS Filesystems.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://oss.sgi.com/projects/xfs/papers/getting_started_with_xfs.pdf"><span style="font-family:'Times New Roman'" lang="en-US">http://oss.sgi.com/projects/xfs/papers/getting_started_with_xfs.pdf</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US">&#xA0;</span><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">Understanding Filesystem Types.</span><span style="font-family:'Times New Roman'" lang="en-US">	- </span><a href="http://uw713doc.sco.com/en/FS_admin/CONTENTS.html"><span lang="en-US">http://uw713doc.sco.com/en/FS_admin/CONTENTS.html</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US">&#xA0;</span><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">NodeWorks Encyclopedia: UFS.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a href="http://pedia.nodeworks.com/U/UF/UFS/"><span lang="en-US">http://pedia.nodeworks.com/U/UF/UFS/</span></a></li>
    <li class="ww-preformatted_text" dir="ltr" style="text-align:left;margin-bottom:14pt"><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US">&#xA0;</span><span style="font-size:12pt;font-family:'Times New Roman';text-decoration:underline" lang="en-US">Wikipedia.</span><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"> - </span><a name="_Hlt496294964"><span style="font-size:12pt;font-family:'Times New Roman'" lang="en-US"></span></a><a href="http://en.wikipedia.org"><span lang="en-US">http://en.wikipedia.org</span></a></li>
   </ol>
