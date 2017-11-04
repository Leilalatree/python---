#迭代器生成器、模块和包
#回忆
'''
1.文件：open, (r,w,a,+,x)
        read readline  readlines
        write writelines
        flush  seek  tell
        close  closed
2.异常： try  except  else  finally.  raise   assert


'''

#1.迭代器和生成器

#补充
li = [0,2,4,6,8,10,12,14,16,18]  # 0- 100

l2 = []
for i in range(20):
    if i%2 ==0:
        l2.append(i)

        

l3 = []
for i in range(0,20,2):
        l3.append(i)

l4 = list(range(0,20,2))


#列表推导式   优化，简单代码 
l5 =[i for i in range(20)]  # 第一个 i，就是往列表 添加的 value

l6 =['aa' for i in range(20)]
#偶数
l7 =[i for i in range(20) if i%2 ==0]
#奇数
l8 = [i for i in range(20) if i%2!=0]
l8 = [i for i in range(20) if i%2==1]

#偶数   #奇数 -> 'a'
l9 = [i if i%2==0 else 'a' for i in range(20)]


#集合
s = {i for i in range(10)}

#字典
di ={i:'jianeng' for i in range(10)}


#迭代器   核心 __iter__()和__next__()
'持迭代器协议就是实现对象的 __iter__() 和__next__()方法。'

# 可迭代对象  __iter__()

# iter()   __iter__()

li = iter(li)  # li 变成一个迭代器
#li[0]
type(li)

## next()  __next__()    # 迭代的取值
next(li)
#l2.__next__()


# 只要 有__iter__()和__next__()方法  ，就是一个迭代器
'''
iter()  实现了 __iter__()
next()  实现了 __next__()

'''
# 迭代器是用来干嘛的
'''
for ：
1. iter（） —> 迭代器
2. next()  —>  迭代的取值

extend(iterable)  -》iter（） -》 next() ->append()

'''
##for i in li:
##	print(i)



#### 生成器， 本质也迭代器

def fun():
    i = 0
    while i<5:
        print('***')
        yield i   # 暂停的  ， 同时 返回值
        i +=1
        print('+++',i)




next( fun() )  #每次调用，会新生产一个对象

a = fun()
next(a)
a.__next__()


#例子：  斐波拉契数  1 1 2 3 5 8 （前面两个输的和，就是后面这个数的值）

def fib(num):
    n,a,b = 0,0,1
    while n < num:
        print(b)
        a,b = b, a+b
        n = n +1


#yield


def fib2(num):
    n,a,b = 0,0,1
    while n < num:
        print(b)
        if n%10 ==0:
            yield    #暂停
        a,b = b, a+b
        n = n +1






###2.模块和包

##模块  本质就是一个 py 文件

##内置模块   python 自带
import keyword    #会把模块里面所有的内容都导入


from random import randint  # 指定导入,节省内存


from random import *  #会把模块里面所有的内容都导入，
                     #但是不会把，_cos

from random import _cos




##第三方模块，  别人写，不是python自带的   自己写的

## 同路径下
import test   ##可以用import
test.test()   ##  调用方法
test.test1      ##  调用属性


#__name__    #我自己调用，才会执行



#不在同路径

# import test2

import os,sys
sys.path
sys.path.append(r'E:\16班基础\5高级专题')  #添加路径

import test2
test2.test()
test2.test1


#包  一个文件夹里面，放了很多的模块。 文件夹就叫包

import xml
import xml.dom
import xml.dom.domreg
# 不是系统的包就添加路径



### 补充
sys.argv


##time

import time
time.localtime()
time.asctime(time.localtime())
time.time()










