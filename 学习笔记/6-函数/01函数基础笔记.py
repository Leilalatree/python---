#python函数基础

#课程调整
'''
1.从今天开始
正式课，每周 2,4,6
解答课，每周 1,3,5

基础班结课时间是：11.3号  。  原来是10.30
'''

#回顾

'''
1.条件语句: if elif else,pass占位
2.循环语句：1.while，终止条件
           2. for  ，迭代对象
3.三种通用操作：break ,强制结束循环
               continue，跳过本次循环
               else，当循环正常结束，就会执行else


'''
a =1
b =2
if a>b:
    print(a)
elif a<b:
    print(b)


for i in range(10):
    print(i)


li =[1,2,3,4,5]
for i in li:
    print(i)

s ='asd'
for i in s:
    print(i)


def selFor (iterable):  #驼峰命名规则
    for i in iterable:
        print(i)

##定义函数
def fun(a):
    print('hello',a)

#传参

#不需传参数
def fun():
    print('hello python')
    print('人生苦短，我用python')

#必备参数
def fun2(a):
    print('必备参数：',a)

#默认参数
def fun3(a=3):
    print('默认参数：',a)


#可选参数 0个-多个

#*arg

def fun4(*arg):  #默认将我们的传入参数，包装成元组
    print('arg:',arg)

    
fun4(1,2,4,5,6,7)
fun4(li,1,2,4,'ssss',{'a':2})
tu =(1,2,3,4)
fun4(*tu)
fun4(*li)
fun4(*{'s':2})


#**kwarg
def fun5(**kwarg): #默认将我们传入的参数，包装字典
    print('kwarg',kwarg)

#空集合  se = set()
#空字典  {}

di = dict(a=1)
## **kwarg  传值的时候，必须要满足字典的定义

fun5(a=1,b=3,c=4,d=5)
fun5(**di)


###5种传参，混合用时，需要足以的事项
'''
1.默认参数，必备参数
2.*arg ,默认参数，必备参数
3.*arg,**kwarg
'''
#1
def fun6(b,m=2):  #默认参数，必须放到，必备参数之后
    print('必备参数',b)
    print('默认参数',m)

fun6(1,3)
fun6(m=10,b=5) 


#2
def fun7(b,m=2,*arg):
    print('必备参数',b)
    print('默认参数',m)
    print('arg',arg)


def fun8(*arg,b,m=2): #当*arg 在最前时，后面参数，必须指定
    print('必备参数',b)
    print('默认参数',m)
    print('arg',arg)


#fun8(1,2,3,4,5,6,7)
fun8(1,2,3,4,5,b=6,m=7)
fun8(1,2,3,4,5,m=6,b=7)

def fun9(*arg,m=2,b): #当*arg 在最前时，默认参数可以放到必备参数前面
    print('必备参数',b)
    print('默认参数',m)
    print('arg',arg)

fun9(1,2,3,4,5,b=6,m=7)


#3
def fun10(*arg,**kwarg): # **kwarg,只能放到最后
    print('arg',arg)
    print('kwarg',kwarg)


fun10(1,2,3,4,5,6,7) # arg (1, 2, 3, 4, 5, 6, 7)
                     # kwarg {}

fun10(1,2,3,4,a=2,b=3)


#return 

#1
#如果函数中没有写return，
#其实函数运行结束时，默认执行了 return None
a =fun()
print(a)

def test_return(a,b):
    if a>b:
        return a
    elif a<b:
        return b
    else:
        return '一样大'
    
    print('比较结束*****')  #不会打印
    

#return  print 进行区别:
#return:返回函数运行的结果
#print ：打印输出，只是用来看的

    
def test_return2(a,b):
    return 'jianeng'
    if a>b:
        print( a)
    elif a<b:
        print( b)
    else:
        print( '一样大')
        
    print('比较结束*****')



#lambda匿名函数, 没有名字的函数


def fun_name():
    print('函数内容')


#在定义lambda 之前
fun
f =fun
f()

#lambda定义

#lambda x(参数) :x +1 （return x+1）

(lambda x :x +1)(5)

g = lambda x:x+1
g(1)

#传入多个参数
add = lambda x,y:x+y

#判断偶数？
b =lambda x:x%2==0

def judge(x):
    if x %2==0:
        return True
    else:
        return False














