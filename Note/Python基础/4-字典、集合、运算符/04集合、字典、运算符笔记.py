# 集合 字典  运算符
'''
1.字符串拼接 +  '%s'  join  format
2.格式化输出 %s  %d  %f  %o  %x  %e \n  \a  \b \t
3.深复制 浅复制，嵌套列表

'''
#集合 { }, 唯一，无序
'''
() tuple
[] list
{} set  dict
'''
se = {1,2,3,4}
se2 = {1,2,3,3,4}
se3 = {1,2,3,'d',4}
#se2[0]   因为集合是无序，所以不能索引

#set（）,相当于强制类型转换
se5 = set([1,2,3])
li = [1,2]
#se6 = {'a',li} #可变对象，不能成为集合的元素，破坏唯一性


###集合的运算  并  交  差 与非^
se1 ={1,2,3,4,5}
se2 = {4,5,6,7,'a'}
se1 | se2  #将两个 集合，拼接到一起，去掉重复部分
se1 | se2 | se3

se1 & se2  #取出相同部分

se1 - se2  #减去两个集合 共有的部分

se1 ^ se2  # 首先相等于将俩个集合并，然去掉重复部分

#集合常用方法
se.add(5)
se.clear() 
se.update(['a','b','c','d']) #同时可以添加多元素,
se.update((1,2,3,4))  #必须是可迭代对象
se.update('wsx')
#se.remove('jia')  #移除指定元素
se.pop()   #由于集合无序的，所以 pop 是随机弹出

# 空集合
s = set()

# 集合取值
se = list(se)   #可以转成list，然后用索引
se[0]

#集合 是可变的
se ={1,2,3}
se.add('jianeng')



#强制类型转换
#数值类型
a = int(1.1)
b = float(1)

c = bool(0)
c = bool(1)

d = complex(2)

li =[1,2,3]
tu =(1,2,3)
s ='abc'

li = list(tu)
li =list(s)
#li = list(1)  必须是可迭代对象

tu = tuple(li)
tu = tuple(s)
#tu = tuple(1) 必须是可迭代对象

s =str(li)   #"['a', 'b', 'c']"
s = str(tu)  #"('a', 'b', 'c')"   
s = str(1)



#字典   键值对  key - values
'''
1.无序   
2.key 唯一，不可变的
3.字典是可变对象

'''
# di[0]  无序 
di ={'a':2,'b':3,'c':4,'a':1} # key  唯一
#di6 = {li:55,'a':1} # key不可变的

#两种定义方式
di5 = {'a':1}
di3 = {1:2}

# 符合，命名规范 
di2 = dict(a = 1)
#di4 = dict(1 =2)

##字典取值,通过key
di['a']

##添加，修改。没有就添加，有 ：就修改
di['a'] =10
di['jianeng'] = 'jianeng'
di['jianeng'] = 5

####字典的自带方法
#di.clear()
di2 = di.copy()  #生成一个新的对象
di.fromkeys('asd')
di.fromkeys('asd',2)  

di.get('a')
di.get('d','not find')

di.items() #返回每一个键值对
list(di.items()) 
list(di.items())[0]

di.keys()
list(di.keys())


di.pop('a')   #指定弹出
di.pop('w','not find') #如果没有‘w’,就返回‘not find’


di.popitem() #随机弹出


di.setdefault('b',12)  #有，就你返回原来的value
di.setdefault('a',12)  #没有，就添加
 
di.update({'a':10,'jianeng':'jianeng'}) #有，就更新。没有，就添加

di.values()
list(di.values())



###3.运算符

a =1
b =1
a ==b
b =2
a == b

a != b
a>=c
a<=c

'a' in li
'd' not in li

a = 1
b =a
id(a),id(b)

a is b
b =2
a is b
a is not b

a == 1 and b==2  #  两个都必须是true
a == 1 or b==2  # 两个只要，一个是true
not a==1      # 去反


1+2-5*2/2%3
a==1 and not b==3






















