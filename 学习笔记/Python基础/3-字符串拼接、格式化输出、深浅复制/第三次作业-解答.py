#第三次作业

'''
split
join
format
%
'''

#1.a = '苦短' b = 'Python' 用4种方法，输出'人生苦短，我用Python'
a = '苦短'
b = 'Python'

#1.
print('人生'+a+',我用'+b)
#2.
print('人生%s，我用%s'%(a,b))
#3.
print(''.join(['人生',a,',我用',b]))
#4.
print('{}{}{}{}'.format('人生',a,',我用',b))


#2.列表li = ['I','like','python'],用2种方法，将列表转成字符串，输出'I like python'
li = ['I','like','python']
#1.
print(' '.join(li))
#2.
'{} {} {}'.format(li[0],li[1],li[2])
'{0[0]} {0[1]} {0[2]}'.format(li)
'%s %s %s'%(li[0],li[1],li[2])
 #  这里传入的是一个元组



#3. a=1.1，用3种格式，输出 a 的值： 字符串格式， 整型格式， （浮点型+带加号+靠右端）
a=1.1
#
'%s'%a
#2.
'%d'%a
#3.'%+20.1f'%a
