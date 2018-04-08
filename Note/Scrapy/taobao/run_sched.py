# -*- coding:utf-8 -*-
from scrapy.utils.project import get_project_settings
import time
import sched
# -*- coding: utf-8 -*-
from taobao.spiders.taobao import TaobaoSpider
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

settings = get_project_settings()

def start_scrapy():
    process = CrawlerProcess(settings=settings)

    process.crawl(TaobaoSpider)

    process.start()

def get_start_time():
    start_time = settings['START_TIME']
    if start_time:
        struct_time = settings['STRUCT_TIME']
        t = time.mktime(time.strftime(start_time, struct_time))
    else:
        t = time.time()
    return t

def sched_start():
    t = get_start_time()
    s = sched.scheduler()
    delay = t - time.time()
    s.enter(delay,1,start_scrapy)

if __name__ == '__main__':
    sched_start()