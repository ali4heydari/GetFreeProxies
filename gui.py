import json
import urllib.request
import webbrowser
from tkinter import *

import pyqrcode

link = ""


def get_proxy():
    f = urllib.request.urlopen("https://raw.githubusercontent.com/hookzof/socks5_list/master/tg/mtproto.json")
    j = json.loads(f.read())
    j.sort(key=lambda x: x['ping'])
    j = j[0]
    return f'https://t.me/proxy?server={j["host"]}&port={j["port"]}&secret={j["secret"]}'


window = Tk()
window.title("New Proxy Getter")


def generate():
    global qr, photo, link
    link = get_proxy()
    qr = pyqrcode.create(get_proxy())
    photo = BitmapImage(data=qr.xbm(scale=8))
    try:
        showcode()
    except:
        pass


def connect():
    webbrowser.open(link)


button = Button(window, text="Get Proxy", width=15, command=generate)
button.grid(row=0, column=3, sticky=N + S + W + E)

buttonc = Button(window, text="Connect", width=15, command=connect)
buttonc.grid(row=1, column=3, sticky=N + S + W + E)
buttonc["state"] = "disabled"

imageLabel = Label(window)
imageLabel.grid(row=2, column=1, sticky=N + S + W + E)


def showcode():
    imageLabel.config(image=photo)
    buttonc["state"] = "normal"


Rows = 3
Columns = 3

for row in range(Rows + 1):
    window.grid_rowconfigure(row, weight=1)

for col in range(Columns + 1):
    window.grid_columnconfigure(col, weight=1)

window.mainloop()
