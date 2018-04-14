# -*- coding: utf-8 -*-

import json


class TencentJsonPipeline(object):

    def __init__(self):
        self.file = open('tencent.json', 'a')

    def process_item(self, item, spider):
        content = json.dumps(dict(item), ensure_ascii=False) + "\n"
        self.file.write(content)
        return item

    def close_spider(self, spider):
        self.file.close()