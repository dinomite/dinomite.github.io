--- 
layout: post
comments: true
title: Linux Filesystem Internals
mt_id: 188
date: 2008-02-15 15:18:37 -08:00
---
Someone asked me questions about filesystems recently and, though I used to have a good handle on them, my knowledge has waned over the years.  I figured writing about filesystem internals was a good way to brush up on that knowledge.

This information applies generally to [UFS](http://en.wikipedia.org/wiki/Unix_File_System), FFS, [ext2](http://en.wikipedia.org/wiki/Ext2)/[3](http://en.wikipedia.org/wiki/Ext3) and XFS.  [ReiserFS](http://en.wikipedia.org/wiki/ReiserFS) and [HFS](http://en.wikipedia.org/wiki/Hierarchical_File_System)([+](http://en.wikipedia.org/wiki/HFS_Plus)) employ B-trees for organization of file metadata rather than inode lists, so they are somewhat different.  [ZFS](http://en.wikipedia.org/wiki/ZFS) is the tits and all of its shenanigans are handled differently.

At a low level, Unix filesystems are made up of three main pieces on the disk: a superblock, inodes and data blocks.  The superblock contains information about the filesystem: a magic number to identify the type, the size of the filesystem, free data blocks and other gross information.  After the superblock comes a list of inodes, each of which contains metadata about a file including the permissions, the number of links to the file, the file type (symlink, directory, etc.) and the datablocks that hold the actual file data.   Note the conspicuous lack of a filename in the inode; more on this later. The balance of the space on a partition is made up of those data blocks which hold the actual file data.

As mentioned previously, inodes only store metadata; the actual data is stored in one or more data blocks, the inode merely keeps a list of the blocks that contain the data for the file.  In ext2/3, each inode has 15 blocks that can each refer to a single data block, each of which is usually 1 kilobyte meaning that the maximum filesize on ext2 is 15 kilobytes...but that's certainly not true.  The 15 data-referencing blocks are actually allocated more intelligently than that.  The first 12 (0..11) are direct blocks, pointing to the first 12 blocks (kilobytes) of a file.  The 12th block is the indirect block; instead of pointing to data blocks that contain data, it points to a data block that contains a list of up to 2060 addresses of blocks that contain data.  Since a maximum filesize of (2060+12) 2072 kilobytes isn't sufficient for most peoples needs, the 13th block is doubly-indirect and the 14th is triply-indirect.  With all that indirection, the maximum filesize on ext2/3 is about 35 gigabytes, which ought to be enough for anyone.

So, when you want to read a file, the operating system first checks the metadata in the inode to ensure you have permission to access said file.  Assuming you do, data is pulled from the data blocks listed in the inode, with appropriate indirection depending upon the size of the file.

I mentioned previously that filenames are not part of the inode, which seems odd as the filename seems to be a type of file metadata.  The rub is that in POSIX systems a file can have multiple names; my home directory can be referred to as `/home/dinomite`, `/home/dinomite/.`, `/home/dinomite/bin/..` or a number of other names.  How is this handled and where are filenames actually put?  In directories.  A directory boils down to nothing more than a list of names and their associated inode numbers, which we refer to has a link, giving name to the system call `unlink` which most people refer to as delete.  When you refer to a file by name, the operating system starts at the root node (`/`), which is always inode number 2.  Beginning with the root directory listing, it matches filenames to inode numbers, cascading this lookup until it has found the file that you referenced.

The important thing mentioned in the previous paragraph is that filenames in a directory list are links to a file; each of those links is noted in the file's inode as the link count.  Whenever a file is given a name (either by being created or a hard link via `ln`), the link count is incremented; when a link is deleted, the link count is decremented.  When the link count reaches zero, the kernel releases those data block, unless the file is currently open.  In the latter case, the data blocks are freed when the file is closed.  This also lends insight into how undelete programs work and what computer people mean when they say deleting something doesn't actually get rid of the data on the disk.  When you delete a file, more properly known as unlinking it, the only thing that actually goes away is the data in the inode.  Until they are overwritten, the data blocks still contain the data prior to being deleted.  `fsck` works in a similar manner, searching for inodes that have positive link counts, but no references in directories.

Finally, there are symbolic links.  With a symlink, an inode is allocated and has its symlink bit set.  If the file pointed to by the symlink is 60 bytes or less, it is stored directly in the inode.  If its longer, the pointed-to file is stored in data blocks and they are pointed to by the inode in the normal fashion.  Note that symbolic links to not affect an inode's link count, hence broken links.

References
<ul>
<li><a href="http://perl.plover.com/classes/ext2fs/">Internals of the ext2 Filesystem</a> - M. J. Dominus</li>
<li><a href="http://perl.plover.com/classes/files/">What's a file?</a> - M. J. Dominus</li>
<li><a href="http://uranus.chrysocome.net/explore2fs/es2fs.htm">John's ext2 spec</a> - John Newbigin</li>
</ul>
