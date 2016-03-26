#!/bin/python
import urllib2 as urllib
import json
import os
import subprocess
from subprocess import call

inputuser = raw_input("YN User: ")

# Get session number from user-API
sockuapi = urllib.urlopen("http://www.younow.com/php/api/younow/user/")
ynapi = sockuapi.read()
sockuapi.close()
j = json.loads(ynapi)

usersessionid = j['session']


# Get userinfo
sock = urllib.urlopen("http://www.younow.com/php/api/broadcast/info/user=" + inputuser)
ynapibr = sock.read()
sock.close()

j = json.loads(ynapibr)

# Helpers
ynuser = j['username']
ynuserid = j['userId']
ynhost = j['media']['host']
ynapp = j['media']['app']
ynstream = j['media']['stream']


# Get archive
sock = urllib.urlopen("http://www.younow.com/php/api/post/getBroadcasts/channelId=" + ynuserid)
ynarchive = sock.read()
sock.close()
j = json.loads(ynarchive)



# Count available videos in archive and list them
archnr = len(j['posts'])
for xnr in range ( 0, archnr):
    available = j['posts'][xnr]['media']['broadcast']['videoAvailable']
    if available == True:
        print xnr, " | ", \
            j['posts'][xnr]['media']['broadcast']['dateAired'], \
            " | ", j['posts'][xnr]['media']['broadcast']['tags']

inputarch = int(input("\n\n  Nr to download -> "))

# Helpers
archbroadcastid = j['posts'][inputarch]['media']['broadcast']['broadcastId']
archtimeago = j['posts'][inputarch]['media']['broadcast']['timeAgo']
archdateaired = j['posts'][inputarch]['media']['broadcast']['dateAired']
archavibale = j['posts'][inputarch]['media']['broadcast']['videoAvailable']
archhls = j['posts'][inputarch]['media']['broadcast']['hls']
archlength = j['posts'][inputarch]['media']['broadcast']['broadcastLengthMin']
archid = j['posts'][inputarch]['media']['broadcast']['broadcastId']
archcreated = j['posts'][inputarch]['dateCreated']

# Convert to string
stringbroadcastid = str(archbroadcastid)


# Get requried adresses for broadcast
sock = urllib.urlopen("https://cdn2.younow.com/php/api/broadcast/videoPath/broadcastId=" + stringbroadcastid)
ynarchgeturl = sock.read()
sock.close()
j = json.loads(ynarchgeturl)

# Helpers
stream =  j['stream']
server = j['server']
profile = j['profileUrlString']

# Directory and Record helper
createdir = './video/' + profile + "/"


# Create directories if not exists
if not os.path.exists(createdir):
    os.makedirs(createdir)

# Check if file exists, if not, startrecord
if not os.path.isfile(createdir + profile + "-" + archcreated + ".mp4"):
    print "No file. Recording!"
    startrecord = subprocess.Popen(["rtmpdump -r " + server + " -y " + stream + "?sessionId=" + usersessionid + \
                       " -p https://www.younow.com/" + profile + "/channel" + " -o \"" + createdir + \
                       profile + "-" + archcreated + ".mp4\" --live"], shell=True)

else:
    print "File, ask"
    # Ask to overwrite existing file
    askow = raw_input("File exists, overwrite? Yes\No ")
    if askow == "Yes":
        startrecord = subprocess.Popen(["rtmpdump -r " + server + " -y " + stream + "?sessionId=" + usersessionid + \
                           " -p https://www.younow.com/" + profile + "/channel" + " -o \"" + createdir + \
                           profile + "-" + archcreated + ".mp4\" --live"], shell=True)
