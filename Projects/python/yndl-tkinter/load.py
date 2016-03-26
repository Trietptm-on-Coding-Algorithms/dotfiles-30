#!/usr/bin/env python3
import urllib.request as urllib


class younow:

    def __init__(self, master):

        self.master = master
        self.trending_api = ''

    def myuser():

        print ("me")

    def list_trending():

        sock = urllib.urlopen("https://cdn2.younow.com/php/api/younow/dashboard/locale=" + loadGUI.self.setlocale + \
        "/trending=" + loadGUI.self.set_trending_nr)
        trendapi = sock.read()
        self.trending_api = json.loads(trendapi.decode('utf-8'))

        listnr = len(trending_api['trending_tags'])
        dnr = 0

        for dnr in range ( 0, listnr):
            loadGUI.list_trending.insert(END, trending_api['trending_tags'][dnr]['tag'])
            loadGUI.list_archive.insert(END, trending_api['trending_users'][dnr]['username'])
