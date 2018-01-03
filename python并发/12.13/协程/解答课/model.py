# -*- coding:utf-8 -*-
import random
import time
def consumer():
    while True:
        #yield拿到send进来的东西
        #send拿到yield进来的东西
        item = yield
        print('消费了一个数:',item)
        time.sleep(1)
        pass

def producer():
    global c
    while True:
        item = random.randint(0,99)
        print('生产了一个数:',item)
        c.send(item)

        # send（item）
        #yield
        pass

c = consumer()
next(c)
producer()

'''
或者  消费者  item = next(p)
生产者   yield item   

我们一个线程不停地在各个执行单元中切换

# 协程的模型 
  做完一个事，立刻马上切换到另一个事做，我们可以自由地控制我们的切换

# 多线程的模型
  也是同样的 同一时间只能执行一个，我一会做这个，一会做那个
  
背景  计算密集型

'''