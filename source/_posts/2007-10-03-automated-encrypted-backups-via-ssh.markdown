--- 
layout: post
comments: true
title: Automated Encrypted Backups via SSH
mt_id: 149
date: 2007-10-03 13:19:20 -07:00
---
This is a hack of the script `rsnaptar` included with the rsnapshot distribution.  In short, it takes a  few rsnapshot directories, runs them through `tar`, `gzip` and `gpg` finally depositing the results on another machine.  I wrote this so that I could grab the backups from a server at work and routinely toss them onto a DVD that I take home with me.  It's a bad idea to be walking around with all of the company's source code, hence the GPG.  The magic all happens on one line which runs `tar`, piping the output to `ssh` which runs `gzip` reading from stdin on the remote machine then on to `gpg` dumping its output wherever you want.

<pre>
#!/bin/sh
SNAPSHOT_DIR="/data/backups/tarback"
DEST_LOCATION="/home/stephensdg/Desktop/backups"

USER=stephensdg
HOST=10.32.193.100
ID_FILE=/home/stephensdg/.ssh/id_dsa
GPG_HOME=/home/stephensdg/.gnupg

LS="/bin/ls"
TAR="/bin/tar"
CAT="/bin/cat"
CHMOD="/bin/chmod"
CHOWN="/bin/chown"
MKDIR="/bin/mkdir"
SSH="/usr/bin/ssh"

cd ${SNAPSHOT_DIR}
for BACKUP_POINT in `${LS} ${SNAPSHOT_DIR}`; do
        ${TAR} -chf - ${BACKUP_POINT}/ | ${SSH} -i ${ID_FILE} ${USER}@${HOST} \
        "gzip - | gpg --homedir ${GPG_HOME} -e -r Drew > \
        ${DEST_LOCATION}/${BACKUP_POINT}.tar.gz.gpg"
done
</pre>
