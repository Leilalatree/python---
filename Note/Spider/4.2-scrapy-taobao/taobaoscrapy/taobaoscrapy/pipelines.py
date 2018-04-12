# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymongo

class TaobaoscrapyHandleItemPipeline(object):
    def process_item(self, item, spider):
        item['sales'] = int(item['sales'].replace('人收货', ''))
        item['price'] = float(item['price'])
        address = item.pop('address').split(' ')
        item['province'] = address[0]
        if len(address) > 1:
            item['city'] = address[1]
        else:
            item['city'] = ''
        return item

class TaobaoscrapyPipeline(object):
    def __init__(self, mongo_uri, mongo_db):
        self.mongo_uri = mongo_uri
        self.mongo_db = mongo_db

    @classmethod
    def from_crawler(cls, crawler):
        #  必须在settings中 配置 MONGO_URI 和 MONGO_DATABASE
        return cls(
            mongo_uri=crawler.settings.get('MONGO_URI'),
            mongo_db=crawler.settings.get('MONGO_DATABASE', 'scrapy')
        )

    def open_spider(self, spider):
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]

    def close_spider(self, spider):
        self.client.close()

    def process_item(self, item, spider):
        self.db['taobao'].insert_one(dict(item))
        # return item
