# -*- coding:utf-8 -*-

import socket
import time
sock = socket.socket()

sock.connect(('127.0.0.1',8888))

time.sleep(2)
sock.send(b'hhhh')
send_data = input('>>>')
sock.send(send_data.encode())
time.sleep(5)
