


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











#题2
'''
今天学习了正则表达式，请以所学的知识完成以下要求：
(1)请写出python的变量命名规则    
(2)'00\d'可以匹配 001,002,003等等，
   '\d\d\d'可以匹配010,999,998,666等三位数
    请写出一个正则表达式，它可以匹配python合法的变量名
[a-zA-Z\_][0-9a-zA-Z\_]*
[a-zA-Z\_][\w]*
'''
##import re
##from keyword import kwlist
##
##while 1:
##    arg = input('输入你想要的变量名>>')
##    get = re.match(r'[a-zA-Z\_][0-9a-zA-Z\_]*',arg)
##    if arg in kwlist:
##        print('变量名不可以使用关键字')
##    elif arg=='':
##        print('请重新输入>>')
####    elif arg[0].isdigit():
####        print('变量名第一位不可为数字')
##    elif get:
##        print('你比王晶还棒,此变量名可用')
##    else:
##        print('%s 不可作为变量名，请重新输入>>' % arg)
##
##








#题3
'''
\
请定义一个类(class),满足以下要求：
    1.这个类，必须含有字符串所有的方法。
    2.这个类有一个统计方法：
        统计输入字符串里，英文字母、空格、数字和其他字符分别出现次数，
        返回值为包含元祖的列表，格式如下：
        参数'delete'
        返回值：
        (对返回值列表中元祖的顺序无要求)
string.capwords

'''
class sel_str(str):
    def __init__(self,strs):
        self.strs = strs

    def counts(self):
        leter,space,num,other = 0,0,0,0
        for i in self.strs:
            print(i)
            if i.isalpha():
                leter += 1
            elif i == ' ':
                space += 1
            elif i.isdigit():
                
                num += 1
            else:
                other += 1
        dic ={'leter':leter,'space':space,'num':num,'other':other }
        dic = list(dic.items())
        return dic

import re
def counts2(strs):
    leter = len( re.findall(r'[a-zA-Z]',strs) )
    num = len(re.findall(r'\d',strs))
    sep = len(re.findall(r'\s',strs))
    other = len(strs) -leter - num - space
    dic ={'leter':leter,'space':space,'num':num,'other':other }
    return dic

def counts(self):
        leter,space,num,other = 0,0,0,0  #a=b=c=d=0
        for i in self.strs:
            print(i)
            if i.isalpha():
                leter += 1
            elif i == ' ':
                space += 1
            elif i.isdigit():
                num += 1
            else:
                other += 1
        dic ={'leter':leter,'space':space,'num':num,'other':other }
        dic = list(dic.items())
        return dic
##a=[1,2,3]
##b=[11,22,33]
##list(zip(a,b))

#题4
'''
猴子第一天摘下N个桃子，当时就吃了一半，还不过瘾，就又多吃了一个。第二天又将剩下的桃子吃掉一半，又多吃了一个。
以后每天都吃前一天剩下的一半零一个。
到第10天在想吃的时候就剩一个桃子了,
问第一天共摘下来多少个桃子？
(提示:递归函数)>>>>1534
1 2 3 4 5 6 7 8 9 10
10 9 8 7 6 5 4 3 2 1
1 4 10 22 46 94 190 382 766 1534


'''

def eat(day):
    first =0
    last = 1
    while day>1:
        first = (last+1)*2
        last = first
        day =day -1
    print(first)


def eat2(day):
    if day == 1:
        return 1
    else:
        return (eat2(day-1)+1)*2


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
i.e.   id est换言之
e.g.  exempli gratia  举个例子
'''
def titles(strs):
    li = strs.split()
    title=[]
    for i in li:
        print(i)
        i = i.capitalize()
        title.append(i)
    title =' '.join(title)
    return title

def tt(strs):
    a1=strs.split(' ')
    a2 = list(map(lambda x:x.capitalize(), a1))
    return ' '.join(a2)
##def niming(x):
##    return x.capitalize()
##''.join(list(map(niming, str)))

# def titles(s)   ret   ' '.join(i.capitalize() for i in s.split())




#题6
'''
现有一个列表，其中有10个元素，元素均为int类型，列表内的数据是无序。
现在要求我们通过编程将这列表变成一个从小到大排序的列表
请用自己的代码完成。
1.从第一位开始比较相邻的两个元素。如果前者比后者大（由小到大排序），那么我们就交换它们。 
2.针对每一个两两相邻的元素都做比较操作。直到把所有元素比较完。这个时候最后一个元素是最大值。 
3.此时我们在从头比较，重复第二步的操作，直到比较出倒数第二大的元素。 
4.以此类推知道所有的元素全部比较完成，这样从小到大序列即排序完成。
'''


def bubbleSort(nums):
    for i in range(len(nums)-1):    # 这个循环负责设置冒泡排序进行的次数
        for j in range(len(nums)-i-1):  # ｊ为列表下标
            if nums[j] > nums[j+1]:
                nums[j], nums[j+1] = nums[j+1], nums[j]
        #print(nums)
    return nums








#题7
'''
1.写一个猜数字的游戏，要求：系统生成一个随机数（1-10），用户输入数字去猜。
如果输入数 小了 或者 大了，都给于相应提示。如果输入数 与 随机数相等，就提示“ 恭喜您猜对了!”
'''
#版本1
 
##import random
##n = random.randint(1,10)
##print(n)
##
##a =input('请输入 1-10：')
##a = int(a)
##
##if a>n:
##    print('大了！')
##elif a<n:
##    print('小了！')
##else:
##    print('恭喜您猜对了')
 
 
 
##版本2
##import random
##n = random.randint(1,10)
##print(n)
##c = 0
##while c<3:
##    a =input('您还剩 %d 次机会，请输入 1-10：'%(3-c))
##    if a.isdigit():
##        
##        a = int(a)
##        if 0<a<=10:
##        
##            if a>n:
##                print('大了！')
##            elif a<n:
##                print('小了！')
##            else:
##                print('恭喜您猜对了')
##                break
##        else:
##            print('输入有误')
##    else:
##        print('输入有误')
##    c +=1

?



