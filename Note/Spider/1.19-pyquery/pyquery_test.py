#!/usr/bin/env python
# -*- coding: utf-8 -*-
from lxml import etree
from pyquery.pyquery import fromstring

__author__ = 'Terry'

from pyquery import PyQuery as pq


'''
    pyquery，解析器基于lxml和html5lib库，符合jquery的语法进行操作
    除了对jquery语法特别热爱的同学们，其他人还是直接使用lxml、beautifulsoup4

    所有的基于xml的解析，html是一种特殊的xml，html5在html基础上的，
    1、加载文本：文本，字符串，url访问，数据库等
    2、目标定位：节点、属性、节点之间的层级关系或者相对位置、text
    3、获取目标：text、属性

    正则表达式就是纯文本解析的。

'''

'''
命名规则，建议大家去看一下PEP8，
类：首拼大写，FirstSecond
方法：全小写 def first_second()
属性：
    常量，全大写， FIRST_SECONDE = 123
    普通的：全小写，- 分隔 first_second = '123'
    函数参数：全小写，- 分隔 first_second

'''

html_doc = '''
 <html>
  <head>
   <title>
    The Dormouse's story
   </title>
  </head>
  <body>
   <p class="title">
    <b>
     The Dormouse's story
    </b>
   </p>
   <p class="story">
    Once upon a time there were three little sisters; and their names were
    <a class="sister" href="http://example.com/elsie" id="link1">
     Elsie
    </a>
    <a class="sister" href="http://example.com/lacie" id="link2">
     Lacie
    </a>
    and
    <a class="sister" href="http://example.com/tillie" id="link2">
     Tillie
    </a>
    and they lived at the bottom of a well.
   </p>
   <p class="story">
    测试中文
   </p>
  </body>
 </html>
'''

# pyq_str=pq(html_doc)
# 返回本标签下的所有内容
# print(pyq_str('head').html())
# 返回标签下的所有文本
# print(pyq_str('head').text())
#
# pyq_str=pq(etree.fromstring(html_doc))
# print(pyq_str('head').html()) #返回<title>hello</title>
# print(pyq_str('head').text())

# 默认cp936 编码，即GBK编码，无法更改
# pyq_file=pq(filename='html_doc.txt')
# print(pyq_file('head').html()) #返回<title>hello</title>
# print(pyq_file('head').text())

# 默认使用的requests的方法访问网络，也可以自己传入一个opener
# pyq_url=pq(url='http://www.baidu.com', encoding='utf-8')
# pyq_url=pq(url='http://www.baidu.com')
# print(pyq_url('head').html()) #返回<title>hello</title>
# print(pyq_url('head').text())

# 多个解析器，但是官网都没有介绍，都是使用的其他库
# pyq_fromstring = fromstring(html_doc, 'html')
# print(pyq_fromstring[0].head.tag)

pyq_str=pq(html_doc)
# link1 = pyq_str('#link1')
# print(link1.html())  # 标签内的所有东西
# print(link1.text())  # 标签内的文本

# print(pyq_str('body').html())
# print(pyq_str('body').text())

# css选择器，通过属性定位标签
# print(pyq_str('a[@id="link1"]').html())

# # 获取标签的属性值，通过 元素.attr.属性名  或 元素.attr['属性名']
# print(pyq_str('a[@id="link1"]').attr.id)
# print(pyq_str('a[@id="link1"]').attr['class'])

# print(pyq_str('a[@id="link1"]').parent()) # 父标签

# # 子标签  ， 漏掉第一行的文本
# print(pyq_str('p[@class="story"]').children())

# # 下一个平级的标签
# print(pyq_str('p[@class="title"]').next())

# # 之后平级的所有标签
# print(pyq_str('p[@class="title"]').next_all())


