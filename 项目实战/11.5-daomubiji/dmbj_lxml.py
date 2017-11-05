from lxml import etree
import requests
headers = {
'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36'
}
r = requests.get('http://seputu.com/',headers=headers)
html = etree.HTML(r.text)
div_mulus = html.xpath('.//*[@class="mulu"]')
for div_mulu in div_mulus:
    div_h2 = div_mulu.xpath('./div[@class="mulu_title"]/center/h2/text()')
    if len(div_h2)>0:
        h2_title = div_h2[0]
        a_s = div_mulu.xpath('./div[@class="box"]/ul/li/a')
        for a in a_s:
            href = a.xpath('./@href')[0]
            box_title = a.xpath('./@title')[0].encode('utf-8')
            

