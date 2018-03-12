# -*- coding:utf-8 -*-

from http import client,server,cookiejar,cookies
from urllib import request,response,error,parse,robotparser
import time

start = time.time()
# response = request.urlopen('http://www.baidu.com')
# html = response.read()
# print(len(html))
# print(html.decode('utf-8'))

'''
post方法实现
'''
headers_baidu = {
    'connection':'keep-alive'
}
post_data = {
    'var1':'test'
}
url = 'http://www.baidu.com'
request_baidu = request.Request(url,headers=headers_baidu,data = post_data)
html = request.urlopen(request_baidu).read()

print(html.decode('utf-8'))


print("耗时：%s 秒" %(time.time() - start))