#!/usr/bin/python

import urllib
import json


input = raw_input("URL: ")

response = urllib.urlopen(input)
parsed = json.loads(response.read())
print json.dumps(parsed, indent=4, sort_keys=True)
