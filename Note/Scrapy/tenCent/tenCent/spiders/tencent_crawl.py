# -*- coding: utf-8 -*-
import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from tenCent.items import TencentItem

class TencentCrawlSpider(CrawlSpider):
    name = 'tencent_crawl'
    allowed_domains = ['hr.tencent.com']
    start_urls = ['https://hr.tencent.com/position.php?&start=0#a']

    rules = (
        Rule(LinkExtractor(allow='start=\d+'), callback='parseContent', follow=True),
    )

    def parseContent(self, response):
        item = TencentItem()
        each_list = response.xpath('//*[@class="even"]|//*[@class="odd"]')

        for each in each_list:
            name = each.xpath('./td[1]/a/text()').extract_first()
            detailsLink = each.xpath('./td[1]/a/@href').extract_first()
            positionInfo = each.xpath('./td[2]/text()').extract_first()
            peopleNumber = each.xpath('./td[3]/text()').extract_first()
            workLocation = each.xpath('./td[4]/text()').extract_first()
            publishTime = each.xpath('./td[5]/text()').extract_first()

            item['name'] = name
            item['detailLink'] = detailsLink
            item['positionInfo'] = positionInfo
            item['peopleNumber'] = peopleNumber
            item['workLocation'] = workLocation
            item['publishTime'] = publishTime

            yield item


