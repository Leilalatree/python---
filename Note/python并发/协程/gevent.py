# # -*- coding:utf-8 -*-
#
# #1.gevent   第三方协程库
# #2.asyncio
# import asyncio
# import requests
# from greenlet import greenlet
# #from gevent import monkey
# #  monkey.patch_all()  #猴子补丁
# import gevent
# import socket
# '''
# #python3.4版本
# @asyncio.coroutine  #把一个生成器标记为协程，然后可以把协程丢到事件循环
# def hello():
#     print('Welcome to async')
#     yield from asyncio.sleep(2)
#     print('byebye')
#
# loop = asyncio.get_event_loop()  #启动事件循环
# tasks = [hello(),hello()]
# loop.run_until_complete(asyncio.wait(tasks))
# loop.close()
# '''
#
# # async def test(i):
# #     print('test',i)
# #     await asyncio.sleep(1)
# #     print('test2',i)
# #
# # loop = asyncio.get_event_loop()
# # tasts = [test(i) for i in range(5)]
# # loop.run_until_complete(asyncio.wait(tasts))
# # loop.close()
#
# '''
#  IO很慢 gevent greenlet  遇到IO就切换到其他的greelet
#  多进程+ 协程
# '''
# #
# # def test1():
# #     print('11')
# #     gr2.switch()
# #     print('22')
# #
# # def test2():
# #     print('33')
# #     gr1.switch()
# #     print('44')
# #
# # gr1 = greenlet(test1())
# # gr2 = greenlet(test2())
# # gr1.switch()
# # gr2.switch()
#
#
# def get_ip():
#     print('start')
#     requests.get('https://www.baidu.com')
#     print('end')
#
# tasks = [gevent.spawn(get_ip(),n) for n in range(5)]
#
# gevent.joinall(tasks)