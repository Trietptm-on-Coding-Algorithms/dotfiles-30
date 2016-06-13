#!/bin/env python3.5
import functions as func

# Settings
extern_ip = '192.168.1.132'


class external_check(object):

    def __init__(self):
        self.ports = [8090, 80, 21, 9900, 22, 53]
        self.up = []
        self.down = []

    def check_ports(self, ip):
        for i in self.ports:
            check_up = func.check_if_up(ip, i)
            if check_up is True:
                self.up.append(i)
            elif check_up is False:
                self.down.append(i)
            else:
                print("[x] %s" % i)
        for c in self.up:
            print("[+] {}".format(c))
        for c in self.down:
            print("[-] {}".format(c))
        self.up[:] = []
        self.down[:] = []

    def check_port_range(self, ip, from_range, to_range):
        while from_range is not to_range:
            check_up = func.check_if_up(ip, from_range)
            if check_up is True:
                print("[UP] {}".format(from_range))
            if check_up is False:
                print("[DO] {}".format(from_range))
            from_range = from_range + 1


ext = external_check()
print("--- Checking open ports to %s" % extern_ip)
ext.check_ports(extern_ip)

print("--- Checking open ports to lemones.sytes.net")
ext.check_ports('lemones.sytes.net')
