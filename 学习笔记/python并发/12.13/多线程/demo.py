# -*- coding:utf-8 -*-

# import threading  #多线程模块
# import time

# def func(name):
#     print('i am {}'.format(name))
#     time.sleep(2)
#
# if __name__ == '__main__':
#     t1 = threading.Thread(target=func,args=('爬虫1号',))
#     t1.start()



# def run(name):
#     print '我是{}'.format(name)
#     time.sleep(2)
#     print '{}结束了'.format(name)
#
# if __name__ == '__main__':
#     t1 = threading.Thread(target=run,args=('爬虫1号',))
#     t2 = threading.Thread(target=run, args=('爬虫2号',))
#     #t1.setDaemon(True)    #设置守护线程
#     t1.start()
#     t1.join()
#     t2.start()
#     print('end')  # t1是守护主线程 但是t2还在运行 主线程并没有结束 所以t1也能输出


#线程池
#一个线程池包含的部分

#1、线程池管理器 用于启动 管理线程
#2、工作线程
#3、请求接口（函数调用）
#4、任务队列
#5、结果队列
#
# from multiprocessing.dummy import Pool as ThreadPool #线程池
# import time
#
# def get(url):
#     print('get:{}'.format(url))
#     time.sleep(1)
#1\
# start = time.time()
# result = map(get,range(10))
# print('运行时间为:{}'.format(time.time()-start))

# #2\线程池
# pool = ThreadPool(10)  #默认线程
# start = time.time()
# pool.map(get,range(10))  #map阻塞
# print(time.time() - start)
# pool.close()
# pool.join()

import threading
import time
class Producer(threading.Thread):
    def run(self):
        while True:
            print('{}准备获取锁'.format(self.name))
            if condition.acquire():
                if len(task) >100:
                    print('资源足够等待消费')
                    condition.wait()      #当生产者生产大于100个时，进入等待状态
                else:
                    for i in range(10):
                        task.append(i)
                    print('{}添加了10个元素到task，task长度为{}'.format(self.name,len(task)))
                    condition.notify() #唤醒等待的线程
                    time.sleep(0.5)
                    condition.release()

class Consumer(threading.Thread):
    def run(self):
        while True:
            print('{}准备获取锁'.format(self.name))
            if condition.acquire():
                print('{}获取到了锁'.format(self.name))
                if len(task) < 10:
                    print('资源不足，wait等待！')
                    condition.wait()
                else:
                    for i in range(10):
                        task.pop()
                    print('{}删除了10个元素，task长度为{}'.format(self.name,len(task)))
                    condition.notify()
                    time.sleep(0.5)
                    condition.release()

task = []
condition = threading.Condition()

if __name__ == '__main__':
    for i in range(3):
        p = Producer()
        p.start()
    for j in range(5):
        c = Consumer()
        c.start()