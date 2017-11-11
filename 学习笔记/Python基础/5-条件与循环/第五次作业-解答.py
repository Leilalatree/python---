第五次作业    控制流程

break      12345
continue   12345 789      

1.输出9*9 乘法口诀
for x in range(1,10):
    for y in range(1,x+1):
        print('%d×%d =' % (x,y),x*y,end=' ')
    print('')


2.help(enumerate)学习怎么使用enumerate.试着对prd_l1使用enumerate()这个内置函数。（提示：使用for
 循环）
prd_l1 = [
    ('小时包流量/小时',5),
    ('日包流量/日',10),
    ('月末嗨翻天10天10G',20),
    ('闲时流量1G',10),
    ('30元5个G',30),
    ('50元50个G',50),
]
for i in range(len(prd_l1)):
    print(i,prd_l1[i])
for i in enumerate(prd_l1):
    print(i)         
for i,info in enumerate(prd_l1):
    print(i,info)
 enumerate逼格提升利器
b=enumerate('abcdefg')




3.流量套餐订购小程序：1.运行程序后，提示输入你现有的话费余额。
                      2.输入余额后打印套餐列表，列表使用第二题的prd_l1。
                      3.用户可以根据套餐编号订购套餐，如果余额足够则打印出扣款金额和话费余额，
                        余额不够则提示用户余额不够。
                      4.在选择套餐编号时，用户可以通过输入e退出订购程序，退出时，打印出已订购套餐和余额。


prd_l1 = [
    ('小时包流量/小时',5),
    ('日包流量/日',10),
    ('月末嗨翻天10天10G',20),
    ('闲时流量1G',10),
    ('30元5个G',30),
    ('50元50个G',50),
]
shopping_l2 = []                        #用户已经购买的套餐
phone_fare = input('>>>输入话费余额：')  

if phone_fare.isdigit():
    phone_fare = int(phone_fare)            #str--》int
    while 1:                                #多次循环
        for index,info in enumerate(prd_l1):#打印出套餐列表
            print(index,':',info)
        user_want = input('输入需要订购的套餐编号：')
        if user_want.isdigit():             #str--》int
            user_want = int(user_want)      
            if user_want >= 0 and user_want < len(prd_l1): #判断用户输入（0到列表长度则进入循环）
                prd = prd_l1[user_want]                 #自己pirnt(prd)查看
                if prd[1]<= phone_fare:                 #判断余额，如足够加入shopping_l2列表，和完成扣款   
                    shopping_l2.append(prd)
                    phone_fare -= prd[1]
                    print('套餐订购成功，已支付金额%s元，您当前的话费余额是%s' % (prd[1],phone_fare))
                else:                                   #钱不够的情况
                    print('这点钱都不够你买个球啊，去用联通吧')
                    
            else:                                    #编号输入不是0-5的情况
                print('编号不存在，请输入正确的商品编号')
        elif user_want == 'e':                 #如果输入e，则打印已购买套餐和余额
            for p in shopping_l2:
                print(p)
            print('老铁，您当前话费余额是:', phone_fare)
            exit()                       #退出
        else:                            #编号输入不是0-5和e的情况   
            print('老铁，扎心了，输入不合法，请重新输入')

#
# 这个程序到此为止了吗？

            #目前只有一级菜单，而事实上10086短信可以给出N级菜单。
            #代码的重构，优化
            #这是面向过程。面向 对象编程的程序代码又是另一种风格
            
    






