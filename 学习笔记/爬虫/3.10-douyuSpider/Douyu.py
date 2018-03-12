# -*- coding:utf-8 -*-
import requests
import json
import gevent

url = "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&offset="
offset = 0
headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36'
}

def DouyuSpider():
    global offset
    item = {}
    text = requests.get(url=url+str(offset),headers=headers).text
    data_list = json.loads(text)['data']  #把json数据转换为python数据
    if not data_list:
        return
    for data in data_list:
        item['room_id'] = data['room_id']
        item['anchor_city'] = data['anchor_city']
        item['vertical_src'] = data['vertical_src']
        item['nickname'] = data['nickname']
        write_img(item)
    gevent.sleep(1.5)
    offset += 20
    gevent.spawn(DouyuSpider).join()

def write_img(item):
    print("正在存储图片-->%s,%s,房间地址为:www.douyu/%s" %(item['anchor_city'],item['nickname'],item['room_id']))
    content = requests.get(url=item['vertical_src'],headers=headers).content
    with open("img/" + item['nickname'] + ".jpg", "wb") as f:
        f.write(content)


if __name__ == '__main__':
    DouyuSpider()