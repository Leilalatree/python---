# -*- coding:utf-8 -*-
import urllib3

'''
基础用法
'''
# http = urllib3.PoolManager()
# resp = http.request('get','http://www.baidu.com')
# html = resp.data

'''
HTTPConnectionPool
'''
# http = urllib3.HTTPConnectionPool('www.baidu.com')
# resp = http.request('get','http://www.baidu.com')
# print(resp.data)

'''
代理，headers
'''
proxy = urllib3.ProxyManager('http://127.0.0.1:8888',headers={'connection':'keep-alive'})
r = proxy.request('GET','http://httpbin.org/robots.txt')
print(r.status)
print(r.data.encode('utf-8'))