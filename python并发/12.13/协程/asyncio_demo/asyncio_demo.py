# -*- coding:utf-8 -*-
import asyncio
'''
loop 事件循环
task 对协程的封装
'''

# #1、定义一个协程
# async def some(x):
#     print('par',x)
#
# loop = asyncio.get_event_loop()
# loop.run_until_complete(some(2))

# #2
# async def work(x):
#     print('par',x)
#     return 'Done!'
#
# loop = asyncio.get_event_loop()
# task = loop.create_task(work(2))
# print(task)
# loop.run_until_complete(task)
# print(task)

# #3 绑定回调
# async def work(x):
#     print('par',x)
#     return 'Done {}'.format(x)
#
# def callback(futrue):
#     print('Callback:',futrue)
#
# loop = asyncio.get_event_loop()  #创建事件循环
# task = asyncio.ensure_future(work(2))  # 创建task对象
# task.add_done_callback(callback)  #注册回调
# loop.run_until_complete(task)  #启动事件循环

# 4 并发
# async def work(x):
#     print('par',x)
#     await asyncio.sleep(2)
#     return 'Done!'
#
# async def main():
#     tasks = [
#         asyncio.ensure_future(work(2))
#         ,asyncio.ensure_future(work(4))
#         ,asyncio.ensure_future(work(6))
#     ]
#     done,_ = await asyncio.wait(tasks)
#     for task in done:
#         print(task)
#
# loop = asyncio.get_event_loop()
# loop.run_until_complete(main())

import aiohttp

async def get_response(url):
    print('请求')
    async with aiohttp.request('GET',url) as r:
        print('开始读取')
        print(await r.test())

url = 'https://www.qiushibaike.com'
loop = asyncio.get_event_loop()
tasks = [get_response(url) for i in range(5)]
loop.run_until_complete(asyncio.wait(tasks))