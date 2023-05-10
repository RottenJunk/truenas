# TrueNAS Related


# Backup-VMs.sh
Here is the script I use. Modify as needed for your environment. Use at your own risk! There is no warranty/guarantee/promise/anything related to anyone using this. Just because it works for me does not mean it will work for you. You have been warned. :)

This script does assume all volumes to be backed up are in a single SOURCE path, and all backups go to a single DEST path (both defined in the Variables section of the script).

Then, have a Cloud Sync task set up to sync (backup) your DEST path (as you set in the script).

The script also purges older backups, defined by the KEEP variable setting (which is in days).

Then, set up a Cloud Sync task to sync (backup) your DEST path (as you set in the script).s go to a single DEST path (both defined in the Variables section of the script).
