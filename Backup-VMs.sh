#!/usr/bin/bash
#
# BACKUP ZFS VOLUMES (ZVOL) TO A COMPRESSED FILE
#
#
# VARIABLES TO CUSTOMIZE
SOURCE="BRAIN404/VirtualMachines"                # THE DATASET TO LOOK AT FOR VOLUMES TO BACKUP
DEST="/mnt/BRAIN404/VirtualMachines-Backups"     # THE FILESYSTEM TO SAVE THE BACKUPS TO
KEEP=7                                           # DAYS TO KEEP BACKUPS BEFORE DELETING THEM
#
#
# LIST ALL VOLUMES UNDER THE SOURCE DATASET
VMZVOLS=$(zfs list -o name,type | grep volume | grep ${SOURCE}/ | tr -s ' ' ' ' | cut -f1 -d' ')
#
#
# CREATE BACKUP(S) OF LAST SNAPSHOT(S)
for i in ${VMZVOLS}
  do
    #
    # FIND THE NAME OF THE LAST SNAPSHOT OF THIS VOLUME
    SNAPSHOT=$(zfs list -t snapshot -o name -s creation -r ${i} | tail -1)
    #
    # RETURN JUST THE SNAPSHOT NAME ITSELF (NOT THE FULL PATH)
    BACKUPNAME=${SNAPSHOT##*/}
    #
    # USE ZFS TO SEND THE SNAPSHOT TO THE DESTINATION AS A FILE, COMPRESSING IT
    zfs send ${SNAPSHOT} | gzip -c > ${DEST}/${BACKUPNAME}.gz
  done
#
#
# FIND OLD BACKUPS TO DELETE BASED ON THE "KEEP" VARIABLE SETTING
TODELETE=$(find ${DEST} -name \*.gz -mtime +${KEEP})
#
# DELETE THE OLD BACKUPS
for i in ${TODELETE}
  do
    rm -f ${i}
  done
