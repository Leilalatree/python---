#1 将老师上课的例子，自己去运行一遍。


#2.利用列表推导式: 找出100以内所有奇数，并将所有奇数乘以3，写入列表。
#   不能被2整除，  i%2 = 0    i%2 == 1  5/2 

li =[i*3 for i in range(101) if i%2 !=0]
li2 = [i*3 for i in range(1,101) if i%2 ==1]

##for i in range(1,101):
##    if i%2 ==1:
##        print(i*3)





#3.在一个模块中定义一个用生成器，这个生成器可以生成斐波拉契数列，
#  再另一个模块中使用这个生成器，得到斐波拉契数列

#fib: 0,1,1,2,3,5,8   a,b = b,a+b      0,1,1,2,3  0,1这个数列从第三项开始，每一项都是前两项之和
   
##def fab(num):
##    n,a,b = 0,0,1
##    while n < num:
##        yield b
##        a,b = b,a+b
##        n+=1
##




#同目录下的情况  直接import 模块名


#不同目录情况下 如何导入模块     improt sys    sys.path.append(r'路径')
import sys
sys.path.append(r'E:\16班基础')


#python是如何寻找这些模块的位置的？  import fab
'''
1.当前目录下。
2.环境变量中的地址   python/scripts  python/  
'''
 

##为什么有的是 fib() 有的是fib.fib()    fab.fab()--->  improt fab
##                                    fab()  --> from fab import fab
##
##

