#!/usr/bin/env python3.5
#
# DO NOT USE! NOT DONE!
# Need to move only listdir directories from homedir/file
# As for now, I move the whole .config directory.

import os
import shutil

homedir = '/home/lemones/'
backup_dest = '/home/lemones/Backup/'
from_dir = '/home/lemones/Gits/dotfiles/'
exclude = ['LICENSE',
           'README.md',
           '.git',
           'symlink-install.py',
           'install.py',
           'install.sh'
           ]
listdir = os.listdir(from_dir)

# Create backup directory if it doesn't exist.
if not os.path.exists(backup_dest):
    print ("Backup directory is missing. Creating: {}".format(
        backup_dest))
    os.makedirs(backup_dest)
else:
    print ("Backup directory exists. Re-creating.")
    shutil.rmtree(backup_dest)
    os.makedirs(backup_dest)

# Remove excluded files from list
for ex in exclude:
    listdir.remove(ex)

# Check homedir if files from listdir exist and do a backup.
for file in listdir:
    # If file exist. Move to backup directory
    if os.path.isfile(homedir + file):
        try:
            # Move file to backup_dest
            shutil.move('{}{}'.format(homedir, file), backup_dest + file)
            print (" [BACKUP] File: {}".format(file))
        except shutil.Error as e:
            print ('Error moving file: {}'.format(e))
    # Same with folders
    if os.path.isdir(homedir + file):
        try:
            shutil.move('{}{}'.format(homedir, file), backup_dest + file)
            print (" [BACKUP] Folder: {}{}".format(homedir, file))
        except shutil.Error as e:
            print (" Error moving folder: {}".format(e))

    os.symlink(from_dir + file, homedir + file)
    print ("  [SYMLINK] {}".format(file))

print ("Done!")
