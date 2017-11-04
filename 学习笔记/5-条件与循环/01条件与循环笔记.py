#条件语句 与循环语句
'''
1.集合 se={1,2,3}  se =set(),交 & 并 |  差 -。特性：唯一，无序，可变
2.字典 di ={1:3}  di = dict(a=2) 特性：无序，键唯一，字典可变
3.运算符

python基本数据类型
1.
数值类型，数值运算，
序列 str  list  tuple
2.
序列自带方法 str 13  list 14  tuple 2
3.
字符串的拼接 4，格式化输出，深浅复制  import copy  copy.deedcopy（）
4.
集合 se={1,2,3}  se =set(),交 & 并 |  差 -。特性：唯一，无序，可变
字典 di ={1:3}  di = dict(a=2) 特性：无序，键唯一，字典可变
运算符
'''
#条件语句
'''
需求: 1.年龄大于12岁，卖成人票。年龄大于60，就不需要买票
      2. 4-12 ，儿童票
      3.0-3 ，不买票
'''
# &  and  or

##a = 15
##
##b = input('请输入：')  #接收的内容会变成字符串
##b = int(b)
##
##a = b
###1
##if a>=12:
##   print('你好先生，您需要购买成人票')  #1
##elif a>=4 and a<12:
##    print('您好小朋友，您需要购买儿童票') #2
##else:
##    print('你好baby，您不需要买票') #3



# 随机数
import random
r =random.randint(0,100)
print('随机数',r)
a = r


# 2   60
if a>=12:
    if a>=60:
        print('您好，你的年龄 %s，不需要买票'%a) #4
    else:
        print('你好先生 %s，您需要购买成人票'%a)  #1
elif a>=4 and a<12:
    print('您好小朋友 %s，您需要购买儿童票'%a) #2
else:
    print('你好baby %s，您不需要买票'%a) #3

## pass  占位，什么事都不做
a = 1
b = 2

if a>b:
    pass
elif a<b:
    pass
else:    # =
    pass

if a>b:
    print('a大于b')
elif a<b:
    print('a小于b')
else:    # =
    print('a等于b')


####循环语句  while   for 

#while
''' 
while True:    #死循环
    print('hello')

'''
a = 1
while a<5:    #写while 循环的时候，一定要写一个终止条件
    print('hello',a)
    a = a+1

print('=========break==========')
##break   强行终止 循环 ,相当于 Ctrl +c
b = 0
while True:    #死循环
    print('hello',b)
    if b>5:    # 0
        break
    b +=1

print('=========continue==========')
##continue 跳过本次循环，进入下一个循环
#打印出10以内的奇数
m = 0
while m <10:
    m += 1
    if m%2 ==0:
       continue
    print(m)


###for 循环    

range(10)  #范围  左闭右开
list(range(10))
list(range(5,10))
list(range(5,10,2))

print('=========for==========')
for i in range(10):
    print(i)
    
#列表
li =['a','b','c']
for f in li:
    print(f)

#字符串
for s in 'abcdefgh':
    print(s)

    
#字典
di ={'ai':1,'bi':2,'ci':3}
for d in di:  #遍历迭代对象
    print(d)
    print(di[d])

###注意

for f in li:
    print(f)
    f =100
    print(f)

##for  10 奇数

for i in range(1,11):  #for自动结束，while自己写终止条件
    if i % 2 ==0:
        continue
    print(i)

### 嵌套循环，5小组，每个8位同学
for i in range(5):
    print('第 %s小组'%(i+1))
    for j in range(8):
        print('第 %s小组,第 %s同学'%((i+1),(j+1)))


for i in range(5):
    print('第 %s小组'%(i+1))
    n=1
    while n<=8:
        print('第 %s小组,第 %s同学'%((i+1),n))
        n +=1



#else  只有正常结束的循环，非break结束的循环才会执行else部分

a =0
while a<10:
    print(a)
    a +=1
else:
    print('while 循环正常结束')

b =0
while b<10:
    print(b)
    b +=1
    if b>5:
        break
else:
    print('while 循环正常结束')


#for
for i in range(10):
    print(i)
else:
    print('for 正常结束')


for i in range(10):
    print(i)
    if i>5:
        break
else:
    print('for 正常结束')




print('aaaaa',end='')
print('bbbbbbb')

print('aaa',1)
print('aaa',1,sep='*********')










