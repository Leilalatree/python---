# -*- coding:utf-8 -*-
import scrapy
from Lagou.items import LagouItem

class Lagou(scrapy.Spider):
    name = "lagou"
    start_urls = [
        "https://www.lagou.com/"
    ]

    def parse(self, response):
        for item in response.xpath('//div[@class="menu_box"]/div/dl/dd/a'):
            jobClass = item.xpath('text()').extract()
            jobUrl = item.xpath("@href").extract_first()

            oneItem = LagouItem()
            oneItem["jobClass"] = jobClass
            oneItem["jobUrl"] = jobUrl

            yield oneItem