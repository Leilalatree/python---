# -*- coding:utf-8 -*-
import socket

sock = socket.socket()

sock.connect(('127.0.0.1',8888))

data = input('>>>')

sock.send(data.encode())
print(sock.recv())