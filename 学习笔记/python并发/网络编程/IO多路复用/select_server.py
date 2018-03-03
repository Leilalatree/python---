# -*- coding:utf-8 -*-

#文件描述符
#f = open('xxxx','a')

import socket
import select
import queue

sock = socket.socket()
print('socket创建成功')
sock.bind(('127.0.0.1',8080))

inputs = [sock,]
'''
select 3个参数 监听
1个是接收信息的socket
1个是需要发信息的socket
一个是有错误的socket
返回 一个是收到了消息的socket
返回 写了消息的socket
'''
outputs = [] #等待监听
message_dic = {}
while True:
    print('等待select监听')
    readable,writeable,exceptional = select.select(inputs,[],[])  #三个参数 一个要监听读的list  一个写的list 一个error的list
    for s in readable:
        if s is sock:
            conn,addr = sock.accept()
            print('新的连接建立成功')
            inputs.append(conn)
            message_dic[conn] = queue.Queue()

        else:
            try:
                data = s.recv(1024)
                if len(data) >0:
                    print('client_message:',data)
                    message_dic[s].put(data)
                    outputs.append(s)
                else:
                    raise ConnectionResetError

                # if data:
                #     s.send(data)

            except ConnectionResetError as e:
                if s in outputs:
                    outputs.remove(s)
                print('连接已经断开了')
                inputs.remove(s)
                s.close()

    for w in writeable: #要返回给客户端的连接列表
        client_data = message_dic[w].get()
        print('client_data:',client_data)
        w.send(client_data)
        outputs.remove(w)

    print(readable,writeable)