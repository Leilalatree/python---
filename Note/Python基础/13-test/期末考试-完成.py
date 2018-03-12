


#题1
'''
在这一个月，我们学了python基础，简单总结下，有六种数据类型，函数以及类。
(1)请从str，list,dict,set选出 1 种数据类型，进行归纳总结。
(2)请选择函数和类其中 1 种，进行归纳总结。
'''

#例  元组(tuple)
#1.可变不可变对象？序列还是非序列？
#2.操作元祖的方法有多少种，其中哪几个方法使用频率高，并选择1-3个方法进行代码展示
#3.是否可迭代
#4.索引和步长简单展示
#5.特殊的骚操作及用法
#开放题，想到多少写多少，可以通过回顾视频以及查资料的方法完成此题。
#以元祖为例，完成1.2.3即可拿到70%的分数。

#list
#1、str可变，序列
#2、
li = [1,2,3,4,5,6,7,8,9]

'''
通过help(li) 得到列表的方法 有append clear copy count extend index insert
                              pop remove reverse sort


'''
li.append(10)

li.extend('hrx')
'''
>>> li.insert(10,'xx')
>>> li
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'xx', 'h', 'r', 'x', 10]
>>> li.pop(10)
'xx'
>>> li
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'h', 'r', 'x', 10]
'''

#3 可迭代  li.extend()

'''
(2)类 object基类  封装 继承 多态
类的构造方法__init__(),self为参数
例如构造一个Food类

'''
class Food:
    __who = 'human' #共有的
#_”和” __”的使用 更多的是一种规范/约定，并没有真正达到限制的目的：
    def __init__(self,food,people): #构造方法——实例化对象调用__init__
        print('正在实例化一个Food类')
        self.food = food
        self.people = people

    def get_food(self):
        print(self.food)

    def get_people(self):
        print(self.people)
        

class Things(Food):
    def __init__(self,food,people,price): #构造方法——实例化对象调用__init__
        print('正在实例化一个Things类')
        self.food = food
        self.people = people
        self.price = price
        
    def prize(self):
        print(self.price)








#题2
'''
今天学习了正则表达式，请以所学的知识完成以下要求：
(1)请写出python的变量命名规则    
(2)'00\d'可以匹配 001,002,003等等，
   '\d\d\d'可以匹配010,999,998,666等三位数
    请写出一个正则表达式，它可以匹配python合法的变量名



(1)
   1、变量名可以包括字母，数字，下划线，不能以数字开头
   2、系统关键字不能使用变量名
   3、除了下划线，其他符号不能使用变量名，Python中大小写区分

'''
import re
import keyword
kwords = keyword.kwlist
def _2():
    a = input('输入变量名：')
    b = re.findall(r'^[a-zA-Z\\_]',a)   #匹配第一个字符是否为字母或者下划线
    b1 = re.findall(r'\w*',a)  #末尾总是有一个空'' 所以将他pop掉
    b1.pop()
    if b:
        if '' in b1:   #判断输入的a 匹配字母数字下划线，如果存在'' 说明存在特殊符号
            print('不合法')
        else:          #如果不存在，则匹配所有字符，返回的列表为[a,''] 判断a是否在kwords列表中，
                       #如果存在，则不合法，否则合法，变量名可用
            c = re.findall('.*',a)
            if c[0] in kwords:
                 print('不合法')
            else:
                 print('合法')
     
    else:
        print('不合法')










#题3
'''
请定义一个类(class),满足以下要求：
    1.这个类，必须含有字符串所有的方法。
    2.这个类有一个统计方法：
        统计输入字符串里，英文字母、空格、数字和其他字符分别出现次数，
        返回值为包含元祖的列表，格式如下：
        参数' hello  9'
        返回值：[('letter',5),('space',3),('num',1),('other',0)]
        (对返回值列表中元祖的顺序无要求)

'''
class Magic:
    def __init__(self,a):
        self.a = a
        print("输入为：",a)

    def re(self):
        letter = re.findall(r'[a-zA-Z]',self.a)
        count_letter = len(letter)
        print("letter:",count_letter)

        space = re.findall(r'[\\ ]',self.a)
        count_space = len(space)
        print("space:",count_space)

        num = re.findall(r'\d',self.a)
        count_num = len(num)
        print("num:",count_num)

        other = re.findall(r'\w|[\\ ]',self.a)
        count_other = len(self.a) - len(other)
        print("other:",count_other)

        re_list = [('letter',count_letter),('space',count_space),
                   ('num',count_num),('other',count_other)]
        return re_list

        


#题4
'''
猴子第一天摘下N个桃子，当时就吃了一半，还不过瘾，就又多吃了一个。
第二天又将剩下的桃子吃掉一半，又多吃了一个。
以后每天都吃前一天剩下的一半零一个。
到第10天在想吃的时候就剩一个桃子了,
问第一天共摘下来多少个桃子？
(提示:递归函数)
'''
def peach(n):
    if n == 1 :
        return 1
    else:
        return peach(n-1)*2+2
    




#题5
'''
请定义一个名为titles的函数：
    1.接收一句英文(字符串)作为参数
    2.将这个英文的每个单词转换成有且只有首字母大写的形式
    3.返回转换后的英文句
    4.str.title具有这个功能，但在此题不可使用str.title，请用自己的代码完成。
例如：
>>> titles('this is python.')
'This Is Python.'
>>> titles('i love python')
'I Love Python'
>>> 

'''

def titles(t):
    r = re.findall('\w+',t)
    li = []
    s = ''
    for i in r:
        i = i[0].upper()+i[1:].lower()
        print(i)
        li.append(i+' ')
        s.join(str(i))
    return s
        





#题6
'''
现有一个列表，其中有10个元素，元素均为int类型，列表内的数据是无序。
现在要求我们通过编写一个程序将这列表变成一个从小到大排序的列表
请用自己的代码完成。
'''
import random
b_list = range(1,100)
l6 = random.sample(b_list,10)

def sorting(a):
    a = sorted(a)
    return a



#题7
'''
1.写一个猜数字的游戏，要求：系统生成一个随机数（1-10），用户输入数字去猜。
如果输入数 小了 或者 大了，都给于相应提示。如果输入数 与 随机数相等，
就提示“ 恭喜您猜对了!”
'''

import random
def play():
    num = input("请输入1个1-10 的整数:")
    num = int(num)
    r = random.randint(1,10)
    if num > r:
        print("大了")
    elif num < r:
        print("小了")
    else:
        print("恭喜您猜对了")

    return play()
                

