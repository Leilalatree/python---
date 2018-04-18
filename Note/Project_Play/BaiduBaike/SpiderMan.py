#coding:utf-8

import DataOutput
import HTMLDownloader
import URLManger
import HtmlParser

class SpiderMan(object):
    def __init__(self):
        self.manager = URLManger.UrlManager()
        self.downloader = HTMLDownloader.HtmlDownloader()
        self.parser = HtmlParser.HhmlParser()
        self.output = DataOutput.DataOutput()

    def crawl(self,root_url):
        #添加url入口
        self.manager.add_new_url(root_url)
        while(self.manager.has_new_url() and self.manager.old_url_size() < 100):
            try:
                #从url管理器获取新的url
                new_url = self.manager.add_new_url()
                #html下载器下载网页
                html = self.downloader.download(new_url)
                #html解析器抽取网页数据
                new_urls,data = self.parser.parser(new_url,html)
                #将抽取的url添加到url管理器中
                self.manager.add_new_urls(new_url)
                #数据存储器存储文件
                self.output.store_data(data)
                print("已经抓取%s个链接")%self.manager.old_url_size()
            except Exception,e:
                print("抓取失败")
        self.output.output_html()

if __name__=="__main__":
    spider_man = SpiderMan()
    spider_man.crawl("http://baike.baidu.com/view/284853.htm")