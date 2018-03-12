#coding:utf-8
import requests
class HtmlDownloader(object):

    def download(self,url):
        if url is None:
            return None
        headers = {
            'User - Agent': 'Mozilla / 5.0(Macintosh; Intel Mac OS X 10_12_3) AppleWebKit / 537.36(KHTML, like Gecko) Chrome / 61.0.3163.100 Safari / 537.36'
        }
        r = requests.get(url,headers=headers)
        if r.status_code==200:
            r.encoding='uft-8'
            return r.text
        return None
