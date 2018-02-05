#!/usr/bin/env python
# -*- coding: utf-8 -*-
from mongoengine import *

__author__ = 'Terry'

connect('study', host='localhost', port=27017)

class Study(Document):
    title = StringField(required=True, max_length=200)
    content = StringField(required=True)
    list_pymongodb = SequenceField(required=False)
    size = IntField(required=False)

if __name__ == '__main__':
    # 查找
    # studys = Study.objects.all()
    # for s in studys:
    #     print('%s   :  %s  :  %s' % (s.title, s.content, s.list_pymongodb))

    # search = Study.objects(title='pymongodb测试')
    # for s in search:
    #     print('%s   :  %s  :  %s' % (s.title, s.content, s.list_pymongodb))

    # 新增
    # study = Study(
    #     title='测试engine标题111',
    #     content='测试engine内容111'
    # )
    # study.save()

    # 修改
    # tmp = Study.objects(title="pymongodb测试").update(content='engine修改测试内容2')
    # print(tmp)

    # 删除
    # tmp = Study.objects(title="测试标题2").delete()
    # print(tmp)

    print('over')