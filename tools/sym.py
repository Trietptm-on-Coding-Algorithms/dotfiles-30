#!/usr/bin/env python3.5

import os
import shutil
import datetime


class symlink_all:

    def __init__(self, master):

        self.master = master
        self.homedir = os.path.expanduser('~') + '/'
        self.backup_dest = self.homedir + 'Backup/'
        self.from_dir = self.homedir + '.dotfiles/'
        self.get_objects = os.listdir(self.from_dir)
        self.excludes_file = 'exclude'
        self.includes = os.listdir(self.from_dir)
        self.roundup = []
        self.ask = ''
        self.datenow = datetime.datetime.now()
        self.currentdate = "{}-{}-{}-{}-{}".format(
            self.datenow.year, self.datenow.day, self.datenow.month,
            self.datenow.hour, self.datenow.minute)

    def go(self):
        print("Including objects...")
        self.include_obj()
        print("Excluding objects...")
        self.exclude_obj()
        print("Creating Backup")
        self.create_backup()
        print("Check if objects exists...")
        self.ask = input('Overwrite existing files? ')
        for ex in self.includes:
            self.if_object_excists(ex)

    def include_obj(self):
        pass

    def exclude_obj(self):
        o = open(self.excludes_file)
        for line in o:
            try:
                self.includes.remove(line.rstrip())
            except:
                pass
        o.close()

    def if_object_excists(self, name):
        if (os.path.isfile(self.homedir + name) or
           os.path.isdir(self.homedir + name)):
            # print("[*] {}".format(name))
            self.del_existing_obj(name)
        else:
            pass

    def del_existing_obj(self, name):
        # ask = input('Replace {}{}?'.format(self.homedir, name))
        if self.ask == 'Y':
            print('Replacing {}{}'.format(self.homedir, name))
        else:
            print('Keeping {}{}'.format(self.homedir, name))

    def create_backup(self):
        if not os.path.exists(self.backup_dest):
            print('Backup directory missing...\nCreating {}...'.format(
                self.backup_dest))
            try:
                os.makedirs(self.backup_dest)
            except:
                print("Error creating directory.")
        os.makedirs(self.backup_dest + self.currentdate)
        for line in self.includes:
            if os.path.isdir(self.homedir + line):
                try:
                    shutil.copytree(self.homedir + line,
                                    self.backup_dest + line, symlinks=False)
                except:
                    print("error")
            else:
                try:
                    shutil.copy2(self.homedir + line, self.backup_dest + line)
                except:
                    print("error")

start = symlink_all('start')
start.go()
