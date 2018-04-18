#coding:utf-8
import urllib
from lxml import etree
import requests

def Schedule(blocknum,blocksize,totalsize):
    '''
    :param blocknum:
    :param blocksize:
    :param totalsize:
    :return:
    '''
    per = 100.0*blocknum*blocksize/totalsize
    if per>100:
        per = 100
        print '当前下载进度:%d'%per

headers = {
'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'
}
r = requests.get('http://www.ivsky.com/tupian/ziranfengguang/',headers=headers)
html = etree.HTML(r.text)
img_urls = html.xpath('.//img/@src')
i = 0
for img_url in img_urls:
    urllib.urlretrieve(img_url,'img'+str(i)+'.jpg',Schedule)
    i+=1
