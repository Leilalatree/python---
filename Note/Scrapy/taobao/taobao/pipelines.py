# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymongo


class TaobaoHandlePipeline(object):
    def process_item(self, item, spider):
        loc  = item.pop('loc')
        loc_1 = loc.split(' ')
        item['province'] = loc_1[0]
        if len(loc_1) == 1:
            item['city'] = loc_1[1]

        #替换 sales中的人收货
        item['sales'] = int(item['sales'].replace('人收货', ''))
        item['price'] = float(item['price'])

class TaobaoPipeline(object):
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
        self.db['items'].insert_one(dict(item))
        return item
