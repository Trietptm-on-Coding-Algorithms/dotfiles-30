#!/bin/env python3.5

import urllib.request as urllib
import json


class startchan(object):

    def __init__(self):
        self.thread_id = "6578423"
        self.threads_url = "http://a.4cdn.org/wg/threads.json"
        self.thread_id_url = "http://a.4cdn.org/wg/thread/" \
            + self.thread_id + ".json"

    def get_thread_ids(self):
        print("Saving thread id's to list")
        s = urllib.urlopen(self.threads_url)
        r = s.read()
        s.close()
        j = json.loads(r.decode('utf-8'))
        xnb = 0
        for i in j:
            print("test {}".format(j['no']))


startchan().get_thread_ids()
