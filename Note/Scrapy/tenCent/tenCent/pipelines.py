# -*- coding: utf-8 -*-

import json
from tenCent.items import TencentItem,PositionItem

class TencentJsonPipeline(object):

    def __init__(self):
        self.file = open('tencent.json', 'w')

    def process_item(self, item, spider):
        if isinstance(item,TencentItem):   #返回True，控制对应的item类写入对应的文件
            content = json.dumps(dict(item), ensure_ascii=False) + "\n"
            self.file.write(content)
        return item

    def close_spider(self, spider):
        self.file.close()

class PositionJsonPieline(object):

    def __init__(self):
        self.file = open('position.json', 'w')

    def process_item(self, item, spider):
        if isinstance(item,PositionItem):
            content = json.dumps(dict(item), ensure_ascii=False) + "\n"
            self.file.write(content)
        return item

    def close_spider(self, spider):
        self.file.close()