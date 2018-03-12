# -*- coding:utf-8 -*-
import sys
import requests
from bs4 import BeautifulSoup
import time

ip_pool = []

class KuaidailiIpSipder(object):

    def __init__(self):
        pass

    def get_ip(url):
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"
        }
        r = requests.get(url + str(page), headers=headers).text
        soup = BeautifulSoup(r, "html.parser")
        data_list = []
        for ip, tr in enumerate(soup.find_all('tr')):
            if ip != 0:
                tds = tr.find_all('td')
                data_list.append(
                    {
                        'IP': tds[0].contents[0],
                        'PORT': tds[1].contents[0],
                        '匿名度': tds[2].contents[0],
                        '类型': tds[3].contents[0],
                        '位置': tds[4].contents[0],
                        '响应速度': tds[5].contents[0],
                        '最后验证时间': tds[6].contents[0],
                    }
                )
        for data in data_list:
            ip_pool.append(data.get('IP'))



if __name__ == '__main__':
    url = "https://www.kuaidaili.com/free/inha/"
    page = 1
    for i in range(10):
        print('正在爬取第 %s 页...' %page)
        KuaidailiIpSipder.get_ip(url)
        page += 1
        time.sleep(1)
    print(ip_pool)
