# -*- coding: utf-8 -*-
from areaair.spiders.area_spider import AreaSpider

from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

# 获取settings.py模块的设置
settings = get_project_settings()
process = CrawlerProcess(settings=settings)

# 可以添加多个spider
process.crawl(AreaSpider)
# 启动爬虫，会阻塞，直到爬取完成
process.start()
# -*- coding:utf-8 -*-