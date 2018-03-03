#!/usr/bin/env python
# -*- coding: utf-8 -*-
from urllib import parse

import urllib3
urllib3.disable_warnings()
from common.util import get_first_str_by_text_multi

__author__ = 'Terry'

GITHUB_LOGIN_HEADERS = {
    'Host': 'github.com',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Referer': 'https://github.com/',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.8'
}

def login_by_email(email, pwd):
    # http = ProxyManager('https://127.0.0.1:8888')
    http = urllib3.HTTPSConnectionPool('github.com')

    r = http.request('GET', 'https://github.com/login', headers=GITHUB_LOGIN_HEADERS)
    text = r.data.decode('utf-8')
    authenticity_token = get_first_str_by_text_multi('name="authenticity_token".*?value="(.*?)"', text)
    cookie_login = r.headers['set-cookie']

    data = {
        'utf8': '✓',
        'password': pwd,
        'login': email,
        'commit': 'Sign in',
        'authenticity_token': authenticity_token,
    }
    GITHUB_LOGIN_HEADERS['Cookie'] = cookie_login
    # r = http.request('POST', 'https://github.com/session', data, headers=GITHUB_LOGIN_HEADERS,
    #                  encode_multipart=False, redirect=False)
    r = http.request('POST', 'https://github.com/session', body=parse.urlencode(data), headers=GITHUB_LOGIN_HEADERS,
                     encode_multipart=False, redirect=False)
    cookie_session = r.headers['set-cookie']

    GITHUB_LOGIN_HEADERS['Cookie'] = cookie_session
    r = http.request('GET', 'https://github.com/', headers=GITHUB_LOGIN_HEADERS)
    text = r.data.decode('UTF-8')

    if 'Start a project' in text:
        print('登录成功')
    else:
        print(r.status)
        print(text)
        print('登录失败')

if __name__ == '__main__':
    email = 'mumuloveshine'
    pwd = 'mumu2018'
    login_by_email(email, pwd)
    print('结束')