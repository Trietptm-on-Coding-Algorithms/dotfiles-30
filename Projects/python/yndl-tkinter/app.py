#!/usr/bin/env python3

import urllib.request as urllib
import codecs
import json
import os
import subprocess
import sys
# For calling outside applications
from subprocess import call

from tkinter import *

# For images
# For decoding URL-dumps to Data-objects: import base64
# [XX] Instead use BytesIO from io
from io import BytesIO as StringIO
from PIL import Image, ImageTk



class loadGUI:
    def __init__(self, master):
        self.master = master
        master.title("YN Browser")

        # Row 0
        # Row 1
        self.user_picture = Label(master, background='black', width='5', height='2')
        self.user_picture.grid(row=1,column=0, sticky=W)

        self.user_entry = Entry(master)
        self.user_entry.insert(0, "Username...")
        self.user_entry.grid(row=1,column=1, sticky=W)

        self.refresh_button = Button(master, text="Refresh", command=self.refresh)
        self.refresh_button.grid(row=1,column=2, sticky=E)

        # Row 2
        self.list_trending = Listbox(master, height=20, width=15)
        self.list_trending.bind('<<ListboxSelect>>', self.onselect_trending)
        self.list_trending.grid(row=2,column=0, sticky=W)

        self.list_archive = Listbox(master, height=20, width=25)
        self.list_archive.bind('<<ListboxSelect>>', self.load_from_trend)
        self.list_archive.grid(row=2,column=1, sticky=E)

        # Row 3

        self.download_button = Button(master, text="Download", command=self.download_archive)
        self.download_button.grid(row=3, column=0, sticky=W)

        self.add_user_button = Button(master, text="Add User", command=self.load_from_trend)
        self.add_user_button.grid(row=3, column=1, sticky=W)

        self.back_button = Button(master, text="Back", command=self.get_back)
        self.back_button.grid(row=3, column=2, sticky=W)

        self.exit_button = Button(master, text="Exit", command=master.quit)
        self.exit_button.grid(row=3,column=3, sticky=E)

        # Row 4
        self.userinfo_label = Label(master, text="No user loaded...")
        self.userinfo_label.grid(row=4,column=0, sticky=W)



        ynuserid = ''
        self.archnr = ''
        self.getuserid = ''
        self.user = ''
        self.userimage = ''
        self.usersession = ''
        self.used_click = False
        self.itslive = False
        self.setlocale = 'en'
        self.set_trending_nr = '5'

        # List Trending at start
        self.listTrendingTags()

    def onselect_trending(self, selected):
        print ("Test")

    def refresh(self):

        print ("[refresh] - Activated")

        self.list_archive.delete(0, END)

        self.user = self.user_entry.get()
        self.loadUserAPI(self.user_entry.get())
        self.listArchive(self.archnr)
        if self.itslive is True:
            self.userinfo_label['text'] = "User: " + self.user_entry.get()
            u = urllib.urlopen(self.userimage)
            getu = u.read()
            image_file = Image.open(StringIO(getu))
            photo_image = ImageTk.PhotoImage(image_file)
            print (" Thumb: {}".format(self.userimage))
