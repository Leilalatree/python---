#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json

from requests.cookies import RequestsCookieJar

__author__ = 'Terry'

import requests


DEFAULT_HEADERS = {
    'Connection': 'keep-alive',
    'Cache-Control': 'max-age=0',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
    'Upgrade-Insecure-Requests': '1',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.9'
}

s = requests.session()
s.verify = False
s.headers = DEFAULT_HEADERS

# requests的cookies对象
jar = RequestsCookieJar()
file = 'sina_cookies.txt'
with open(file, 'r') as f:
    cookies = json.load(f)
    for cookie in cookies:
        # jar.set(cookie['name'], cookie['value'], path=cookie['path'], domain=cookie['domain'])
        jar.set(cookie.pop('name'), cookie.pop('value'))

url = 'https://weibo.cn/?tf=5_009'
#  一定记得要把cookies应用进去！！！！！！！！！！！！！！！！！！！！！！！！
r = s.get(url, cookies=jar)
# r.encoding = 'UTF-8'
# print(r.text)  # 有显示 登录的用户名，证明登录成功！后续可以自由访问页面

# url= '想要访问的weibo的页面，'
# s.get(url)