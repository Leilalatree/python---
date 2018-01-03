# -*- coding:utf-8 -*-

import select
import socket
import time

#需要监控，是否可以读的列表
#需要监控，是否可以写的列表
#需要监控，是否有错的列表

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,1)  #可以解决端口占用的问题
server.bind(('127.0.0.1',8000))
server.listen(5)

is_readable = [server,]
while True:
    readable, _, _ = select.select(is_readable,[],[])

    for sock in readable:
        if sock is server:#有新连接
            conn, addr = sock.accept()  #此时，accept() 会不会阻塞，此时服务端
            is_readable.append(conn)
        else:  #客户端发消息来了
            sock.recv(1024)   #会不会阻塞？  不会，事先确定有消息来了



    # input('>>>')
    # conn,addr = server.accept() #如果没有人请求，我就会阻塞，但是如果已经有人请求了，那我就不阻塞

