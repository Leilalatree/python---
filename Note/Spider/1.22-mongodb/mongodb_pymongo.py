#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bson import ObjectId

__author__ = 'Terry'

from pymongo import MongoClient

# http://www.baidu.com
# mongodb://[username:password@]host1[:port1][,host2[:port2]
# ....[,hostN[:portN]]][/[database][?options]]
# conn = MongoClient('localhost', 27017)
conn = MongoClient('mongodb://localhost:27017/')
db = conn.study  #连接study数据库，没有则自动创建

# my_study = db.study #使用study集合，没有则自动创建

# 获取一个集合的操作游标
def get_collection(collection_name):
    return db.get_collection(collection_name)

def get_one_by_id(collection_name, id):
    collect_cur = get_collection(collection_name)
    return collect_cur.find_one({'_id': ObjectId(id)})

def get_one(collection_name, filter):
    collect_cur = get_collection(collection_name)
    return collect_cur.find_one(filter)

def get_all(collection_name, filter):
    collect_cur = get_collection(collection_name)
    return collect_cur.find(filter)

# 插入多条记录
def any_string_if_i_love(collection_name, data):
    collect_cur = get_collection(collection_name)
    return collect_cur.insert_many(data)

def update_one(collection_name, filter, data):
    collect_cur = get_collection(collection_name)
    return collect_cur.update_one(filter, {"$set": data})

def update_many(collection_name, filter, data):
    collect_cur = get_collection(collection_name)
    return collect_cur.update_many(filter, {"$set": data})

def delete(collection_name, filter):
    collect_cur = get_collection(collection_name)
    return collect_cur.remove(filter)

if __name__ == '__main__':
    collection_name = 'study'

    '''
        这个库是不需要管理连接的，他有默认的连接池
        1000个左右的连接，每个连接大概10m的一个缓存
    '''
    # 爬取某个小说网站
    # 新增
    # 第一步 连接mongodb
    conn = MongoClient('mongodb://localhost:27017/')
    # 第二步 获取指定的数据库实例
    db = conn.study  # 连接study数据库，没有则自动创建
    # 第三步 获取指定的集合
    study = db.get_collection('study')
    #
    # # 插入多条
    # collection_list = [{'title': '某某玄幻小说', 'content':'玄幻小说的介绍'},
    #                    {'title': '某某言情小说', 'content':'言情小说介绍'}]
    # result = study.insert_many(collection_list)
    # print('插入数据:%s ' % result.inserted_ids)
    #
    # # 插入1条
    # collection_list = {'title': '单条title1', 'content': '单条content1','size':100}
    # result = study.insert_one(collection_list)
    # print('插入数据:%s ' % result.inserted_id)

    # # 查找
    # print(get_one_by_id(collection_name, '5a656e5e9a1ad482045fb319'))
    # print(get_one(collection_name, {'size':{"$lt":1000 }}))
    # print(get_one(collection_name,
    #               {"title":"测试标题", "content":"测试内容修改many2"}))

    # all_list = get_all(collection_name, {'title': '测试标题'})
    # for l in all_list:
    #     print(l)
    #
    # # 修改
    # print(update_one(collection_name, {'title': '测试标题'},
    #                  {'content': '测试内容修改one1111'}).modified_count)
    # result = update_many(collection_name, {'title': '测试标题'},
    #                      {'content': '测试内容修改many11111'})
    # print(result.matched_count)
    # print(result.modified_count)
    # print(result.raw_result)
    #
    # # 删除
    print(delete(collection_name, {'title': '测试标题'}))

    print('over')
    pass

from pymongo.results import UpdateResult