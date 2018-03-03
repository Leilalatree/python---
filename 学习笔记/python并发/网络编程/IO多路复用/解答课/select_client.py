# -*- coding:utf-8 -*-

#爬虫3部分

'''
如果是单线程，按照原来的思路
发一个请求，等待服务器返回，再接着发下一个
连接时间，0.1-0.3   
假如：中国爬美国，那么意味着，一个请求，需要花费0.1-0.3s去等待
阻塞时间 0.2-0.6

一次性把所有的连接都发过去，一次性建立连接
一次性发请求
再 一次性读响应
'''

import socket
import select
import random
'''
客户端

咱们客户端和服务端，通信，一定要一收一发 或 一发一收
'''
is_readable = []
is_writeable = []

for i in range(1000):
    sock = socket.socket()
    sock.connect(('127.0.0.1',8080))
    #有没有可能，连接发过去了，没有办法写：服务器还没有accept
    is_writeable.append(sock)

while True:
    readable, writeable, _ = select.select(is_readable,is_writeable, [])
    #select就是看套接字是不是可以写 可以读
    for sock in writeable:
        sock.send(str(random.randint(0,99)).encode('utf-8'))
        is_readable.append(sock) #只要这个爬虫趴了，就要监控他可不可以读了
        is_writeable.remove(sock)

    for sock in readable:
        print(sock.recv(1024))
        #第一次recv的时候，如果客户端没有发送，那么就阻塞
        #但是 并不是副i房发多少个你就只能收多少次
        #因为，只要你没有send，那么他就认为，一直可以收，（一直没收完）


#先确定这个事能做，再做