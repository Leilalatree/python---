# -*- coding:utf-8 -*-

import gevent
from gevent import monkey
monkey.patch_all()
import socket


def read(conn):
    print('建立连接：',conn)
    while True:
        data = conn.recv(1024)
        if not data:
            conn.close()
            break
        print('client_message:',data)
        gevent.sleep(2)
        conn.send(data)
        print('数据已发送')

def main():
    s = socket.socket()
    s.bind(('127.0.0.1',8888))
    s.listen(5)
    print('监听')
    while True:
        print('accecpt 阻塞')
        conn,addr = s.accept()
        gevent.spawn(read,conn)

if __name__ == '__main__':
    main()