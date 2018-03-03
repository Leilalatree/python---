# -*- coding:utf-8 -*-

from requests.cookies import RequestsCookieJar
import requests

'''
1 基础用法
'''
# url = 'http://httpbin.org/'
# r = requests.get(url)
# print(r.text)

'''
2 提交get参数
'''
# payload = {
#     'key1':'value1',
#     'key2':'value2'
# }
# r = requests.get('http://httpbin.org/get',params=payload)
# # 等价于 r = requests.get('http://httpbin.org/get?key1=value1&key2=value2')
# print(r.text)  #打印的是一个字符串，符合json语法
# print(r.json()) #打印的是json对象
'''
3 json转换字符串
    data = {'k':'v'}
    json.dumps(data)

 字符串转json
    s = {'k':'v'}
    j = json.loads(s)
'''

'''
4 取消自动跳转，302的跳转 allow_redirects = False
'''
# r = requests.get('https://github.com',allow_redirects = False, verify = False)
# print(r.status_code)
'''
5 提交headers
'''

'''
6 response状态码
'''
# r = requests.get('http://httpbin.org/')
# if r.status_code == 200:
#     print('成功')
# else:
#     print('失败')

'''
7 使用session
'''
# s = requests.session()
# r = s.get('http://httpbin.org/')
# # r = requests.get('http://httpbin.org/')
# print(r.status_code)

'''
8 cookie 子域可以访问父域 子目录可以访问父目录 反之不行
'''

'''
9 编码
'''
r = requests.get('http://httpbin.org/')
print(r.encoding)

# r.content返回的是'/b'
content = r.content
print(content)
print(content.decode('utf-8'))