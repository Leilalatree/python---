#1  判断1 - 100 内能够被 3 和 5 整除的数，用while和for循环来做

##for i in range(1,101):
##    if i % 3 == 0 and i % 5 ==0:   #同时被3和5整除
##        print(i)

##i=1
##while i <= 100:
##    if i % 3 == 0 and i % 5 ==0:
##        print(i)
##        i+=1

##
##a=0
##if a <5:
##    print(a)
##    a+=1
##
##
##
##
##a=0
##while a <5:
##    print(a)
##    a+=1

#2.定义一个函数，必须包含4种参数形式，然后打印这4个参数，最后返回'OK'。
def test(a,b=1,*arg,**kwarg):      
    print(a)
    print(b)
    print(*arg)
    print(**kwarg)
    return 'ok'   
##test(1)  # test(1,b=1)
##test(1,2)   #test(1,b=2)
##test(1,b=2)

##test(b=2,1)     #默认参数不能放到必备参数前面


def t1(*arg,a,b=1,**kwarg):      
    print(arg)
    print(*arg)
    print(a)
    print(b)
    print(kwarg)
    
    return 'ok'

##t1(1,2,3,4,56)  #缺a
#t1(1,2,3,b=1,998)
#t1(1,2,3,b=1,a=998)   #当可变参数（*arg）在前面的时候，默认参数b是可以放到必备参数a前面的（必须带上参数名a=998）


##t1(1,2,3,b=1,a=998,**({'xx':1, 'yy':2}))   #a=1 b=2
##t1(*(1,2,3),b=1,a=998,**({'xx':1, 'yy':2})) 

#3.定义一个函数，能够输入字典和元组。将字典的值(value) 和 元组的值交换，
#  交换结束后，打印并且返回 字典和元祖。
'''
字典和元组的长度，dict的key， a,b=b,a
'''

def exchange(*args,**kwargs):
    tu = list(args)
    dic = kwargs
    print(tu,dic)
    j=0                            #元组的索引值
    if len(dic) <= len(tu): # 字典len小于或者等于tu的情况下
        for i in dic:                #  遍历字典的key（键）--》i
            print(i,dic[i],tu[j])
            dic[i],tu[j] = tu[j],dic[i]
            j+=1
    else:              #当字典元素多于元组时，执行以下代码
        k=0
        while k < len(tu):
            for i in dic:
                dic[i],tu[k] = tu[k],dic[i]
            k+=1
    tu = tuple(tu)
    print(tu,dic)








##明天是正式课
##下周开始  1,3,5,  解答课
##        2,4,6    正式课
##        在解答课上课当天晚饭之前交过来。
##1.函数命名规则
##2.命名关键字参数。

