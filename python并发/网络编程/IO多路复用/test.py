# -*- coding:utf-8 -*-

import socket

sock = socket.socket()
sock.bind(('127.0.0.1',8888))
sock.setblocking(False)
sock.listen(5)

client_list = []

while True:
    try:
        conn,addr = sock.accept()
    except Exception as e:
        pass
    else:
        print('连接建议成功:{}'.format(addr))
        client_list.append((conn,addr))

    for client_socket,client_addr in client_list:
        try:
            data = client_socket.recv(1024)
        except:
            pass
        else:
            if len(data) >0:
                print('客户端{}已经下线'.format(client_addr))
                client_list.remove((client_socket,client_addr))
