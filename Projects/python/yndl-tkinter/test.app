#!/usr/bin/python

from PIL import Image, ImageTk
from cStringIO import StringIO
import urllib import urlopen
from Tkinter import *
from PIL import Image
import Tkinter as tk

root = Tk()
url = "http://www.wired.com/wp-content/uploads/2015/03/10182025tonedfull-660x441.jpg"
u = urlopen(url)
raw_data = u.read()
u.close()

image_file = Image.open(StringIO(raw_data))
photo_image = ImageTk.PhotoImage(image_file)
label = tk.Label(image=photo_image)
label.pack()
root.mainloop()
