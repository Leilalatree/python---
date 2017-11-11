#01类的慨念、定义、属性、继承
#回顾
'''
1.内置函数，enumerate  filter  map  zip
2.变量的作用域， global  nonlocal
3.闭包
4.递归:
'''

#面向对象
'''
图书管理系统：
1.图书 ： 10000
2.管理员 ： 50
3.读者 ： 1000

'''

#类   类是对现实生活中，具有共同特征的事物的抽象。

class  Animal(object): 
    pass


# object, 基类。 任何类都需要继承object

# 类 (模子)
class  Animal: #python3 继承object，可写可不写
    pass
dog = Animal()
cat = Animal()



##构造方法 __init__() , self 参数
class  Animal:
    def __init__(self):   # 构造方法,实例化对象时，必须掉调用__init__
        print('正在实例化一个类')

    def test(self):
        print('aaa')

#当我们没有写__init__() ,默认调用我们父类__init__
class  Animal:

    def test(self):
        print('aaa')


###self, 实例化对象（本身）

#self 可以替换成别的参数名。但是最好别改
class TestSelf:     #方法 ：testSelf   类:  TestSelf
    def __init__(self): #在初始化的时候，默认往构造方法，传入一个值
        print('正在实例化')

    def test(self):  
        print('bbb')

    def test2():
        print('ccc')



####属性， 属性本质上就一个变量
'''
1.实例化属性
2.类属性 （共有属性）
'''


# 1.实例化属性 , self.name
class Animal:
    def __init__(self,name,food): #自己独有的，就放到实例化里面
        print('正在实例化')
        self.name = name
        self.food = food

    def get_name(self):
        print(self.name)


#2.类属性 （共有属性）

class Animal:
    eye = 2
    leg = 4  #共有的
    def __init__(self,name,food):
        print('正在实例化')
        self.name = name
        self.food = food

    def get_name(self):
        print(self.name)



##私有化
'''
在Python中，通过单下划线”_”来实现模块级别的私有化，
一般约定以单下划线”_”开头的变量、函数为模块私有的，
也就是说”from moduleName import *”
将不会引入以单下划线”_”开头的变量、函数
'''
import random   #全部会导入
 
from random import*  #_Set  不会倒入

class Animal:
    _eye = 2
    __leg = 4  #共有的
    def __init__(self,name,food):
        print('正在实例化')
        self.name = name
        self.food = food

    def get_name(self):
        print(self.name)

#_”和” __”的使用 更多的是一种规范/约定，并没有真正达到限制的目的：

dog._eye = 3
#dog._Animal__leg ##__ 默认加一个类名，用来警告


# “__foo__”：以双下划线开头和结尾的（__foo__）
#代表python里特殊方法专用的标识，如 __init__（）



## 面向对象   三个特征： 封装 ，继承  多态

# 封装

class Animal:
    eye = 2
    leg = 4  #共有的
    def __init__(self,name,food):
        print('正在实例化')
        self.name = name
        self.food = food

    def get_name(self):
        print(self.name)

    def get_food(self):
        print(self.food)


# 继承
#面向对象的编程带来的主要好处之一是代码的重用

class People(Animal):
    leg = 2
    def __init__(self,name,food,sex):
        self.name = name
        self.food = food
        self.sex = sex
    
    def get_sex(self):
        print(self.sex)

    def speak(self):
        print('asdsdgfsagg')

    def eat(self):
        print('果子')
    


#多态,   (子类重写父类方法) ,继承。 （同一个方法，有不同表形式）

class Chinse(People):
    def speak(self):
        print('你好')

    def eat(self):
        print('米饭')


class America(People):
    def speak(self):
        print('hello')

    def eat(self):
        print('面包')
    

class Thai(People):
    def speak(self):
        print('萨瓦迪卡')

    def eat(self):
        print('香蕉')



xiaoMing = Chinse('小明','米饭','男')

jeck = America('jeck','面包','男')

lala = Thai('lala','香蕉','未知')


'''
总结：
1.类的定义
2.__init__() 构造方法
3.self  参数。 实例对象本身
4.类属性 （共有属性），  实例化属性 
5._  __   python 类的私有化。

6. 面向对象  三大特征： 封装   继承   多态

'''







































































