#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import traceback
from urllib import parse

import scrapy
import time

from taobaoscrapy.common.util import get_first_str_by_text_multi
from taobaoscrapy.items import TaobaoscrapyItem

__author__ = 'Terry'

class TaobaoSpider(scrapy.Spider):

    name = 'taobao'

    base_url = 'https://s.taobao.com/search?search_type=item' \
               '&ssid=s5-e&commend=all&imgfile=&q={}' \
               '&_input_charset=utf-8&wq=&suggest_query=&source=suggest' \
               '&sort=sale-desc&bcoffset=0&p4ppushleft=%2C{}&s={}'


    def start_requests(self):
        item_name = self.encode_item_name(self.settings['ITEM_NAME'])
        for i in range(self.settings['PAGE_NUM']):
            url = self.base_url.format(item_name, self.settings['ONE_PAGE_NUM'], self.settings['ONE_PAGE_NUM'] * i)
            yield scrapy.Request(url, callback=self.parse)

    def parse(self, response):
        try:
            # g_page_config = get_first_str_by_text_multi('g_page_config = ({.*?});', response.text)
            g_page_config = response.selector.re('g_page_config = ({.*?});')[0]
            g_page_config_dict = json.loads(g_page_config)

            auctions = g_page_config_dict['mods']['itemlist']['data']['auctions']
            for auction in auctions:
                item = TaobaoscrapyItem()
                item['nid'] = auction['nid']
                item['user_id'] = auction['user_id']
                item['item_name'] = auction['raw_title']
                item['shop'] = auction['nick']
                item['price'] = auction['view_price']
                item['link'] = auction['detail_url']
                item['sales'] = auction['view_sales']
                item['address'] = auction['item_loc']

                # 必须 yield，不然只会处理第一个
                yield item
                # return item
        except:
            print(response.url)

            time.sleep(1)
            yield scrapy.Request(response.url, callback=self.parse)

    def encode_item_name(self, item_name):
        item_name = parse.quote(item_name, safe=' ').replace(' ', '+')
        return item_name



