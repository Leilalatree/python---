# -*- coding:utf-8 -*-
from json import JSONDecodeError
from urllib import parse

import json

from taobao.items import TaobaoItem
import scrapy

class TaobaoSpider(scrapy.Spider):
    name = 'taobao'

    base_url = 'https://s.taobao.com/search?search_type=item' \
               '&ssid=s5-e&commend=all&imgfile=&q={}' \
               '&_input_charset=utf-8&wq=&suggest_query=&source=suggest' \
               '&sort=sale-desc&bcoffset=0&p4ppushleft=%2C{}&s={}'
    def start_requests(self):

        key_words = self.settings['KEY_WORDS']
        key_words = parse.quote(key_words,safe= ' ').replace(' ','+')
        one_page_count = self.settings['ONE_PAGE_COUNT']
        page_num = self.settings['PAGE_NUM']
        for i in range(page_num):
            url = self.base_url.format(key_words, page_num, one_page_count * i)
            yield scrapy.Request(url=url,callback=self.parse)

     #第一层解析response的方法
    def parse(self, response):
        try:
            p = 'g_page_config = ({.*?});'
            #scrapy 支持的selector 支持re xpath css
            g_page_config = response.selector.re(p)[0]
            g_page_config= json.loads(g_page_config)
            auctions = g_page_config['mods']['itemlist']['data']['auctions']

            for auction in auctions:
                item = TaobaoItem()
                item['title'] = auction['raw_title']              # 商品名：
                item['nick'] = auction['nick']                    # 商铺名：
                item['price'] = auction['view_price']  # 价格：
                item['loc'] = auction['item_loc']                 # 发货地址：
                item['sales'] = auction['view_sales']  # 收货人数：
                item['detail_url'] = auction['detail_url']        # 详情链接：

                yield item
        except JSONDecodeError as e:
            yield scrapy.Request(response.url,callback=self.parse)
        else:
            print(response.text)
            print(response.url)




