# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class TaobaoItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    price = scrapy.Field()  #价格：
    sales = scrapy.Field() #收货人数：
    title = scrapy.Field() #商品名：
    nick = scrapy.Field() #商铺名：
    loc = scrapy.Field() #发货地址：
    detail_url = scrapy.Field() #详情链接：

    province = scrapy.Field()
    city = scrapy.Field()

