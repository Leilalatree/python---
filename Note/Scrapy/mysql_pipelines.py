# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy.conf import settings
from pymysql import *
import sys
reload(sys)
sys.setdefaultencoding("utf-8")


class WorkspiderMysqlPipeline(object):
    def open_spider(self,spider):
        host = settings['MYSQL_HOSTS']
        user = settings['MYSQL_USER']
        psd = settings['MYSQL_PASSWORD']
        db = settings['MYSQL_DB']
        c = settings['CHARSET']
        self.con = connect(host=host, user=user, passwd=psd, db=db, charset=c)
        self.cur = self.con.cursor()

    def process_item(self, item, spider):
        sql = ("insert into kg_notice(noticeId,pType,title,keywords,description,catid1,catid2,catid3,tags,province,city,area," \
              "street,adress,companyName,contact,salary,unit,publishName,publishTime,number,scale,experience,degree,url,salt,addtime) " \
              "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)")

        list = [item['noticeId'],item['pType'],item['title'],item['keywords'],item['description'],item['catid1'],item['catid2'],item['catid3'],
                item['tags'],item['province'],item['city'],item['area'],item['street'],item['adress'],item['companyName'],
                item['contact'],item['salary'],item['unit'],item['publishName'],item['publishTime'],item['number'],item['scale'],
                item['experience'],item['degree'],item['url'],item['salt'],item['addtime']]

        self.cur.execute(sql,list)
        max_id = int(self.cur.lastrowid)
        sql2 = ("insert into kg_notice_data(id,noticeId,content)"
                " VALUES (%s,%s,%s)")
        list2 = [0,max_id,item['content']]
        self.cur.execute(sql2,list2)
        self.con.commit()
        return item


# class WorkspiderRedisPipeline(object):
#     def open_spider(self,spider):
#         self.sr = redis.StrictRedis()
#
#     def process_item(self,item,spider):
#         self.sr.sadd("teacher", )
