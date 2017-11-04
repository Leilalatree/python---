l2 = []
for i in range(20):
    if i%2 == 0:
        l2.append(i)


l3 = []
for i in range(0,20,2):
    l3.append(i)

l4 = list(range(0,20,2))

#列表推导式
l5 = [i for i in range(20)]

l6 = ['aa' for i in range(20)]

l7 = [i for i in range(20) if i%2 ==0]

l8 = [i for i in range(20) if i%2 ==1]

l9 = [i if i%2==0 else 'a' for i in range(20)]

s = {i for i in range(10)}

di = {i:'aaa' for i in range(5)}

l2 = iter(l2)
type(l2)

###生成器，本质也是迭代器
def fun():
    i = 0
    while i<5:
        print('***')
        yield i
        i+=1
        print('+++',i)


###模块和包

        ##模块

#内置模块
import keyword

