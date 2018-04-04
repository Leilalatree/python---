# -*- coding:utf-8 -*-
import scrapy
from bs4 import BeautifulSoup
from scrapy import Request
from dingdian.items import DingdianItem

class DingdianSpider(scrapy.Spider):

    name = 'dingdian'

    def start_requests(self):
        base_url = 'http://www.23us.so/list/%s_1.html'

        for i in range(1,10):
            url = base_url % i
            yield Request(url,callback=self.parse)

    def parse(self, response):
        #获取页码最大值
        max_num = response.xpath('//a[@class="last"]/text()').extract_first()
        url = response.url
        url_pre = url[:-6]  #倒数第六位为页码数字 取http://www.23us.so/list/1_

        for i in range(1,int(max_num)+1):
            url = url_pre + str(i) + '.html'
            yield Request(url,callback=self.parse_page)

    def parse_page(self,response):
        trs = response.xpath('//tr[@bgcolor="#FFFFFF"]')
        for tr in trs:
            url = tr.xpath('td[1]/a/@href').extract_first()
            book_name = tr.xpath('td[1]/a/text()').extract_first()
            new_chapter = tr.xpath('td[2]/a/text()').extract_first()
            meta = {
                'book_name':book_name,
                'new_chapter':new_chapter
            }
            yield Request(url,callback=self.parse_details,meta=meta)

    def parse_details(self,response):
        soup = BeautifulSoup(response.text)
        table = soup.find('table')
        trs = table.find_all('tr')
        auth = trs[0].find_all('td')[1].get_text().replace('\xa0', '')  # \xa0 就是 html 中的 &nbsp;
        status = trs[0].find_all('td')[2].get_text().replace('\xa0', '')
        words = trs[1].find_all('td')[1].get_text().replace('\xa0', '')
        last_time = trs[1].find_all('td')[2].get_text().replace('\xa0', '')

        item = DingdianItem()
        item['book_name'] = response.meta['book_name']
        item['new_chapter'] = response.meta['new_chapter']
        item['auth'] = auth
        item['words'] = words
        item['last_time'] = last_time
        item['status'] = status

        return item