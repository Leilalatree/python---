# -*- coding:utf-8 -*-
import requests
import random
import json
import jsonpath
import time

class DoubanSpider(object):
    def __init__(self):
        self.start = 0
        self.USER_AGENTS = ["Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"]

    def start_work(self):
        response = requests.get(url="https://movie.douban.com/j/chart/top_list?type=11&interval_id=100%3A90&action=&start="+str(self.start)+ "&limit=20",headers={"User-Agent":random.choice(self.USER_AGENTS)})
        if response.text == "[]":
            print("抓取完毕！")
            return
        self.json_data(response.text)

    def json_data(self,data):
        data = json.loads(data) #将json格式转为python格式   data type = 列表
        item = {}
        #jsonpath 提取python格式的数据
        title_list = jsonpath.jsonpath(data,"$..title")
        score_list = jsonpath.jsonpath(data,"$..score")
        url_list = jsonpath.jsonpath(data, "$..url")
        type_list = jsonpath.jsonpath(data, "$..types")
        regions_list = jsonpath.jsonpath(data, "$..regions")

        for title,score,url,type,regions in zip(title_list,score_list,url_list,type_list,regions_list):
            item['title'] = title
            item['score'] = score
            item['url'] = url
            item['type'] = type
            item['regions'] = regions
            self.write_data(item)
        print("%s crawled!" % self.start)
        self.start += 20
        time.sleep(random.randint(1,2))
        self.start_work()

    def write_data(self,item):
        #设置默认转码
        content = json.dumps(item,ensure_ascii=False) + ",\n"
        with open("Douban.json","a",encoding="utf-8") as f:
            f.write(content)




if __name__ == '__main__':
    work = DoubanSpider()
    work.start_work()