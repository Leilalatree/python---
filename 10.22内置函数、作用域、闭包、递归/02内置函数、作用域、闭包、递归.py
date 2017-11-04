#python  函数

#回顾
'''
1.函数定义 def  fun_name ():
2.参数：1.不需传参  2.必备参数  3.默认参数  4.不定长  *arg   **kwarg
3.return: 1.返回函数的运行结果    2.函数结束标志
4.lambda: 匿名函数
'''

#内置函数  python自带
'''
type(1)
max(1,4)
min()
print()
len()
sorted()
reversed()
help()
id()
range()

'''
li = dir(__builtins__)
li.index('abs')
li[81:]
len(li[81:])

###补充

li =[1,2,3,4]
sum(li)

abs(-12) #绝对值

round(1.4) #四舍五入
round(1.445,2)

bin(5)  #二进制

oct(8)  #八进制  %o
hex(10) #16进制

ord('a') #将字符转换成对应的ASCII码值
ord('A')
chr(65) #将ASCII码值转换成对应的字符


#1.enumerate   #返回一个可以枚举的对象  (index,value)
li = ['a','c','b'] 
list(enumerate(li))
di ={'a':1,'b':2}
dict(enumerate(li))  #可以转成字典

#注意  集合 ，字典，是无序的，没用索引。 反回（伪索引，value）
se = {1,2,3,'asd',5}
di ={'a':1,'b':2}
list(enumerate(se))



#2.filter() #过滤器
li =[1,2,3,6,7,8]
def test(x):
    return x>5


#lambda  2.凡是可以用到函数地方，都可以用lambda
list(filter(lambda x:x>5,li))


# map() #加工
li =[1,2,3,6,7,8]

list(map(str,li))   #转换成字符串

#每一个元素加一个 1
list(map(lambda x:x+1,li))

# zip() #将对象逐一配对
li2 =[1,2,3]
tu = ('a','b','c','e')
list(zip(li2,tu))
dict(zip(li2,tu))  #



#2.函数内变量的作用域

'''
全局变量可以在函数内部访问，但是不能改变
如果在函数内部想修改全局变量，可以用 global 来修饰变量

'''

a = 10 #全局变量
def test1():
    b = 5 #局部变量
    print('局部访问全局变量 a:',a)  #局部可以访问，全局变量
    #a +=1   #全局变量可以在函数内部访问，但是不能改变
 


def test2():
    global a  #全局声明
    a +=1
    print('内部修改全局变量 a:',a)



def test3():  # global 只对当前函数起作用
    #global a
    a +=1
    print('teat3修改全局 a',a)


'''
局部变量只能在局部进行访问和修改。
如果在函数外部，想访问局部变量，也可以用 global，将局部变量声明为全局变量
'''
def test4():
    global b 
    b = 4
    b+=1
    a = 21
    print('局部变量 b:',b)




## 使用nonlocal的情况

#内嵌函数

def test5():
    c = 2
    print('局部外层 c',c)
    def test6():
        d = 5
        print('局部里层 d',d)
    test6()


# nonlocal


c = 11
def test7():
    c = 2       #声明外层(非全局)变量
    print('局部外层 c',c)
    def test8():
        d = 5
        print('局部里层 d',d)
        nonlocal c 
        #global c   
        c += 1   #当里层局部，需要修改外层局部时
        print('当里层局部，需要修改外层局部 C ',c)
    test8()





###闭包

def test9(name):
    
   def test10(age):
       print('name',name,'age',age)
       
   return test10

f10 = test9('jianeng')
f10 (18)

### 装饰器 ：本身就是一个闭包



## 4.递归函数

'''
例题：有5个人坐在一起，问第五个人多少岁？他说比第4个人大2岁。
       问第4个人岁数，他说比第3个人大2岁。
       问第三个人，又说比第2人大两岁。
       问第2个人，说比第一个人大两岁。
       最后问第一个人，他说是10岁。
       请问第五个人多少岁？
'''

'  n1      n2        n3         n4      n5    '

#   10    n1 +2    n2 +2      n3 +2       n4+2


#for  循环
def age(n):
    age = 10
    for i in range(1,n):
        age = age +2
    print('最后一个人，是%s 岁'%age)



### 递归
def age2(n):
    if n == 1:
        return 10
    else:
        return age2(n-1) +2


### 阶层   1！=1*1   2！=2*1  3！=3*2*1   4！=4*3*2*1

#          1！     2！ =2*1！ 3！=3*2！   4！ =4 *3！


#推导式 ： n! = n * (n-1) !
#终止条件：  n == 1   return 1


def jie(n):
    if n ==1:
        return 1
    else:
        return jie(n-1) *n


def test12():
    print('12')
    
    def test13():
        print('13')
        
        def test14():
            print('14')
            
        return test14()
    
    return test13()






