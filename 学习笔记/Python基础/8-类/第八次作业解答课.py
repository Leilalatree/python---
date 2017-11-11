#python面向对象作业1


#1.把老师上课例子都敲一遍（不需要截图，但是一定要做）




#2.定义一个矩形的类：
#    要求：1.有长和宽的属性  int  float
#          2.有一个计算面积的方法

##isinstance
class Rectangle:
    def __init__(self,length,width):     #构造方法
        if isinstance(length,(int,float)) and isinstance(width,(int,float)):
            self.length = length
            self.width = width

    def area(self):
        return self.length * self.width



#如何判断self就是实例化对象

##class test(object):
##    def __init__(self):
##        if isinstance(self,test):  #True
##            print('老铁我真的是的')
##        else:
##            print('no')
##
##    def isin(self):
##        print(type(self))
##        print(type(test))             #元类  metaclass  
##        if type(self) == type(test):   #False
##            print('老铁我还是得')
##
##        else:
##            print('扎心了')

     
##                        object
##
##                        Animal
##
##                        Dog   Cat
##
##
#
#  缩进快捷键 tab  ctrl+[  或者 ]








#3.写一个正方形的类，继承矩形类
#    要求：有一个判断是不是正方形的方法


class Rectangle:
    def __init__(self,length,width):     #构造方法
        if isinstance(length,(int,float)) and isinstance(width,(int,float)):
            self.length = length
            self.width = width
        else:
            print('请输入int or float')

    def area(self):
        return self.length * self.width




class Square(Rectangle):             #sikuaiao  qiaokelite
    def judgement(self):
        if self.length == self.width:
            return 'It is square'
        else:
            return 'It is not square'
            


#这个函数：在学生报名的时候，把所有学生的姓名添加到列表里，返回值为添加成功后的列表



def apd(*arg,li=[]):
    li.append(arg)
    return li          #return 后面的语句不执行   


def li_apd(*arg,li=None):
    if li == None:    #  li == None  True
        li = []
    li.append(arg)                  #只能添加一个元素  dir(list.append) *arg arg
    return li

#总结: 避免使用可变对象作为参数





##1.可变与不可变    可变 list,dict,set   不可变：str,tuple
##2.li.append(*arg)

#  number  :   int float complex bool   #
#  str       
#  list
#  tuple
#  dict
#  set

de = '老心，扎铁了，我是个变量'

def de():
    print('老铁扎心了，我是个函数')

class test1:
    def __init__(self,name,age):
        self.name =name
        self.age = age

    def new_age(self):
        new_age = self.age +20
        print(new_age)   
















































    

