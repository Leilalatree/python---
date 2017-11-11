#文件的输入输出，异常
#回顾
'''
1.多继承 ：1.类名调用   2.super
2.魔法方法，(__init__)
3.装饰器 @
4.类装装饰器， property   staticmethod  classmethod
'''

#1.文件

####打开

#open()
'''
r 只读模式，文件不存在时会报错。
w 写入模式，文件存在会清空之前的内容，文件不存在则会新建文件。
x 写入模式，文件存在会报错，文件不存在则会新建文件。
a 追加写入模式，不清空之前的文件，直接将写入的内容添加到后面。
b 以二进制模式读写文件，wb,rb,ab。
+ 可读写模式，r+,w+,x+,a+,这几种模式还遵循了r,w,x,a的基本原则。


'''
"f = open('test.txt','r') "

" f = open('test.txt','w') "

## 默认建立在当前目录


###  绝对路径    E:\16班基础\5高级专题  ##贾转义  r

" f = open(r'E:\16班基础\5高级专题\test.txt','w') "
" f = open('E:\\16班基础\\5高级专题\\test.txt','w') "

path = r'E:\16班基础\5高级专题\test.txt' 

" f = open(path,'w') "


# <class '_io.TextIOWrapper'>  文件类 / 流类


### 操作
'''
打开 ，关闭  ，写入 ，读取

'''
" f = open('test.txt','w')  "  #以写的方式

##  +  可读写,  在原来的基础上，多加加了项  读写功能
" f = open('test.txt','w+')  "

" f = open('test.txt','r+')  "


###  read 操作

"f.read() " #将文件所有内容， 以字符串返回  ，一个



### f.readline()   返回每一行  
" f.readline() "







##引入  文件指针  （光标）
##tell   seek
" f.tell()  "  #告诉光标的位置
"f.seek(0) "   #重置光标位置



#汉字占两个字节
'''
编码问题:
 cp936  =  GBK  (中文编码)， 2字节
 UTF-8  国际编码    3字节
'''


#readlines

" f.readlines()"  #列表方式返回 ，（str）
#li = f.readlines()
'''
for i in li:
    print(i)

'''





### 写 write

''' 
f.write('jianneg')  #缓存
 f.flush()       #将缓存 写入  硬盘
'''


#writelines()
li =['jianeng','python','6666','rng']
#f.writelines(li)

#li =['jianeng','python','6666','rng',12] #不能有数字


###文件  属性

#f.closed
#f.mode
#f.name
#f.encoding

#8.with 形式打开文件，里面的语句执行完后会自动关闭文件
'''
 with open('test.txt','w+') as f:
	f.write('haha')
'''


##close  的时候，自动flush


#2.异常语法,  （为了让错误，不影响程序运行）（如果报错了，选择性的弥补）


try:
    b = 3
    d = 2
    b % d   # NameError
except TypeError:      #同级
    print('你的类型错误')
except NameError:
    print('没有定义')
except ValueError:
    print('值错误')
except Exception:
    print('b % d，报错了')

else:   #当try 里面没有  报错，就执行 else
    print('没有问题')

finally:
    print('不管你报不报错，我都要执行')


try:
    f = open('test.txt','w')
    f.read()
except Exception:
    print('文件操作有误')
finally:
    f.close()



print(f.closed)

a = 1


#  raise   故意报错，显性的引发异常

try:
    a = input('输入数字: ')
    if a.isdigit():
        print('输入成功',a)
    else:
        raise TypeError    #报错，TypeError
    
except TypeError:
    print('类型错误') 
except Exception:
    print('您输入有误')










# assert #断言   返回False 就弹出异常

'''
assert 1>2
assert isinstance(1,(str,int))
assert isinstance(1,(str,float))

'''













