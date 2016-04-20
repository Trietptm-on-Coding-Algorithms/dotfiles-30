#!/usr/bin/env python3.5
#
# DO NOT USE! NOT DONE!
#

import os
import subprocess


class backsyn(object):

    def __init__(self):

        self.homedir = '/home/lemones/'
        self.backup_dest = '/home/lemones/Backup/'
        self.exclude = ['LICENSE',
                        'README.md',
                        '.git',
                        'symlink-install.py'
                        ]
        self.listdir = os.listdir('/home/lemones/Gits/dotfiles')

        self.backup

    def backup(self):

        if not os.path.exists(backup_dest):
            print ("Backup directory is missing. Creating: {}".format(
                self.backup_dest))
            os.makedirs(self.backup_dest)

        for ex in self.exclude:
            self.listdir.remove(ex)

        for file in self.listdir:
            if os.path.isfile(self.homedir + file):
                print (" {}".format(file))

    def symlink(self):
        print ("Test")

b = backsyn()
print (b)
b
