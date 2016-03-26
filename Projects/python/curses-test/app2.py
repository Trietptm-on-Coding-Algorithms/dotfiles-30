#!/usr/bin/env python3

#import urllib2 as urllib
import urllib.request as urllib
import codecs
import json
import os
import subprocess
import sys
from subprocess import call

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class startWindow:

    def __init__(self):

        builder = Gtk.Builder()
        builder.add_from_file("design3.glade")
        self.window = builder.get_object("window1")
        # References
        self.label = builder.get_object("label1")
        self.label2 = builder.get_object("label2")
        self.userentry = builder.get_object("entry1")

        # Connect signals to self
        builder.connect_signals(self)

    ############
    # Handlers #
    ############

    def onDeleteWindow(self, *args):
        Gtk.main_quit(*args)

    def doRefresh(self, widget):
        self.label.set_text("Loaded user: %s" % self.userentry.get_text())
        print ("Loaded user: %s" % self.userentry.get_text())
        loadedUser = "%s" % self.userentry.get_text()
        #print (tmpprint.listArchive)
        #self.label2.set_text("%s" % ynConnect(loadedUser).printusers)
        # print (ynConnect(loadedUser).printusers)

    def doSave(self, button):
        print("Saving")

    def doExit(self, button):
        print("Quiting...")
        Gtk.main_quit('Exit')



class ynConnect:


    def __init__(self, user):

        self.user = user
        ynuserid = ''
        self.archnr = ''
        self.getuserid = ''
        self.loadUserAPI()
        self.listArchive(self.archnr)
        #printusers = ''
#        self.loadBroadcastAPI()
#        self.loadArchiveAPI()

    def loadUser(self):
        print ("Name : ", self.user)

    def loadUserAPI(self):
        sockuapi = urllib.urlopen("http://www.younow.com/php/api/younow/user/")
        ynuapi = sockuapi.read()
        sockuapi.close()
        juapi = json.loads(ynuapi.decode('utf-8'))
        # Helper
        if juapi['errorCode'] is not '0':
            usersessionid = juapi['session']
        else:
            print ("[EE] Failed to retrive User-API")
            #sys.exit(1)

#    def loadBroadcastAPI(self):
        print (self.user)
        sock = urllib.urlopen("http://www.younow.com/php/api/broadcast/info/user=" + self.user)
        ynapibr = sock.read()
        sock.close()
        jbrapi = json.loads(ynapibr.decode('utf-8'))
        # Helpers
        # ynuserid = jbrapi['userId']
        # Following only needed if live
        if jbrapi['errorCode'] == 0:
            ynuser = jbrapi['username']
            ynuserid = jbrapi['userId']
            self.getuserid = jbrapi['userId']
            ynhost = jbrapi['media']['host']
            ynapp = jbrapi['media']['app']
            ynstream = jbrapi['media']['stream']
            yndatecreated = jbrapi['dateCreated']
            itslive = "True"
        else:
            print ("[EE] Failed to retrive Broadcast-API of " + self.user)
            ynuserid = jbrapi['userId']
            itslive = "False"


    def listArchive(self, archnr):
#    def loadArchiveAPI(self):
        sock = urllib.urlopen("http://www.younow.com/php/api/post/getBroadcasts/channelId=" + str(self.getuserid))
        ynarapi = sock.read()
        sock.close()
        jynarchapi = json.loads(ynarapi.decode('utf-8'))

        if jynarchapi['errorCode'] == 0:
            if jynarchapi['posts'] == "null":
                print ("[EE] " + self.user + "Nothing in archive")
            else:
                archnr = len(jynarchapi['posts']) # Count posts in archive
                self.archnr = len(jynarchapi['posts']) # Count posts in archive
        else:
            print ("[EE] Failed to retrive Archive-API of: " + self.user)
            #sys.exit(1)

        xnr = 0
        for xnr in range ( 0, archnr):
            available = jynarchapi['posts'][xnr]['media']['broadcast']['videoAvailable']
            if available == True:
#                print (xnr, " | ", \
#                jynarchapi['posts'][xnr]['media']['broadcast']['dateAired'], \
#                " | ", jynarchapi['posts'][xnr]['media']['broadcast']['tags'])

                printusers = (xnr, " | ", \
                jynarchapi['posts'][xnr]['media']['broadcast']['dateAired'], \
                " | ", jynarchapi['posts'][xnr]['media']['broadcast']['tags'])




if __name__ == "__main__":
    editor = startWindow()
    editor.window.show_all()
    Gtk.main()
