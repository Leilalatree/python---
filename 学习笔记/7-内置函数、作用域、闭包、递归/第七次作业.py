#python基础   第七次作业


#1.把老师上课例子都敲一遍（不需要截图，但是一定要做)
'''
|<<   >>|      鹏保宝播放器这两个按钮可以倍速播放  
'''


#2.定义一个函数，输入一个序列(序列元素是同种类型)，
#判断序列是顺序还是逆序，顺序输出UP，逆序输出DOWN，否则输出None
def fun(*arg):    
    li = list(arg)
    if(sorted(li)==li):
        print('顺序序列up')
    elif(sorted(li,reverse=True)==li):
        print('DOWN')
    else:
        print('None')


#3.写一个函数，对列表li2 = [9,8,3,2,6,4,5,7,1]，进行从小到大的排序。最后返回排序后的列表
li2 = [9,8,3,2,6,4,5,7,1]

def px(a):
    return sorted(a)
    
            


#4一个列表，有4个由数字组成的长度为4的元组，对这四个元组，
#按每个元组的第2个数字大小排序
li4 = [(6,2),(3,4),(7,8),(5,6)]

def s(a):
    return sorted(a,key=lambda x: x[1],reverse=True)
    



#5思考题：有一个名为list_apd的函数，
#如下所示，请你多次调用这个函数，对比返回值，是否与你预期的一致？
#想到什么写什么，可以空着
def list_apd(b,a=[]):
    a.append(b)
    return a


















