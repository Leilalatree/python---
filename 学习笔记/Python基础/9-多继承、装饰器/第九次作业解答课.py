#面向对象作业2



#1.把老师上课例子都敲一遍（不需要截图，但是一定要做）







#2.测试type 和 isinstance 那个的速度更快
import time

def run_time(func):
    def new_fun():
        t0 = time.time()
        print(t0)
        func()
        t1 = time.time() - t0
        return t1
    return new_fun

@run_time
def test_type():
    for i in range(100):
        i = i*2
        type(i) == int
    print('结束')

@run_time
def test_isinstance():
    for i in range(100):
        i = i*2
        isinstance(i,(int,float))
    print('结束')

def test():
    a=test_type()   #t1
    b=test_isinstance()  #t1
    if a>b:
        print('isinstance更快')
    else:
        print('type更快')
    

def tt(x,y):
    return x,y   #试试 a,b = tt
  






#  高阶函数 ，嵌套函数

def a(txt):   #我是嵌套函数
    def b(txtb):
        def c(txtc):
            print(txt,txtb,txtc)
        return c
    return b
#高阶函数  1可以接受函数作为参数 2 可以将函数作为返回值
def f(aa):
    aa()
    aa()

def lin():
    print('高阶函数')


def log(fun):
    def wrapper(*args):   #wrapper  包装
        print('我叫装饰器')
        fun(*args)
    return wrapper          #是可以装饰有参数的函数的

def ff():
    print('这是个被装饰的函数')
@log       
def fff(x):
    print(x)
##@log    #  ff = log(fff)--> wrapper
##def fff():    #   fff() --> wrapper()
##    print('我也被装饰了')
#3.实现一个正方形类的加减乘除(就那些装B的魔术方法，能写多少写多少)
'''
class Square(object):
    def __init__(self,length):
        self.length = length
        self.area = length**2

    def __add__(self,other):   #  __add__ 
        return self.area + other.area

    def __sub__(self,other):
        return self.area - other.area

    def __mul__(self,other):
        return self.area * other.area

    def __truediv__(self,other):
        return self.area / other.area

class a:
    def __init__(self,x):
        self.x = x
    def __add__(self,other):  #other 是另一个实例化对象
        return self.x + other.x
'''   



##
###高阶函数 1。接受函数作为参数   2。返回值可以是函数  reuturn fun
##
##
##def gj(f):
##    f()   #gao()
##    f()   #gao()
##    f()
##    f()
##    return f()   #gao
##
##def gao():
##    print('高阶')





#super   用来解决多继承问题。查找顺序c.__class__.mro()

class Base(object):
    def __init__(self):
        print('进入base')
        print('离开base')

class A(Base):
    def __init__(self):
        print('进入a')
        super().__init__()      # --》B
        print('离开a')

class B(Base):
    def __init__(self):
        print('进入b')
        super().__init__()     #--》Base
        print('离开b')

class C(A,B):
    def __init__(self):
        print('进入c')
        super().__init__()   #上一层 --》A
        print('离开c')


#c=C()     c.__class__mro()   CAB BASE  OBJECT

#super  1.继承顺序   2.上一层，然后代码执行顺序  （从上到下，从左到右）

#装饰器  











