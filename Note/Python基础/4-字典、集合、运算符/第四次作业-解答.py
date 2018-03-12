#python基础 第四次作业

#1.有两个列表 x = [1,2,3,'a','b','c']  y = ['a','b','c'] 找出x列表中在y 中也有的元素

#a
#print(x and y)
#b
'''
x = [1,2,3,'a','b','c']
y = ['a','b','c']
a = set(x)
b = set(y)
c = a & b
'''

#2.新建一个字典，用3种方法往字典里面插入值；用 4 种方法取出values，用2种方法取出key
dic={"a":1,'b':2}
##dic['c']=3
##dic.update({'d':4})
##dic.setdefault('e',5)
##
##dic['a']
##dic.get()
##dic.setdefault('e',5)
##list(di.values())[0]
##list(di.items())[1][1]
##dic.pop()
##dic.pop(item()
##
##list(dic)
##list(dic.keys())
##list(dic.items()) [0][0]       



#3.定义我们学过的每种数据类型，并且注明，哪些是可变，哪些是不可变的.
#  试着写一个嵌套字典，和一个嵌套集合，内容随意。

'''id不变的情况下 改变值'''
'''
1,1.2,True,1+2j,'a',[1,2],(1,),{'a':1},{1,2,3}
print(type(a),type(b),type(c),type(d),type(e),type(f),type(g),type(h),type(i))'''


#s4 = set((1,[2,3]))

#4.s1 = set(1,2,3)，s2 = set(1,[2,3]) ， s3 = set([1,2,3])
# 声明这3个变量，为何有的会报错？分析结果，解释出现这种结果的原因。

'''
1.只能给出一个参数
2.必须是可迭代对象
3.元素的唯一性
'''




