# -*- coding:utf-8 -*-

'''
1 迭代
2 可迭代对象
3 迭代器
'''
#
# def func(max):
#     n,a,b = 0,0,1
#     while n<max:
#         r = yield
#         print(r)
#         a,b = b,a+b
#         n += 1
#
# a = func(5)
# a.send(None)
# for i in range(5):
#     try:
#         a.send(i)
#     except StopIteration:
#         pass

'''
python协程
1、yield/send
2、@asyncio.coroutine    /yield from
3、async /await
'''

#yield from == fro item in iterable:yield item
'''
def f_write():
    tally = 0
    while True:
        nex = yield 5
        if nex is None:
            return tally
        tally += nex

def add_tallist(tall):
    while True:
        tal = yield from f_write()
        tall.append(tal)

tall = []
acc = add_tallist(tall)
next(acc)

for i in range(4):
    print(acc.send(i))

acc.send(None)
print(tall)
'''

class SpanException(Exception):
    pass

def write():
    while True:
        try:
            w = yield
        except SpanException:
            print('*****')
        else:
            print('>>',w)

def write_wrapper(g):
    yield from g
    '''
    # yield from 等价于下面代码
    g.send(None)
    while True:
        try:
            try:
                x = yield
            except Exception as e:
                g.throw(e)
            else:
                g.send(x)
        except StopIteration:
            pass
    '''
w = write()
wrap = write_wrapper(w)
wrap.send(None)

for i in range(5):
    if i == 3:
        wrap.throw(SpanException)
    else:
        wrap.send(i)