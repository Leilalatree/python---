#!/usr/bin/env python
# -*- coding: utf-8 -*-
from urllib.parse import parse_qsl

__author__ = 'Terry'


def print_headers_raw_to_dict(headers_raw_l):
    print("{\n    '" + ",\n    ".join(map(lambda s: "'" +
        "': '".join(s.strip().split(': ')) + "'", headers_raw_l))[1:-1] + "'\n}")

def print_headers_raw_to_dict_space(headers_raw_l):
    print("{\n    '" + ",\n    ".join(map(lambda s: "'" + "': '".join(s.strip().split('\t')) + "'", headers_raw_l))[1:-1] + "'\n}")

def print_dict_from_copy_headers(headers_raw):
    headers_raw = headers_raw.strip()
    headers_raw_l = headers_raw.splitlines()

    if 'HTTP/1.1' in headers_raw_l[0]:
        headers_raw_l.pop(0)
    if headers_raw_l[0].startswith('Host'):
        headers_raw_l.pop(0)
    if headers_raw_l[-1].startswith('Cookie'):
        headers_raw_l.pop(-1)

    if ':' in headers_raw_l[0]:
        print_headers_raw_to_dict(headers_raw_l)
    else:
        print_headers_raw_to_dict_space(headers_raw_l)

def print_url_params(url_params):
    s = str(parse_qsl(url_params.strip(), 1))
    print("OrderedDict(\n    " + "),\n    ".join(map(lambda s: s.strip(), s.split("),")))[1:-1] + ",\n)")

if __name__ == '__main__':
    text = '''
GET https://wx.qq.com/ HTTP/1.1
Host: wx.qq.com
Connection: keep-alive
Cache-Control: max-age=0
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36
Upgrade-Insecure-Requests: 1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.8
Cookie: RK=SIlKzihqE0; eas_sid=s115w0b6M9r1T3E4i174y6a4H7; tvfe_boss_uuid=7e0ae320ef04d53b; pgv_pvi=15131648; msuid=jc7mgzofmbrougmrgnykipa90rvdnoknlcjv7rnp; ptui_loginuin=404775879; pt2gguin=o0404775879; luin=o0404775879; lskey=00010000d17531fed62b606825d4f835f232c97967e75ba2559a40c2e9c3ac71dbe2567b4954127c8980c42e; ptcz=72d93cd300c3dc65a61891bb67594b4946238203b0e11ac035730f47f66473d3; pgv_pvid=3962316624; o_cookie=404775879; webwxuvid=04641dcf6dc297abdeaf661b8bcc3ba164b2db8f7e0472bef2381033b9f8566d8b860ef73875a6f1f310107212ef4306; webwx_auth_ticket=CIsBEP78p5MPGoAB4OVrc1ZGXfKrAHiN/bhzzUy00lciI/uIcAJZNB6hJ9wDtwFeTzdk9lvu4riNO9HoJV9rJQmk3nqYPs1s6OWuTmBqkQrrqoBTRDZDktusgRoHZQ/naGP28Nnq1dsH/S1DspAt+xmr7h5Gqi9o/iR7Dkm5vlgQvAZYO+DIGnmP9NM=; login_frequency=1; last_wxuin=2271067801; wxloadtime=1517020034_expired; wxpluginkey=1517014081; wxuin=2271067801; mm_lang=zh_CN; MM_WX_NOTIFY_STATE=1; MM_WX_SOUND_STATE=1


    '''

    text_fiddler = '''
r	1517020390955
skey	@crypt_ed502ed7_4962e067091d1004a352c6fe52cd62bc
sid	nT5I4z9EmVoangur
uin	2271067801
deviceid	e224792311444150
synckey	1_671497521|2_671498194|3_671498150|1000_1517014081
_	1517020376814

    '''

    print_dict_from_copy_headers(text_fiddler)


    # url_params = 'username=yiexingtest003%40163.com&password=fdfasf&savelogin=1&url=http%3A%2F%2Fcaipiao.163.com%2Fagent%2FloginAgentV2.htm%3Fcallback%3Dlogin143999647097272&url2=http%3A%2F%2Fcaipiao.163.com%2Fagent%2FloginAgentV2.htm%3Fcallback%3Dlogin143999647097272&product=caipiao&type=1&noRedirect=1'
    # print_url_params_new(url_params)