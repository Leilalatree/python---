# -*- coding:utf-8 -*-

from multiprocessing.dummy import Pool as ThreadPool
from multiprocessing import Pool
from multiprocessing import cpu_count
import queue
import time
from threading import Thread
'''
写一个线程池
pool = Pool() 实例化Pool 先判断要生成多少个线程，会直接生成这么多线程
'''
class MyThreadPool:

    def __init__(self, threads=None):
        self.queue = queue.Queue()   #直接生成一个queue
        if not threads:
            threads = cpu_count()
        for i in range(threads):
            #生成线程
            Thread(target=self.do_sth,name='i',daemon=True).start()#当主线程结束时，池会销毁

    def apply_asyns(self,func):
        self.queue.put(func)

    def join(self):
        self.queue.join()  #queue.join是干嘛的，每一次put的时候，会给一个内部数+1

    def close(self):
        pass

    def do_sth(self):
        #这个会传到target上,就是所有线程做的事情，就是死循环get函数
        while True:
            try:
                func = self.queue.get()
                func()
            finally:
                self.queue.task_done()  # 把queue里面的那个数-1

        #四个线程，一次丢4个任务，4个子线程会一次性拿掉4个，队列马上为空，主线程结束，导致所有的子线程没有执行任务就结束

if __name__ == '__main__':
    pool = MyThreadPool()
    def func1():
        print('1')
    def func2():
        print('2')
    def func3():
        print('3')

    l = [func1,func2,func3]
    #闭包
    for j in l:
        pool.apply_asyns(j)
    pool.join()

'''
为什么要用queue，可以帮助你确认任务是否完成，
确认线程安全，某一个瞬间，只能有一个线程在使用（锁）
'''