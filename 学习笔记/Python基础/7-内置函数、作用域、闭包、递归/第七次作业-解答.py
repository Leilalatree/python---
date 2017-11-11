#函数的命名规范
#pep8
#1.和变量命名规则一样
#a.只能由字母，数字，下划线组成
#b.不能以数字开头
#c.不能使用关键字作为变量（help('keywords')）
#2.命名需要见名知义，user_want,this_is_a_func.


#命名关键字参数

def f(a,b=1,*arg,**kwarg):
    print(a)
    print(b)
    print(arg)
    print(kwarg)
#默认参数不能放到必备参数前面。

def f1(**kwarg): #0-任意多个参数，字典  传入的数量，以及传入的键名  
    print(kwarg)

#学籍注册   姓名，年龄，国籍，城市。   
def f2(name,*,country,city):
    print(name)
    print(country)
    print(city)
#作用：限制传入的参数的数量，限制变量名。


#sort与sorted   区别
#sort 是list的一个方法，它的作用对象只能是列表。
    #sorted  内置函数 对象为可迭代对象。
#sort没有返回值，直接修改列表本身
    #sorted 有返回值
#sorted(l)  #错误的   



#可迭代对象
    #1.所有的序列类型  list tuple str
    #2.一些非序列类型   dict  set
    #3.定义的任何包含 __iter__()或者 __getitem__()类的对象。


















#2.定义一个函数，输入一个序列(序列元素是同种类型)，
#判断序列是顺序还是逆序，顺序输出UP，逆序输出DOWN，否则输出None  (sorted)


def judge_seq(seq):
    se = list(seq)
    print(se)
    if sorted(se) == se:
        return 'up'
    elif sorted(se,reverse=True)== se:  #降序逆序
        return 'DOWM'
    else:   # sorted(se) != se
        return 'None'


#3.写一个函数，对列表li = [9,8,3,2,6,4,5,7,1]，进行从小到大的排序。最后返回li
#冒泡排序  微软  筛选  第一轮
##def li_sort(li):
##    li.sort()
##    return li
##def li_sort(li):
##    for j in range(len(li)):
##        for i in range(len(li)-1):
##            if li[i] > li[i+1]:
##                li[i],li[i+1] = li[i+1],li[i]
##    print(li)

#相邻的2个数去比较，如果1》2，那a,b=b,a
li=[9,8,7,6,5,4,3,2,1]
def li_sort(li):
    print(li)
    for j in range(len(li)-1):
        for i in range(len(li)-1):
            if li[i] > li[i+1]:
                li[i],li[i+1] = li[i+1],li[i]
    print(li)



#4一个列表，有4个由数字组成的长度为4的元组，对这四个元组，
#按每个元组的第2个数字大小排序

lis = [(2,3,4,5),(1,8,6,7),(6,0,1,9),(9,6,3,1)]

lis.sort(key=lambda a:a[1])    


#lambda 看佳能老师的视频，



#5思考题：有一个名为list_apd的函数，
#如下所示，请你多次调用这个函数，对比返回值，是否与你预期的一致？  一致
#想到什么写什么，可以空着
def list_apd(b,a=[]):   
    a.append(b)
    return a



def add_1(l=[]):
    l.append(1)
    return l


def list_apd(b,a=None):
    if a = None:
        a=[]
    a.append(b)
    return a

#默认参数 必须指向不可变对象，防止逻辑错误
    
