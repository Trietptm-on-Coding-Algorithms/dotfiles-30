#!/bin/python
import urllib2 as urllib
import json
import os
import subprocess
import sys
from subprocess import call

# Easier to clear terminal window
def cls():
    os.system('cls' if os.name=='nt' else 'clear')


cls()

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
# Helpers
# ynuserid = jbrapi['userId']
# Following only needed if live
if jbrapi['errorCode'] == 0:
    ynuser = jbrapi['username']
    ynuserid = jbrapi['userId']
    ynhost = jbrapi['media']['host']
    ynapp = jbrapi['media']['app']
    ynstream = jbrapi['media']['stream']
    yndatecreated = jbrapi['dateCreated']
    itslive = "True"
else:
#    print ("[EE] Failed to retrive Broadcast-API of " + inputuser)
    ynuserid = jbrapi['userId']
    itslive = "False"

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




cls()
"""
Menu

"""

ans = True

def menu():
    cls()
    a = raw_input("""
    Aviable options for """ + inputuser + """ (""" + itslive + """)
        1. List archived broadcasts
        2. Record live session
        3. Quit
====================================================


    """)

    if a == "1": # List archive with videoAvailable = True
        for xnr in range ( 0, archnr):
            available = jynarchapi['posts'][xnr]['media']['broadcast']['videoAvailable']
            if available == True:
                print xnr, " | ", \
                jynarchapi['posts'][xnr]['media']['broadcast']['dateAired'], \
                " | ", jynarchapi['posts'][xnr]['media']['broadcast']['tags']
        # Get input. Return if SyntaxError for trigger-enter-go-back
        try:
            inputarch = int(input("\n\n  >>   "))
        except SyntaxError:
            return menu()
        else:

            # Helpers for the archive download
            archbroadcastid = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastId']
            archtimeago = jynarchapi['posts'][inputarch]['media']['broadcast']['timeAgo']
            archdateaired = jynarchapi['posts'][inputarch]['media']['broadcast']['dateAired']
            archavibale = jynarchapi['posts'][inputarch]['media']['broadcast']['videoAvailable']
            archhls = jynarchapi['posts'][inputarch]['media']['broadcast']['hls']
            archlength = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastLengthMin']
            archid = jynarchapi['posts'][inputarch]['media']['broadcast']['broadcastId']
            archcreated = jynarchapi['posts'][inputarch]['dateCreated']

            # print archbroadcastid, archtimeago, archhls
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

            return menu()

    elif a == "2":
        if itslive is "True":

            createdir = '~/back/video/' + ynuser + "/"
            if not os.path.exists(createdir):
                os.makedirs(createdir)

            if not os.path.isfile(createdir + ynuser + "-" + yndatecreated + ".flv"):
                print "No file. Recording!"
                startrecord = subprocess.Popen(["urxvtc --hold -e rtmpdump -r rtmp://" + ynhost + ynapp + "/" + ynstream + " -o " + createdir + \
                ynuser + "-" + yndatecreated + ".flv"], shell=True)
                return menu()
            else:
                print "File! Not recording"
                askow = raw_input("File exists, overwrite? Yes\No ")
                if askow == "Yes":
                    startrecord = subprocess.Popen(["urxvtc --hold -e rtmpdump -r rtmp://" + ynhost + ynapp + "/" + ynstream + " -o " + ynuser + \
                    yndatecreated + ".flv"], shell=True)
                    return menu()
                return menu()
        else:
            return menu()


    elif a == "3":
        print ("Quiting")
        exit()

# Call menu
menu()





"""
media >
host/app/stream
  rtmp://start.oddcast.xc.advection.net/oddcast/ec2-54-194-244-250.eu-west-1.compute.amazonaws.com/Stream-93361630

    ynuser = jbrapi['username']
    ynuserid = jbrapi['userId']
    ynhost = jbrapi['media']['host']
    ynapp = jbrapi['media']['app']
    ynstream = jbrapi['media']['stream']


"""
