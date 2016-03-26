#!/bin/python

import json
import urllib2 as urllib


sockuapi = urllib.urlopen("http://www.younow.com/php/api/broadcast/info/user=Purple.orb")
a = sockuapi.read()
sockuapi.close()
b = json.loads(a)
print(json.dumps(b, indent=2))

# inputuser = "Babybear16"

# http://www.younow.com/php/api/broadcast/info/user=
