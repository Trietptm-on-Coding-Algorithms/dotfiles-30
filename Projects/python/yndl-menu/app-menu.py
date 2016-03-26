#!/usr/bin/env python
from os import system
import curses
import urllib2 as urllib
import json
import os
import subprocess
import sys
from subprocess import call



# Ask for username
inputuser = raw_input("YN User: ")


"""
Socket connections to save needed json data
Get data from User-API, Broadcast-API, Archive-API
Call for system exit(1) if retrived errorCode => 1
* User-API is needed for rtmpdump when asking for session
* Broadcast-API is needed for Live
* Archive-API is needed to browse the archives
"""
# User-API
sockuapi = urllib.urlopen("http://www.younow.com/php/api/younow/user/")
ynuapi = sockuapi.read()
sockuapi.close()
juapi = json.loads(ynuapi)
# Helper
if juapi['errorCode'] is not '0': # If errorCode is not 0
    usersessionid = juapi['session']
else:
    print ("[EE] Failed to retrive User-API")
    sys.exit(1)


# Broadcast-API (if online and broadcasting(?))
sock = urllib.urlopen("http://www.younow.com/php/api/broadcast/info/user=" + inputuser)
ynapibr = sock.read()
sock.close()
jbrapi = json.loads(ynapibr)
ynuserid = jbrapi['userId']


"""
# Helpers
if jbrapi['errorCode'] == 0:
    ynuser = jbrapi['username']
    ynuserid = jbrapi['userId']
    ynhost = jbrapi['media']['host']
    ynapp = jbrapi['media']['app']
    ynstream = jbrapi['media']['stream']
else:
    print ("[EE] Failed to retrive Broadcast-API of " + inputuser)
    sys.exit(1)
"""

# Archive-API
sock = urllib.urlopen("http://www.younow.com/php/api/post/getBroadcasts/channelId=" + str(ynuserid))
ynarapi = sock.read()
sock.close()
jynarchapi = json.loads(ynarapi)
# Helpers
if jynarchapi['errorCode'] == 0:
    if jynarchapi['posts'] == "null":
        print "[EE] " + inputuser + "Nothing in archive"
    else:
        archnr = len(jynarchapi['posts']) # Count posts in archive
else:
    print ("[EE] Failed to retrive Archive-API of: " + inputuser)
    sys.exit(1)




def get_param(prompt_string):
     screen.clear()
     screen.border(0)
     screen.addstr(2, 2, prompt_string)
     screen.refresh()
     input = screen.getstr(10, 10, 60)
     return input

def execute_cmd(cmd_string):
     system("clear")
     a = system(cmd_string)
     print ""
     if a == 0:
          print "Command executed correctly"
     else:
          print "Command terminated with error"
     raw_input("Press enter")
     print ""

x = 0

while x != ord('4'):
     screen = curses.initscr()

     screen.clear()
     screen.border(0)
     screen.addstr(2, 2, "Please enter a number...")
     screen.addstr(4, 4, "1 - List archive")
     screen.addstr(5, 4, "2 - Restart Apache")
     screen.addstr(6, 4, "3 - Show disk space")
     screen.addstr(7, 4, "4 - Exit")
     screen.refresh()

     x = screen.getch()

     if x == ord('1'):

        for xnr in range ( 0, archnr):
            available = jynarchapi['posts'][xnr]['media']['broadcast']['videoAvailable']
            if available == True:
                print xnr, " | ", \
                jynarchapi['posts'][xnr]['media']['broadcast']['dateAired'], \
                " | ", jynarchapi['posts'][xnr]['media']['broadcast']['tags']
        inputarch = int(input("\n\n  Nr to download -> "))

        # Helpers for the archive download
        archbroadcastid = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastId']
        archtimeago = jynarchapi['posts'][inputarch]['media']['broadcast']['timeAgo']
        archdateaired = jynarchapi['posts'][inputarch]['media']['broadcast']['dateAired']
        archavibale = jynarchapi['posts'][inputarch]['media']['broadcast']['videoAvailable']
        archhls = jynarchapi['posts'][inputarch]['media']['broadcast']['hls']
        archlength = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastLengthMin']
        archid = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastId']
        archcreated = jynarchapi['posts'][inputarch]['dateCreated']

        print archbroadcastid, archtimeago, archhls
        # Convert archbroadcastid to string
        stringbroadcastid = str(archbroadcastid)

        # Get requried adresses for broadcast
        sock = urllib.urlopen("https://cdn2.younow.com/php/api/broadcast/videoPath/broadcastId=" + stringbroadcastid)
        ynarchgeturl = sock.read()
        sock.close()
        jbrid = json.loads(ynarchgeturl)
        if jbrid['errorCode'] == 0:
            # Helpers
            stream =  jbrid['stream']
            server = jbrid['server']
            profile = jbrid['profileUrlString']
        else:
            sys.exit(1)

        # Directory and Record helper
        createdir = './video/' + profile + "/"

        # Create directories if not exists
        if not os.path.exists(createdir):
            os.makedirs(createdir)

        # Check if file exists, if not, startrecord
        if not os.path.isfile(createdir + profile + "-" + archcreated + ".mp4"):
            print "No file. Recording!"
            startrecord = subprocess.Popen(["urxvtc --hold -e rtmpdump -r " + server + " -y " + stream + "?sessionId=" + usersessionid + \
                               " -p https://www.younow.com/" + profile + "/channel" + " -o \"" + createdir + \
                               profile + "-" + archcreated + ".mp4\" --live"], shell=True)

        else:
            # Ask to overwrite existing file
            askow = raw_input("File exists, overwrite? Yes\No ")
            if askow == "Yes":
                startrecord = subprocess.Popen(["urxvtc --hold -e rtmpdump -r " + server + " -y " + stream + "?sessionId=" + usersessionid + \
                                   " -p https://www.younow.com/" + profile + "/channel" + " -o \"" + createdir + \
                                   profile + "-" + archcreated + ".mp4\" --live"], shell=True)

        curses.endwin()

     if x == ord('2'):
          curses.endwin()
          execute_cmd("apachectl restart")

     if x == ord('3'):
          curses.endwin()
          execute_cmd("df -h")

curses.endwin()
