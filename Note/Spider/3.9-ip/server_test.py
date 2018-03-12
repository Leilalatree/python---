#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time

__author__ = 'Terry'

import requests

# url = 'https://jiasule.v2ex.com/'
# # 测试服务器拒绝服务的阀值， 一般是 403 错误
# for i in range(99999999):
#     r = requests.get(url)
#     if r.status_code != 200:
#         print('第 %s 次访问异常：%s' % (i, r.status_code))
#         break
#     print('第 %s 次访问' % i)
    # time.sleep(.5) # 第一次不要延时

url = 'https://www.kuaidaili.com/free/inha/%s/'
# 测试服务器拒绝服务的阀值， 一般是 403 错误
for i in range(99999999):
    r = requests.get(url % (i+1))
    if r.status_code != 200:
        print('第 %s 次访问异常：%s' % (i, r.status_code))
        break
    if i > 2193:
        break
    print('第 %s 次访问' % i)
    time.sleep(.5) # 第一次不要延时


'''
        返回值一般为：
        183.207.226.9:9999
        120.197.85.171:33965
        120.198.230.55:80
        120.198.230.112:81
        118.194.217.134:80
        183.232.29.132:18204
        或者
        {
          "msg": "",
          "code": 0,
          "data": {
            "count": 10,
            "proxy_list": [
              "124.172.117.189:80",
              "219.133.31.120:8888",
              "183.237.194.145:8080",
              "183.62.172.50:9999",
              "163.125.157.243:8888",
              "183.57.42.79:81",
              "202.103.150.70:8088",
              "182.254.129.124:80",
              "58.251.132.181:8888",
              "112.95.241.76:80"
            ]
          }
        }
    '''
def get_proxy_ips():
    # 收费代理IP， 快代理 https://www.kuaidaili.com/
    orderid = '你付费后可以查看到的一个唯一的id值'
    num = 10 # 需要获取的代理ip和port的数量，
    url = 'http://dev.kuaidaili.com/api/getproxy?orderid=%s&num=%s' % ()
    r = requests.get(url)
    return r.text
