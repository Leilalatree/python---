#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import random

__author__ = 'Terry'

from selenium import webdriver
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
import time

#打开浏览器
driver = webdriver.Firefox()

driver.set_page_load_timeout(10)
driver.set_script_timeout(10)
driver.set_window_size(1366, 768)


'''
    访问目标网站的一个页面，不访问的话，进行add_cookie时，会报：
    selenium.common.exceptions.InvalidCookieDomainException: Message: Document is cookie-averse
    cookie中有domain，会出现如下错误：
    selenium.common.exceptions.InvalidCookieDomainException: Message: .weibo.cn
'''
driver.get('https://weibo.cn/')

file = 'sina_cookies.txt'
with open(file, 'r') as f:
    cookies = json.load(f)
    for cookie in cookies:
        cookie.pop('domain')
        driver.add_cookie(cookie)

url = 'https://weibo.cn/?tf=5_009'
driver.get(url)

# 需要手动退出driver
driver.quit()

print('over')