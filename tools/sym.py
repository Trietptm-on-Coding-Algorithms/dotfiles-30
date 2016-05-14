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
        self.excludes_file = 'exclude.files'
        self.includes = os.listdir(self.from_dir)
        self.ask = ''
        self.datenow = datetime.datetime.now()
        self.currentdate = "{}-{}-{}-{}-{}".format(
            self.datenow.year, self.datenow.day, self.datenow.month,
            self.datenow.hour, self.datenow.minute)

    def go(self):
        print("Excluding unwanted objects...")
        self.exclude_obj()
        print("Creating Backup...")
        self.create_backup()
        print("Symlinking objects...")
        self.ask = input('Remove existing files for symlink? (Y/n)\n: ')
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
        ''' if object exists, delete and create symlink '''
        if (os.path.isfile(self.homedir + name) or
           os.path.isdir(self.homedir + name)):
            self.del_existing_obj(name)
        else:
            ''' else just create the symlink '''
            self.create_symlink(name)

    def del_existing_obj(self, name):

        if self.ask == 'Y':
            print(' Removing: {}{}'.format(self.homedir, name))
            self.create_symlink(name)
        else:
            print(' Keeping {}{}'.format(self.homedir, name))

    def create_backup(self):

        if not os.path.exists(self.backup_dest):

            print('Backup directory missing...\nCreating {}...'.format(
                self.backup_dest))

            try:
                os.makedirs(self.backup_dest)

            except OSError as err:
                print(" Got an error.\n{0}".format(err))
        os.makedirs(self.backup_dest + self.currentdate)

        for line in self.includes:
            if os.path.isdir(self.homedir + line):
                try:
                    shutil.copytree(self.homedir +
                                    line,
                                    self.backup_dest +
                                    self.currentdate + '/' +
                                    line, symlinks=False)
                except OSError as err:
                    print(" [copytree] Got an error.\n{0}".format(err))
            elif os.path.isfile(self.homedir + line):
                try:
                    shutil.copy2(self.homedir +
                                 line,
                                 self.backup_dest +
                                 self.currentdate + '/' +
                                 line)
                except OSError as err:
                    print(" [copy2] Got an error.\n{0}".format(err))
            else:
                pass

    def create_symlink(self, name):
        print(" Symlink: {} > {}".format(name, self.homedir))

start = symlink_all('start')
start.go()
