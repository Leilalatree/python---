#python基础，序列类型自带方法
'''
1.基本数据类型 int float bool  ccomplex
2.+ - * /  // %  **
3.序列类型 str  list  tuple
4.索引 、切片 、步长
5.赋值运算、 in  not in
6.可变  不可变  str  tuple

'''
#列表
li = ['a','b','c','e','d']
dir(li)  #查看对象的属性，和方法。
#help(li.append)  #相当于说明书

li.append('s') #追加的方式，添加到list最后
#li.clear()   #清空列表
l2 = li.copy()  #复制，但是生成了一个新的对象
li.count('a')   #统计出现次数
 
#iterable  可迭代的
li.extend('jianeng')  #必须传入可迭代的 对象，通过追加的方式，添加到list
 
li.index('a')   #返回list中，第一个元素出现的索引
li.insert(1,'p') #将元素插入到，指定的索引位子

li.pop()  #默认弹出最后一个元素  [ ],可写，可不写
li.pop(0) #也可以指定

li.remove('d') #指定删除
li.reverse()  #将list 反转

#(key=None, reverse=False)   默认参数，如果不传参数，就进行默认
li.sort() #默认按 ASCII排序
# key  是指定，按照某一种方法，进行排序。如果不指定，就进行默认ASCII
li.sort(key=len)


#元祖  不可变
tu =('a','b','c','d')
tu1 =1,2

tu.count('a')  #计数
tu.count('m')

tu.index('d')  #默认从整个元祖里面，搜索
tu.index('d',1,4)  #也可已指定范围，[1,4],左闭右开

#tu.index('m')   #没有找到，也会报错

tu = list(tu)
tu.pop()
tu = tuple(tu)


###字符串
s = 'i love python'

#统计str方法数
li = dir(s)
li.index('capitalize')
l2= li[33:]
len(l2)


s.count('o')
s.endswith('n') #如果字符串s以x结尾，返回True
s.startswith('i') #如果字符串s以x开头，返回True

s.find('p')   # 7
s.find('w')   # -1

s.index('p')  # 7
s.index('w')  # 报错

'''
s.isalpha ()  ：测试是否全是字母，都是字母则返回 True,否则返回 False.
s.isdigit () ：测试是否全是数字，都是数字则返回 True 否则返回 False.
s.islower () ：测试是否全是小写
s.isupper () ：测试是否全是大写
s.lower () ：将字符串转为小写
s.upper () ：将字符串转为大写 
'''
s.replace('p','b')  #替换、取代

'''
s.split()：返回一系列用空格分割的字符串列表
s.split(a,b)：a,b为可选参数，a是将要分割的字符串，b是说明最多要分割几个
-1  默认是全部
'''
s = 'sssabbbadddasss'

s.split('a')
s.split('a',2)


