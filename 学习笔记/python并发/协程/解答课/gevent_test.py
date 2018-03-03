# -*- coding:utf-8 -*-

# gevent 是什么 协程库用来做协程编程
#核心的对象就是协程，围绕协程提供了些可以用的函数
#就是在解决网络IO  底层封装了IO多路复用 再外面实现协程
import gevent
import time
from gevent.queue import Queue
import random

queue = Queue(3)

def producer(name):
    while True:
        item = random.randint(0,99)
        print('生产者',name,item)
        queue.put(item)   #队列满，阻塞
        #gevent.sleep(5)  #模拟IO阻塞

def consumer(name):
    while True:
        print(name,'尝试拿')
        item = queue.get()   #队列空
        print(name,'消费',item)


coro1 = gevent.spawn(producer,'p')
coro2 = gevent.spawn(consumer,'c1')
coro3 = gevent.spawn(consumer,'c2')
coro4 = gevent.spawn(consumer,'c3')

gevent.joinall([coro1,coro2,coro3,coro4])