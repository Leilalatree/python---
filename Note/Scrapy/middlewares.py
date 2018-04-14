import random

class ProxyDownloaderMiddleware(object):
    def __init__(self, proxies):
        self.proxies = proxies

    @classmethod
    def from_crawler(cls, crawler):
        return cls(crawler.settings.get('PROXIES'))

    def process_request(self, request, spider):
        print('ProxyDownloaderMiddleware  request')
        proxy = self.proxies[0]
        request.meta['proxy'] = "https://%s" % proxy['ip_port']
        return None

    def process_response(self, request, response, spider):
        print('ProxyDownloaderMiddleware response')
        return response

class RandomUserAgent(object):
    def __init__(self, agents):
        # 使用初始化的agents列表
        self.agents = agents

    @classmethod
    def from_crawler(cls, crawler):
        # 获取settings的USER_AGENT列表并返回
        return cls(crawler.settings.getlist('USER_AGENTS'))

    def process_request(self, request, spider):
        print(id(self))
        # 随机设置Request报头header的User-Agent
        request.headers.setdefault('User-Agent', random.choice(self.agents))
 
#调用selenium
from selenium import webdriver
import time
import scrapy

class AreaMiddlwares(object):
    def process_request(self,request,spider):
        self.driver = webdriver.Chrome()
        if request.url != "https://www.aqistudy.cn/historydata/":
            self.driver.get(request.url)
            time.sleep(1.5)
            html = self.driver.page_source
            self.driver.quit()
            return scrapy.http.HtmlResponse(url=request.url,body=html.encode("utf-8"),
                                            encoding="utf-8",request=request)       
        
'''
#在settings中配置
# 代理
PROXIES = [
    {'ip_port': '127.0.0.1:8888'},
]

USER_AGENTS = [
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 2.0.50727; Media Center PC 6.0)",
    "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 1.0.3705; .NET CLR 1.1.4322)",
    "Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.2; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 3.0.04506.30)",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN) AppleWebKit/523.15 (KHTML, like Gecko, Safari/419.3) Arora/0.3 (Change: 287 c9dfb30)",
    "Mozilla/5.0 (X11; U; Linux; en-US) AppleWebKit/527+ (KHTML, like Gecko, Safari/419.3) Arora/0.6",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070215 K-Ninja/2.1.1",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9) Gecko/20080705 Firefox/3.0 Kapiko/3.0",
    "Mozilla/5.0 (X11; Linux i686; U;) Gecko/20070322 Kazehakase/0.4.5"
]

'''
