# -*- coding:utf-8 -*-
import socket
import selectors
import random

sel = selectors.DefaultSelector()

def read(sock):
    print('recv阻塞')
    data = sock.recv(1024)
    sel.unregister(sock)
    if not data:
        sock.close()
        return
    print(data)

def write(sock):
    sock.send(str(random.randint(0,99).encode('utf-8')))
    sel.unregister(sock)
    sel.register(sock,selectors.EVENT_READ,read)

for i in range(1000):
    client = socket.socket()
    sel.register(client,selectors.EVENT_WRITE, write)
    client.connect(('localhost',8888  ))

while True:
    all_event = sel.select()
    for event, _ in all_event:
        sock = event.fileobj
        callback = event.data
        callback(sock)
