# -*- coding:utf-8 -*-

import threading

num = 0

def add_num(n):
    global num
    num += n
    num -= n

def run_thread(n):
    for i in range(100000):
        lock.acquire()
        try:
            add_num(n)
        finally:
            lock.release()

if __name__ == '__main__':
    lock = threading.Lock()
    for i in range(1000):
        t1 = threading.Thread(target=run_thread,args=(5,))
        t2 = threading.Thread(target=run_thread,args=(8,))
        t1.start()
        t2.start()
        t1.join()
        t2.join()
        print(num)