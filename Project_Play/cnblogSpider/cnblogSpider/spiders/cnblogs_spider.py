# -*- coding:utf-8 -*-
import scrapy

class CnblogsSpider(scrapy.Spider):
    name = "cnblogs"
    allowed_domains = ["cnblogs.com"]
    start_urls = [
        "http://www.cnblogs.com/qiyeboy/default.html?page=1"
    ]

    def parse(self, response):
        # 里面实现网页的而解析
        # 里面实现网页的而解析
        # 首先抽取所有的文章
        papers = response.xpath(".//*[@class='day']")
        # 从每篇文章中抽取数据
        for paper in papers:
            url = paper.xpath(".//*[@class='postTitle']/a/@href").extract()[0]
            title = paper.xpath(".//*[@class='postTitle']/a/text()").extract()[0]
            time = paper.xpath(".//*[@class='dayTitle']/a/text()").extract()[0]
            content = paper.xpath(".//*[@class='postCon']/div/text()").extract()[0]
            print url,title,time,content