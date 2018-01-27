# -*- coding:utf-8 -*-

from multiprocessing import Process,Queue
from random import randint
import time
#生产者
class Producer(Process):
    def __init__(self,queue):
        super().__init__()
        self.queue = queue
    def run(self):
        for i in range(10):
            item = randint(0,255)
            self.queue.put(item)   #生产者生产put
            print('生产者生产了{item}'.format(item=item))
            time.sleep(1)


#消费者
class Consumer(Process):
    def __init__(self,queue):
        super().__init__()
        self.queue = queue
    def run(self):
         for i in range(10):
            time.sleep(2)
            item = self.queue.get()
            print('消费者消费了{item}'.format(item=item))

if __name__ == '__main__':
    queue = Queue()
    producer = Producer(queue)
    consumer = Consumer(queue)
    producer.start()
    consumer.start()
    producer.join()
    consumer.join()
