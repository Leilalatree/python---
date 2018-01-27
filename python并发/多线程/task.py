# -*- coding:utf-8 -*-
import threading
import queue
import time
'''
Thread 是threading模块中最重要的类之一，可以使用它来创建线程。
有两种方式来创建线程：
一种是通过继承Thread类，重写它的run方法；
另一种是创建一个threading.Thread对象，在它的初始化函数（__init__）中将可调用对象作为参数传入。
'''


class Worker(threading.Thread):

    def __init__(self,work_queue,name):
        '''
        :param work_queue:队列
        :param name:线程名称
        '''
        super().__init__()
        self.work_queue = work_queue
        self.name = name

    def p_print(self,work):
        print('当前线程{}，正在执行{}'.format(self.name, work))
        time.sleep(1)

    def run(self):
        '''@summary: 重写父类run方法，在线程启动后执行该方法内的代码。
                '''
        while True:
            try:
                work = self.work_queue.get()
                print('当前线程{}，正在执行{}'.format(self.name,work))
                self.p_print(work)
            finally:
                self.work_queue.task_done()  #通知队列get的这次任务执行完毕

def main(tasks):
    work_queue = queue.Queue() #工作队列
    for i in range(3):
        worker = Worker(work_queue,i)
        worker.daemon = True   #worker 跟着主线程结束
        worker.start()   #是启动一个线程

    for task in tasks:
        work_queue.put(task)

    work_queue.join()

if __name__ == '__main__':
    main(range(10))

    '''
    1\创建3个进程
    2、拿要执行的任务put到队列
    3、再由线程不断get获取  任务   执行
    4、run方法  从队列获取数据，获取到了 执行p_print方法
       只要get到了 就执行task_done 通知队列完成了一次操作
    5、队列join等待 任务执行完毕，也就是等待10次 task_done
    '''
#队列是线程 进程 安全的  不需要自己写lock(锁)
#线程变量共享  线程在启动之后 不断的get  拿到任务就去执行