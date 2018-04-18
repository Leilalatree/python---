def what():
    print('*----------数据结构与算法----------*')
what()
'''
一.	桶排序（最快最简单的排序）
桶排序的基本思想是将一个数据表分割成许多buckets，然后每个bucket各自排序，或用不同的排序算法，或者递归的使用bucket sort算法。也是典型的divide-and-conquer分而治之的策略。它是一个分布式的排序，介于MSD基数排序和LSD基数排序之间

1、桶排序是稳定的
2、桶排序是常见排序里最快的一种, 大多数情况下比快排还要快
3、桶排序非常快,但是同时也非常耗空间,基本上是最耗空间的一种排序算法
'''
def bucketSort(nums):
    # 选择一个最大的数
    max_num = max(nums)
    # 创建一个元素全是0的列表, 当做桶
    bucket = [0]*(max_num+1)
    # 把所有元素放入桶中, 即把对应元素个数加一
    for i in nums:
        bucket[i] += 1
    # 存储排序好的元素
    sort_nums = []
    # 取出桶中的元素
    for j in range(len(bucket)):
        if bucket[j] != 0:
            for y in range(bucket[j]):
                sort_nums.append(j)

    return sort_nums
nums = [5,6,3,2,1,65,2,0,8,0]
print('桶排序')
print(bucketSort(nums))
'''
二.	斐波那契数列
斐波那契数列：简单地说，起始两项为0和1，此后的项分别为它的前两项之和。
'''
def fibo(num):
    numList = [0,1]
    for i in range(num - 2):
        numList.append(numList[-2] + numList[-1])
    return numList
print('斐波那契')
print(fibo(10))
'''
三. 杨辉三角
'''
def triangles():
    a = [1]
    while True:
        yield a
        a = [sum(i) for i in zip([0] + a , a + [0])]
n=0
print('杨辉三角')
for t in triangles():
    print(t)
    n=n+1
    if n == 5:
        break
'''        
四.	排序算法的分析
排序算法的稳定性：如果在对象序列中有两个对象r[i]和r[j] ,它们的排序码k[i]==k[j] 。如果排序前后,对象r[i]和r[j] 的相对位置不变，则称排序算法是稳定的；否则排序算法是不稳定的。
时间开销：排序的时间开销可用算法执行中的数据比较次数与数据移动次数来衡量。
算法运行时间代价的大略估算一般都按平均情况进行估算。对于那些受对象排序码序列初始排列及对象个数影响较大的，需要按最好情况和最坏情况进行估算
空间开销：算法执行时所需的附加存储。
'''

'''
五.	冒泡
冒泡排序的思想: 每次比较两个相邻的元素, 如果他们的顺序错误就把他们交换位置。
'''
def bubble_improve(l):
    print('排序以前：',l)
    flag = 1
    for i in range(len(l) - 1, 0 , -1):   #倒着取 len(l)-1 = 5 取  5 4 3 2 1
        if flag:
            flag = 0
            for j in range(i):
                if l[j] > l[j + 1]:
                    l[j], l[j + 1] = l[j + 1], l[j]
                    flag = 1
        else:
            break
    print('排序以后：',l)
l = [10, 20, 40, 50, 30, 60]
print('冒泡排序')
bubble_improve(l)

'''
六.	快排
快速排序使用分治法策略来把一个序列分为两个子序列。
步骤：
从数列中挑出一个元素，称为 "基准"（pivot），
重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分割结束之后，该基准就处于数列的中间位置。这个称为分割（partition）操作。
递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
'''
def quickSort(alist,first,last):
   if first<last:
       splitpoint = findpos(alist,first,last)
       quickSort(alist,first,splitpoint-1)
       quickSort(alist,splitpoint+1,last)
def findpos(lists, low, high):
    key = lists[low]
    while low < high:
       while low < high and lists[high] >= key:
           high -= 1
       lists[low] = lists[high]
       while low < high and lists[low] <= key:
           low += 1
       lists[high] = lists[low]
    lists[low] = key
    return low
alist = [54,26,93,17,77,31,44,55,20]
quickSort(alist,0,8)
print('快速排序')
print(alist)