#!/bin/python3

from shutil import make_archive, copytree
import shutil
import datetime
import os
import sys

now = datetime.datetime.now()
datenow = (now.strftime("%Y-%m%d-%H-%M-%S"))
working_dir = '/home/lemones/'
destination_dir = '/home/lemones/.temp/' + datenow

resource_file = open('filestobackup')
resource_fold = open('folderstobackup')

resource_read_files = resource_file.readlines()
resource_read_folds = resource_fold.readlines()

''' Folders '''
for line in resource_read_folds:
    line_strip = line.strip()
    file = os.path.join(working_dir, line.strip())
    copytree(file, destination_dir + '/' + line.strip())
'''
    try:
        copytree(file, destination_dir + '/' + line.strip())
    except IOError:
        print ("Error", sys.exc_info()[0])
    else:
        print ('Folder: ', line_strip)
'''


''' Files '''
for line in resource_read_files:
    line_strip = line.strip()
    file = os.path.join(working_dir, line.strip())
    shutil.copy2(file, destination_dir)
'''
    try:
        shutil.copy2(file, destination_dir)
    except IOError:
        print ("Error Files")
    else:
        print ('File: ', line)
'''
