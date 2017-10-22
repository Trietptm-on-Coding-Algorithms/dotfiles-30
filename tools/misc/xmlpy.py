#!/bin/python

import json

with open("scan3.json") as f:
    try:
        data = json.load(f)
    except ValueError as e:
        print('invalid json: %s' % e)
        exit()

for ips in data:
    print ("<a href=http://{}:{}>{}</a>\tPort: {}<br/>".format(
        ips['ip'],
        ips['ports'][0]['port'],
        ips['ip'],
        ips['ports'][0]['port']
    ))
