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

# 设置10秒页面超时返回，类似于requests.get()的timeout选项，driver.get()没有timeout选项
# 以前遇到过driver.get(url)一直不返回，但也不报错的问题，这时程序会卡住，设置超时选项能解决这个问题。
driver.set_page_load_timeout(10)

# 设置10秒脚本超时时间
driver.set_script_timeout(10)

driver.set_window_size(1366, 768)

# 访问新浪移动端，没有验证码
driver.get('https://passport.weibo.cn/signin/login?entry=mweibo&res=wel&wm=3349&r=http%3A%2F%2Fm.weibo.cn%2F')

WebDriverWait(driver, 30, 1).until(EC.presence_of_element_located((By.XPATH, '//*[@id="loginName"]')))

print(driver.title)

time.sleep(1)

user = driver.find_element_by_xpath('//*[@id="loginName"]')
# 清楚当前input元素中的值
user.clear()
# 在input元素中输入内容
user.send_keys('51508690@qq.com')

pwd = driver.find_element_by_xpath('//*[@id="loginPassword"]')
pwd.clear()
pwd.send_keys('mumu2018')

login = driver.find_element_by_xpath('//*[@id="loginAction"]')
# 出发这个login元素的click事件
login.click()

WebDriverWait(driver, 30, 1).until(EC.presence_of_element_located((By.XPATH, '//p[@data-node="title"]')))

cookies = driver.get_cookies()

file = 'sina_cookies.txt'

'''
等同于下面的 with open
try:
    f = open(file, 'w')
    json.dump(cookies, f)
finally:
    f.close()
'''
with open(file, 'w') as f:
    # 不建议大家直接把 list 转 str 后保存到文件
    # f.write(str(cookies))

    '''
        推荐这种list和dict的格式，通过json进行保存到文件
        json的4个方法:
        load：从文件中读取符合json格式的文本
        dump：把json格式的对象转成文本保存到文件中
        loads：从字符串中读取符合json格式的内容，得到json对象
        dumps：将json对象转换成符合json格式的字符串
    '''
    json.dump(cookies, f)
    # 等同于下面的代码
    # json_str = json.dumps(cookies)  # 是把list对象转成json格式的字符串
    # f.write(json_str) # 将json格式的字符串保存到文件中

# 需要手动退出driver
driver.quit()

print('over')