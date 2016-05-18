import socket


def one():
    return("test")


def check_if_up(ip, port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        res = s.connect_ex((ip, port))
        if res == 0:
            return(True)
        else:
            return(False)
        s.close
    except OSError as e:
        return("Error: %s" % e)


def if_down(port):
    pass


def if_up(port):
    pass


def download_file(ip, port, file, dest):
    pass


def upload_file(ip, port, file, dest):
    pass


def read_logs(ip, port, logname):
    pass
