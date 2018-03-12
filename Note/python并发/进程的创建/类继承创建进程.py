

#  类继承创建进程

import multiprocessing
import time

class New_Process(multiprocessing.Process): #继承 multiprocessing



    def run(self):
        n = 5
        while n >0:
            print('the time is {}'.format(time.time()))
            time.sleep(5)
            n -=1

if __name__ == '__main__':
    for i in range(5):
        p = New_Process()
        p.start()


# 并发 进程数大于cpu个数
# 并行 cpu个数 大于等于进程数




