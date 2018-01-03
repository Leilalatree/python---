# -*- coding:utf-8 -*-
import threading
import random
import time
'''
acquire()
release()
wait()  #首先会施放当前获取到的锁 进入等待状态
notify()  #唤醒一个等待的线程，他不会释放锁
notifyAll()   #唤醒所有等待的线程
'''
class Producer(threading.Thread):

    def __init__(self,integer,condition):
        super().__init__()
        self.integer = integer
        self.condition = condition

    def run(self):
        while True:
            integer = random.randint(0,256)
            print('{}生产了一个{}'.format(self.name,integer))
            self.condition.acquire()  #获取
            self.integer.append(integer)
            self.condition.notify()
            self.condition.release()  #释放
            time.sleep(1)

class Consumer(threading.Thread):

    def __init__(self,integer,condition):
        super().__init__()
        self.integer = integer
        self.condition = condition

    def run(self):
        while True:
            self.condition.acquire()
            if self.integer:
                integer = self.integer.pop()
                print('{}删除了{}'.format(self.name,integer))
            else:
                print('{}准备消费，但是没有资源，进入等待')
                self.condition.wait()

            self.condition.release()



if __name__ == '__main__':
    con = threading.Condition()
    li = []
    p = Producer(li,con)
    c = Consumer(li,con)
    c1 = Consumer(li,con)
    c2 = Consumer(li,con)
    p.start()
    c.start()
    c1.start()
    c2.start()

#Event
'''
isSet()  返回标志位的状态
wait    等待 
set      设置标志位为Ture
clear       设置为Flase
'''

#当生产了数据 就设置标志位为Ture

