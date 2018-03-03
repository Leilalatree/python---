
# 1. 进程的创建过程   重新启动一个新的进程，然后导入调用模块,
#
# 2. if __name__ == '__main__' 会判断是不是当前文件执行 如果是被导入 if判断下面的代码不会被执行
#
# 3. LOCK

# import multiprocessing # 导入创建进程的模块
# import time
# import os
#
# def func():
#     print('子进程运行中....,子进程的id是{}'.format(os.getpid()))
#     time.sleep(2)
#
#
# if __name__ == '__main__':
#     print('运行父进程,父进程的id是{}'.format(os.getpid()))
#     print('创建子进程')
#     p = multiprocessing.Process(target=func) #子进程
#     print('运行子进程')
#     p.start() # 启动进程
#     p.join()  #等待子进程运行结束
#     print('22'+str(os.getpid()))


# 多进程会不会共享全局变量   不会共享  共享的是文件系统

#LOCK

# join 和lock的区别在哪里   局部串行
# 加锁部分的代码越少越好


import multiprocessing

def worker_write(lock,file):
    lock.acquire()   #如果获取锁的时候没有会阻塞
    try:
        fs = open(file,'a+')
        n = 100000
        while n>0:
            fs.write('a\n')
            n -=1
        fs.close()
    finally:
        lock.release()


def workers_write(lock,file):
    lock.acquire()
    try:
        fs = open(file, 'a+')
        n = 100000
        while n > 0:
            fs.write('b\n')
            n -= 1
        fs.close()
    finally:
        lock.release()



if __name__ == '__main__':
    lock = multiprocessing.Lock()
    f = 'file.txt'
    p1 = multiprocessing.Process(target=worker_write,args=(lock,f))
    p2 = multiprocessing.Process(target=workers_write,args=(lock,f))
    p1.start()
    p2.start()
    p1.join()
    p2.join() #

    print('子进程结束')



# 不是给资源加锁  而是用锁锁定资源