#            self.user_picture['image'] = photo_image
            self.user_picture.image = photo_image
        else:
            self.userinfo_label['text'] = self.user_entry.get() + " is offline!"

        # Print select from list_archive
        # print (self.list_archive.get(ACTIVE))
        print (" User loaded: ", self.user_entry.get())

        print ("[refresh] - Complete")


    def get_back(self):
        self.listTrendingTags()

    def load_from_trend(self, selected):
        self.user = (self.list_archive.get(self.list_archive.curselection()[0]))
        # self.user = self.list_archive.get(ACTIVE)
        self.user_entry.delete(0, END)
        self.user_entry.insert(0, self.user)
        cs = self.list_archive.curselection()
        self.list_archive.delete(0, cs[0])
        self.list_archive.delete(0, END)

        self.loadUserAPI(self.user)
        self.listArchive(self.archnr)


    def download_archive(self):
        print ("test")


    def loadUserAPI(self, user):
        print ("[loadUserAPI] - Activated")
        sockuapi = urllib.urlopen("http://www.younow.com/php/api/younow/user/")
        ynuapi = sockuapi.read()
        sockuapi.close()
        userAPI = json.loads(ynuapi.decode('utf-8'))
        # Helper
        if userAPI['errorCode'] is not '0':
            usersessionid = userAPI['session']
            self.usersession = userAPI['session']
            print (" Got ID: {}".format(usersessionid))
        else:
            print (" [EE] Failed to retrive User-API")

        print (" User Loaded: {}".format(self.user))
        sock = urllib.urlopen("http://www.younow.com/php/api/broadcast/info/user=" + self.user)
        ynapibr = sock.read()
        sock.close()
        jbrapi = json.loads(ynapibr.decode('utf-8'))
        # Helpers
        # Check if live
        if jbrapi['errorCode'] == 0:
            ynuser = jbrapi['username']
            ynuserid = jbrapi['userId']
            self.getuserid = jbrapi['userId']
            ynhost = jbrapi['media']['host']
            ynapp = jbrapi['media']['app']
            ynstream = jbrapi['media']['stream']
            yndatecreated = jbrapi['dateCreated']
            self.userimage = jbrapi['awsUrl']
            self.itslive = True
        else:
            print (" [EE] Failed to retrive Broadcast-API of " + self.user)
            ynuserid = jbrapi['userId']
            self.itslive = False
        print ("[loadUserAPI] - Complete")

    def listArchive(self, archnr):
        sock = urllib.urlopen("http://www.younow.com/php/api/post/getBroadcasts/channelId=" + str(self.getuserid))
        ynarapi = sock.read()
        sock.close()
        archiveAPI = json.loads(ynarapi.decode('utf-8'))

        if archiveAPI['errorCode'] == 0:
            if archiveAPI['posts'] == "null":
                print (" [EE] " + self.user + "Nothing in archive")
            else:
                archnr = len(archiveAPI['posts']) # Count posts in archive
                self.archnr = len(archiveAPI['posts']) # Count posts in archive
        else:
            print (" [EE] Failed to retrive Archive-API of: " + self.user)

        xnr = 0
        for xnr in range ( 0, self.archnr):
            available = archiveAPI['posts'][xnr]['media']['broadcast']['videoAvailable']
            if available == True:
                helpList = xnr, " | ", \
                archiveAPI['posts'][xnr]['media']['broadcast']['dateAired'], \
                " | ", archiveAPI['posts'][xnr]['media']['broadcast']['tags']

                self.list_archive.insert(END, str(helpList[2]), str(helpList[4]))
                if xnr == 9:
                    # Exit loop when number 9 is reached to prevent flood
                    break

    def listTrendingTags(self):

        print ("[listTrendingTags] - Activated")

        sock = urllib.urlopen("https://cdn2.younow.com/php/api/younow/dashboard/locale=" + self.setlocale + \
        "/trending=" + self.set_trending_nr)
        trendapi = sock.read()
        trendingAPI = json.loads(trendapi.decode('utf-8'))
        self.list_trending.delete(0, END)
        self.list_archive.delete(0, END)

        width = 5
        listnr = len(trendingAPI['trending_tags'])
        dnr = 0

        for dnr in range ( 0, listnr):

            stra = trendingAPI['trending_tags'][dnr]['tag']
            strb = trendingAPI['trending_users'][dnr]['profile']
            print(" Tag: {} User: {}".format(stra.ljust(20), strb))

            self.list_trending.insert(END, trendingAPI['trending_tags'][dnr]['tag'])
            self.list_archive.insert(END, trendingAPI['trending_users'][dnr]['profile'])

        print ("[listTrendingTags] - Complete")


root = Tk()
startGUI = loadGUI(root)
root.mainloop()


# locale = de, en
# https://cdn2.younow.com/php/api/younow/dashboard/locale=en/trending=5
