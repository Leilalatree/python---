# 正则、re模块 
#回忆
'''
1.列表推导式  li = [i for i in range(10)]
    迭代器 __iter__  __next__、
    生成器 yield。 next()  __next__()。 暂停
2. 模块 、 包
    py文件。 import , from random import randint
    第三方模块： 同目录， import
                不同目录  sys.path.append()  -> import
    包, 多个py文件

'''


# 正则 （不是python特有的）  匹配字符串

##需要，输入字符， 判断字符串有无python
'''
a = input('输入：')
b = 'python'
if b in a:
    print('OK')
else:
    print('NO')
'''


import re
'''
a = input('输入：')
b  = re.search('python',a)  # 搜寻匹配，匹配到第一个
if bool(b) == True:
    print('OK')
else:
    print('NO')
'''



#例子  需求：判断QQ  （5-11） 位

qq = input('输入QQ：')
b = re.search('[0-9]{5,11}',qq)  # ( 规则， 对象 )
if b:
    print('OK')
else:
    print('NO')




## 1.元字符  (有了特殊意义)
' .   ^   $   *   +   ?   {}  []   \   |   () '

# .  匹配除换行符之外的所有的字符

re.search('.','asdfbdf')
re.search('.','\nsdfbdf')

# \d  匹配0~9的数字 
re.search('\d','df1sdf2')   #  
re.findall('\d','df1sdf2')  #查询所有，返回list

# \s  匹配任意的空白符，包括空格，制表符(Tab)，换行
re.findall('\s',' \n \t aaasss')

# \w 匹配字母或数字或下划线或汉字等
re.findall('\w','ad我_55-+%?')

#\b  # 表示单词的边界 : 特殊字符  空格  末尾
re.findall('\bapple\b','apple apple') ## 不会匹配， 
re.findall(r'\bapple\b','apple apple') # r 取消字符串的传义



#  \.   正则里面 如何取消转义

re.search('\.','asdfbdf')   #取消 元字符的转义  <_sre.SRE_Match object; span=(7, 8), match='.'>
re.findall(r'\\b',r'apple++\b')    # ['\\b']


#\D、\S、\W、\B # 是与小写的相反的作用 

#\D  \d
re.findall(r'\D','123abc')    #['a', 'b', 'c']
re.findall(r'\S','\t \n aaa')  #['a', 'a', 'a']
re.findall(r'\W','\t \n aaa')   #['\t', ' ', '\n', ' ']
re.findall(r'\Baa\B','\t \n aa aaaaa')  #['aa']



#^   # 脱字符 匹配输入字符串的开始的位置
re.findall(r'^abc','abcefg')


#$  匹配输入字符串的结束位置
re.findall(r'g$','bcefg')



##匹配次数  {M,N}
re.findall(r'\d{1,3}','22bc44ef555g1')  #['22', '44', '555', '1']

#{M，}  表示需要匹配M次 以上
re.findall(r'\d{2,}','22bc44ef555g1')


#{，N}   0-N
re.findall(r'\d{,2}','22bc44ef555g1')  #匹配次数为0,末尾加一个None
#['22', '', '', '44', '', '', '55', '5', '', '1', '']


#  {N}     # 表示需要匹配N次
re.findall(r'\d{2}','22bc44ef555g1')
#['22', '44', '55']



#  * 表达式零次或多次，等价于{0，}
re.findall(r'\d*','22bc44ef555g1')
['22', '', '', '44', '', '', '555', '', '1', '']


# +  匹配前面的子表达式一次或多次，等价于{1，}
re.findall(r'\d+','22bc44ef555g1')
#['22', '44', '555', '1']


#?   匹配前面的子表达式零次或一次，等价于{0,1}
re.findall(r'\d?','22bc44ef555g1')
#['2', '2', '', '', '4', '4', '', '', '5', '5', '5', '', '1', '']




######不要 次数混着用

# *？、+？、{n,m}?

#*？
re.findall(r'\d*?','22bc44ef555g1')  # 0次

#  +？
re.findall(r'\d+?','22bc44ef555g1')
#['2', '2', '4', '4', '5', '5', '5', '1']



#{n,m}?   #取小值
re.findall(r'\d{2,3}?','22bc44ef555g1')
#['22', '44', '55']




#子组匹配   [ ] ， 只要满足任何一个，就可以匹配
re.findall(r'[a-zA-Z]','fff2mi4AZ') #所有字母

re.findall(r'[a-zA-Z\d]','fff2mi4AZ') #所有字母 、数字

re.findall(r'[a-zA-Z\d]{2}','fff2mi4AZ')  

## [] 里面 存在 ^,  代表取反
re.findall(r'[^a]','abc')  # 非a


# | 或
re.findall(r'b|a','abc')
re.findall(r'[ba]','abc')


#分组 （）
re.findall(r'(abc)','abc bac kkk')

re.findall(r'(abc)*','abc bac abcabckkk')
#['abc', '', '', '', '', '', 'abc', '', '', '', '']





##2.re模块

#re.compile()  # 编译正则表达式为模式对象
a = re.compile(r'\d')
a.findall('123kk444')



#match()   判断一个正则表达式是否从开始处匹配字符串,相当于^

re.match(r'\d','b123a')
print(re.match(r'\d','b123a'))


#search()      # 遍历字符串，找到正则表达式匹配的第一个位置
re.search(r'\d','b35f3')
re.findall(r'\d','b35f3')

#sub()         # 替换 类似于字符串中 replace() 方法

re.sub('i','o','pythin pythin pythin pythin') #默认替换所有
re.sub('i','o','pythin pythin pythin pythin',3)
re.sub('\d','a','psdf234546567')


#查看匹配对象中的信息
c = re.search(r'\d','b35f3')
c.group()
c.start()
c.end()
c.span()



