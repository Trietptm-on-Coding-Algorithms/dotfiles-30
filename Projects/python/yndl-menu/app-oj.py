#!/bin/python
import urllib2
import json

class getYouNowAPI:
    def __init__(self, url):
        self.url = url

    def data(self, getData):
        response = urllib2.urlopen(self.url)
        data = json.loads(response.read())
        print data[getData]


getUser = getYouNowAPI('http://www.younow.com/php/api/younow/user')
connectUser = getUser.data('session', 'userId')
connectUser = getUser.data('userId')

# http://www.younow.com/php/api/younow/user/
