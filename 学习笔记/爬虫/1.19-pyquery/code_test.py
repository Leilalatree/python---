#!/usr/bin/env python
# -*- coding: utf-8 -*-
import chardet

__author__ = 'Terry'

r'''
一、python3
内部都是unicode码点，体现出来的对象str，例如 '中国人abc123'
另外一个str.encode，是bytes，'\\u4e2d\xd6\xd0123abc'
如果看到乱码，就是转错码或者就是iso-8859-1，不可见的字符

python3的默认编码是UTF-8，不指定encoding的话，就采用utf-8

二、各种编码分析，加上unicode
1、unicode：和GBK,UTF-8不是一个类型的东西，unicode是一种编码集，
有17个区间，\x0000至\x10FFFF  常用的，默认的，就是第一个区间,
UCS-2标准，任何字符都是2个字节，字母、数字和中文都是， \x0030 就是字符：0

2、ascii码：一个字节，127个，\x00  到  \x7f，
当今主流的编码都支持ASCII，UNICODE就是在前面补\x00，  \x0000 到 \x007F

3、iso-8859-1，一个字节，西欧字符集，在ASCII码上扩张，
URL和headers，默认都是这个编码

4、GB2312：2个字节，6000多中文，支持ascii码，\x8080，
高字节和低字节都是\x80以上

5、gbk：就在gb2312的基础上，扩展的，2个字节， \x8000
高字节是\x80以上，低字节随便

6、UTF-8：UCS Transfer format，完美支持unicode，
1-4个字节，中文是3个字节，几乎用不到4个字节,\xe4\xb8\xad

三、爬虫http解码
1、url和headers都是iso-8859-1，http协议规定的
2、服务器传给客户端的时候，是一个字节串，在headers有
   content-type的charset
   head中的meta下面的charset
   如果没找到，默认iso-8859-1，是一个字节的
   当你的默认编码是utf-8时，url编码其实就是把utf-8的 \x 变成  %
    \xe4\xb8\xad\xe4\xb8\xad

3、chardet.detect 猜测编码，字符长度越长，准确率越高

四、requests库
response的encoding，3种情况：
1、response中有 content-type 的 charset，那么编码是 charset设置的编码
2、如果没有charset，但是有content-type这个属性，并且value中包含  text ，
    那么编码设为 None
3、以上2种都不满足，encoding='ISO-8859-1'

五、怎么处理
1、排除压缩，request提交了accept-encoding:gzip,deflate,br ，服务器有可能返回压缩后的数据，
response的headers中有 content-encoding:gzip，
requests不支持解压，肯定是乱码，去掉 accept-encoding
2、response.content.decode() ，  iso-8859-1，gbk，utf-8  三个中去测试

'''
# s = '中'
# 以下三种是等值的，但是建议就用s = '中'
# s1 = '中'
# s2 = '\u4e2d'
# s3 = u'\u4e2d'
#
# # r''  是原始字符，会自动加转义字符 '\\u4e2d'
# s4 = r'\u4e2d\xd6\xd0'

# py3 默认编码是UTF-8，以下打印一样的内容
# s1 = '中'
# print(s1.encode('UTF-8'))
# print(s1.encode())

# utf-8编码的字符串以 iso-8859-1 解码，变成 ç¥é 这样的不可见字符
# import requests
# r = requests.get('http://www.baidu.com')
# print(r.text)

# 当你的默认编码是utf-8时，url编码其实就是把utf-8的 \x 变成  %
# from urllib import parse
# s = '中'
# print(parse.quote(s))   # %E4%B8%AD
# print(s.encode('UTF-8'))  # b'\xe4\xb8\xad'
# print(s.encode('GBK'))    # b'\xd6\xd0'

# s = '中'  # str，其实是unicode的码点，\u4e2d\u4e2d\u4e2d\u4e2d\u4e2d  ，对应的是unicode编码表
# s1 = s.encode('gbk') # bytes，2个字节的gbk编码 \xd6\xd0 ，对应的gbk编码表
# s2 = s1.decode('utf-8') # 肯定出错，取3个字节，但是在utf-8的编码表中找不到对应的字符

# 中中中中中国  gbk  的编码
# s3 = b'\x4e\x2d\x4e\x2d\x4e\x2d\x4e\x2d\x4e\x2d\xb9\xfa'
# print(chardet.detect(s3))
# print(s3.decode('utf-8'))
# print(s3.decode('ascii'))
# print('国'.encode('gbk'))

# ascii优先，当bytes符合ascii码，不能转到其他编码
#  是 12个字节， 单个字节前 都会加 \x00， 转ascii码后，只有6个字节
# s ='N-N-N-'.encode('ASCII') # b'\x4e\x2d\x4e\x2d\x4e\x2d
# bytes_array = bytearray(s)
# bytes_array_gbk = bytearray(b'\x4e\x2d\x4e\x2d\x4e\x2d')

# s = '我是测试中文abc123'
# s1 = '\u6211\u662f\u6d4b\u8bd5\u4e2d\u6587abc123'
# from urllib import parse
# print(parse.quote(s))
# print(s.encode('unicode_escape'))
# print(s.encode('unicode_escape'))
# print(s.encode('ascii', 'ignore'))  # 忽略不能解析的部分
# print(s.encode('ascii', 'replace'))  # 替换，用？替换所有不认识的部分
# print(s.encode('ascii', 'xmlcharrefreplace')) #替换，用 &#4位数字+；结尾，替换
#
# def xmlchar_2_cn(s):
#     def convert_callback(matches):
#         char_id = matches.group(1)
#         try:
#             return chr(int(char_id))
#         except:
#             return char_id
#     import re
#     ret = re.sub("&#(\d+)(;|(?=\s))", convert_callback, s)
#
#     return ret
#
# s = '我是测试中文abc123'
# s_ascii = s.encode('ascii', 'xmlcharrefreplace')
# print(s_ascii.decode('ascii'))
# print(xmlchar_2_cn(s_ascii.decode('ascii')))