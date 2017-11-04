#02多继承，类的特殊方法，装饰器
#回顾
'''
1.类的定义,class
2.__init__,构造方法
3.self 参数， 实例本身
4.属性： 类属性（共有属性）  实例化属性
5.私有化 _   __
6.面向对象三大特征： 封装  ，继承 （object）， 多态：子类重写父类方法
'''


#1.多继承

class Base:
    def play(self):
        print('这是Base')


class A(Base):
    def play(self):
        print(type(self))
        print('这是A')


class B(Base):
    def play(self):
        print('这是B')


class C(A,B):
    
    #子类调用父类方法
    def play(self):
        #A.play(self)  #第一种方法
        #B.play(self)

        #super().play()     #第二种方法,默认调用第一个父类方法
        #super(C,self).play() #括号不写，默认(C,self)

        #super(A,self).play()  # Base
        #super(B,self).play()   # A   ,  上一层
        #super(Base,self).play()
        print('这是C')

        

c = C()  # (B,A)  C  -> B  -> A  -> Base  ->object

         # (A,B)  C  -> A  -> B  -> Base  ->object

C().__class__.mro()

'''
super, 上一层
1.super（），    （自己类名，自己实例） 例：（ C，c ）

2. 谁调用我，我就以你为基准。 建立一张调用顺序表
    ‘(B,A)   C  -> B  -> A  -> Base  ->object ’


'''


#2.类的特殊方法   (魔法方法)
'''
不仅仅是属性，更多是方法

'''

class Rectangle:
    '''这是一个长方形类，它可以计算面积'''
    aaa = 1
    def __init__(self,length,width):     #构造方法
        if isinstance(length,(int,float)) and isinstance(width,(int,float)):
            self.length = length
            self.width = width
        else:
            print('请输入int or float')

    def area(self):
        return self.length * self.width

##    def __str__(self):
##        return  '这个长方形的面积%s'%self.area()

    def __repr__(self):
        return '长:%s  宽:%s'%(self.length,self.width)

    def __call__(self):
        return '我这是一个Rectangle 类，你要干嘛'

    def __add__(self,other):
        return self.area() + other.area()
        
    def __sub__(self,other):
        return '不可以相减'


    
r = Rectangle(2,3)

#类属性

#__dict__ 

r.__dict__   # 打印实例里面的属性 ，{'length': 2, 'width': 3}


#注意  ,共有属性。当不修改时，默认引用（源类 Rectangle ），
                # 修改之后，就会定义在 实例里面
r.aaa = 22
r.__dict__


#__doc__
r.__doc__


#类方法 

#__str__    
#print(r)

#__repr__
r

'%s'%'ssss'   
'%r'%'rrrr'

#print  默认调用__str__   ,没有时__repe__




####  __call__
#r()
r()  # '我这是一个Rectangle 类，你要干嘛'

def dd():
    print('dd')

dir(dd)   #'__call__'



r1 = Rectangle(2,4)
r2 = Rectangle(3,5)

#   __add__(self,other)


#__sub__(self,other)     #x-y 




####
'''
delattr()		# 删除对象属性
getattr()		# 得到某个属性值
setattr()		# 给对象添加某个属性值
hasattr()  		# 判断对象object是否包含名为name的特性
isinstance()  	# 检查对象是否是类的对象，返回True或False
issubclass()  	# 检查一个类是否是另一个类的子类。返回True或Fals
'''





###3.装饰器 ,添加附加功能

#闭包

def fx(x):
    x += 1
    def fy(y):
        return x*y
    
    return fy

'''
fx(1)(2)
temp = fx(1)
temp(2)
'''


def f1(func):
    print('f1 running')
    def f2(y):
        print('f2 running')
        return func(y)+1
    return f2
    

def gun(m):
    print('gun running')
    return m*m

'''
f1(gun)
temp = f1(gun)
temp(5)
'''


@f1
def gun2(m):
    print('gun running')
    return m*m

'''
1.  @f1  ->   f1( gun2 )   -> f2
2.  f2  ,等待调用
3.  gun2   (5)  ->  当参数 5传入 --> f2(5)
4.  f2(5), 开始运行  ->  print('f2 running') ->  func(y)： func = gun2  y = 5  ->{{func(y) 等于 gun2（5）}}
5.  gun2(5) 开始运行  -> print('gun running') ->  25
6.  25 +1  -> 26
 
'''



##测试时间

'''
import time   
def run_time(func):
    def new_fun(*args,**kwargs):
        t0 = time.time()
        print('star time: %s'%(time.strftime('%x',time.localtime())) )
        back = func(*args,**kwargs)
        print('end time: %s'%(time.strftime('%x',time.localtime())) )
        print('run time: %s'%(time.time() - t0))
        return back
    return new_fun

'''


import time  #不要纠结

def run_time(func):
    def new_fun():
        t0 = time.time()
        print('star time: %s'%(time.strftime('%x',time.localtime())) )
        func()
        print('end time: %s'%(time.strftime('%x',time.localtime())) )
        print('run time: %s'%(time.time() - t0))
        
    return new_fun



@run_time
def test():
    for i in range(1,10):
        for j in range(1,i+1):
            print('%dx%d=%2s'%(j,i,i*j),end = ' ')
        print ()

        
##########  留个映像，用的不是很多


##类装饰器
class Test_Class():
    def __init__(self,func):
        self.func = func

    def __call__(self):
        print('类')
        return self.func


@Test_Class
def  fun_test():
    print('这是一个测试')

fun_test()
fun_test()()


###python自带3个，类的内置装饰器
class Rectangle:
    '''这是一个长方形类，它可以计算面积'''
    aaa = 1
    def __init__(self,length,width):     #构造方法
        if isinstance(length,(int,float)) and isinstance(width,(int,float)):
            self.length = length
            self.width = width
        else:
            print('请输入int or float')

    @property  # 可以把方法，当成属性一样调用  ， r.area
    def area(self):
        return self.length * self.width
    
    @staticmethod   #静态方法, 不用self了，实例可以直接调用
    def func():
        print('可以调用吗？')

    @classmethod   #将实例，还原成了类cls   self实例
    def show(cls):
        print(cls)
        print('show fun')


r = Rectangle(2,3)


























        
