# -*- coding:utf-8 -*-
import requests
import time
import re
import mimetypes
import hashlib
import math
import os
import json
import random
import threading
from collections import OrderedDict
from bs4 import BeautifulSoup
import urllib3
urllib3.disable_warnings()

DEFAULT_HEADERS = {
'Connection': 'keep-alive',
'Cache-Control': 'max-age=0',
'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
'Upgrade-Insecure-Requests': '1',
'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
'Accept-Encoding':'gzip, deflate, br',
'Accept-Language': 'zh-CN,zh;q=0.8'
}

UPLOAD_FILE_HEADERS = {
    'Connection': 'keep-alive',
    'Origin': 'https://wx.qq.com',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
    'Accept': '*/*', # 上传的headers，这点要改
    'Referer': 'https://wx.qq.com/',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Content-Type': 'multipart/form-data'  #  上传的headers，这点要改
}

def get_13_time():
    return str(int(time.time()*1000))

class WXRobot(object):
    def __init__(self):
        self.s = requests.session()
        self.s.verify = False
        self.s.headers = DEFAULT_HEADERS

        self.DeviceID = 'e' + str(random.random())[2:17]
        self.UPLOAD_CHUNK_MAX_SIZE = 524288
        self.zyl = '@0d51e94e04ddc6914640c93e32ba435db2a5e57693a9f5e9f723611b5b3894c0'
        self.sync_check_ = 0
    #访问首页
    def visit_index(self):
        url = 'https://wx.qq.com/'
        self.s.get(url)
        print('1-首页访问完成')

    #获取uuid的页面
    def visit_jslogin(self):
        url = 'https://login.wx.qq.com/jslogin'
        params ={
            'appid': 'wx782c26e4c19acffb',
            'redirect_uri': 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxnewloginpage',
            'fun': 'new',
            'lang': 'zh_CN',
            '_': get_13_time()
        }
        r = self.s.get(url,params=params)
        text = r.text
        maths = re.search('window.QRLogin.uuid = "(.*?)"',text)
        uuid = maths.group(1)
        self.uuid = uuid
        print('2-uuid获取完成')

    #获取登录二维码
    def visit_vcode(self):
        url = 'https://login.weixin.qq.com/qrcode/%s' %self.uuid
        r = self.s.get(url)
        with open('qrcode.jpg','wb') as f:
            f.write(r.content)
        print('3-二维码获取完成')

    #检测登录状态
    def visit_login(self):
        url = 'https://login.wx.qq.com/cgi-bin/mmwebwx-bin/login?loginicon=true&uuid=%s&tip=0&_=%s' %(self.uuid,get_13_time())
        n = 60
        while n > 0:
            r = self.s.get(url)
            text = r.text

            maths = re.search('window.code=(.*?);', text)
            code = int(maths.group(1))

            if code == 200:
                print('已经登录')
                maths = re.search('redirect_uri="(.*?)"', text)
                self.redirect_uri = maths.group(1)
                return True
            elif code == 201:
                print('已经扫描，但是没有点击 登录 确认')
            elif code == 408:
                print('超时，二维码无效')
                break
            else:
                print('未知错误')
                break

            n -= 1
            time.sleep(1)

        return False
        print('redirect_uri获取完成')

    #登录成功后获取一些关键key
    def visit_newloginpage(self):
        r = self.s.get(self.redirect_uri, allow_redirects=False) #静止跳转
        text = r.text

        bs = BeautifulSoup(text,'lxml')
        self.skey = bs.find('skey').text
        self.wxsid = bs.find('wxsid').text
        self.wxuin = bs.find('wxuin').text
        self.pass_ticket = bs.find('pass_ticket').text
        self.isgrayscale = bs.find('isgrayscale').text


    # 生成提交的参数BaseRequest的主体内容，一个dict
    def get_BaseRequest_content(self):
        data = {
            "Uin": self.wxuin,
            "Sid": self.wxsid,
            "Skey": self.skey,
            "DeviceID": self.DeviceID
        }
        return data
    # 生成提交请求的参数BaseRequest的dict
    def get_BaseRequest(self):
        data = {
            "BaseRequest":self.get_BaseRequest_content()
        }
        return data

    # 微信的初始化，获得自身微信号的相关信息和一些微信联系人信息
    def visit_init(self):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxinit'
        params = {
            'r':~int(time.time()),
            'pass_ticket':self.pass_ticket
        }
        r = self.s.post(url,json=self.get_BaseRequest(),params=params)
        r.encoding = 'utf-8'
        text = r.text
        json_data = json.loads(text)
        # json_data = r.json()
        self.my_account = json_data['User']
        self.ChatSet = json_data['ChatSet']
        self.SyncKey = json_data['SyncKey']
        print('登录用户为：%s' % self.my_account['NickName'])

        self.group_list = json_data['ContactList']
        print('联系人列表获取完成')

    # 状态通知
    def visit_statusnotify(self):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxstatusnotify?pass_ticket=%s' %self.pass_ticket
        data = {
            "BaseRequest":"",
            "Code":3,
            "FromUserName":self.my_account['UserName'],
            "ToUserName":self.my_account['UserName'],
            "ClientMsgId":int(get_13_time())
        }
        r = self.s.post(url,json=data)
        r.encoding = 'UTF-8'
        json_data = r.json()
        self.MsgID = json_data['MsgID']
        print('MsgID获取完成:%s' %self.MsgID)

    #获取好友列表
    def visit_getcontact(self):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxgetcontact'
        params = {
            'pass_ticket':self.pass_ticket,
            'r':get_13_time(),
            'seq':'0',
            'skey':self.skey
        }
        r = self.s.get(url,params=params)
        r.encoding = 'UTF-8'
        json_data = r.json()
        self.member_list = json_data['MemberList']
        print('visit_getcontact 获取完成')

    #批量获取联系人 获取群成员
    def visit_batchgetcontact(self):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxbatchgetcontact'
        params = {
            'type': 'ex',
            'r': get_13_time(),
            'pass_ticket': self.pass_ticket
        }
        chat_list = self.ChatSet.split(',')
        chat_list_new = [{'UserName': c.strip(), 'EncryChatRoomId': ''}
                         for c in chat_list if c.startswith('@')]
        data = {
            "BaseRequest": self.get_BaseRequest_content(),
            "Count":13,
            "List":chat_list_new
        }
        r = self.s.post(url,data=data,params=params)
        r.encoding = 'UTF-8'

        json_data = r.json()
        self.group_contact_list = json_data['ContactList']
        print('visit_batchgetcontact 获取完成')

    def webwxsync(self):
        text = ''
        url = 'https://wx.qq.com/webwxsync?sid=%s&skey=%s&lang=zh_CN&pass_ticket=%s' % (
            self.wxsid, self.skey, self.pass_ticket)

        data = {
            'BaseRequest': self.get_base_request(),
            'SyncKey': self.SyncKey,
            'rr': ~int(time.time())
        }
        r = self.s.post(url, data)
        text = r.text
        json_data = json.loads(text)

        if json_data['BaseResponse']['Ret'] == 0:  # 更新同步键
            self.SyncKey = json_data['SyncKey']
            SyncKey = json_data['SyncCheckKey'] or json_data['SyncKey']
            self.sync_key = '|'.join([str(item['Key']) + '_' + str(item['Val']) for item in SyncKey['List']])
        return json_data

    #发送文字内容
    def send_msg(self,msg, to_user_name='filehelper'):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxsendmsg?pass_ticket=%s' % self.pass_ticket

        data = {
            "BaseRequest":self.get_BaseRequest_content(),
            "Msg":{
                "ClientMsgId":self.get_LocalID(),
                "Content":msg,
                "FromUserName":self.my_account['UserName'],
                "LocalID":self.get_LocalID(),
                "ToUserName":to_user_name,
                "Type":1
            },
            "Scene":0
        }
        data = json.dumps(data, ensure_ascii=False).encode('utf-8')
        r = self.s.post(url, data=data)
        json_data = r.json()
        if 0 == json_data['BaseResponse']['Ret']:
            print('发送消息成功')
        else:
            print('发送消息失败 %s' % r.text)


    # 上传图片素材
    def upload_media(self, file_path, to_user_name='filehelper'):
        print("上传图片中。。。。。。")
        # if not os.path.exists(pic_path):
        #     print('[ERROR] File not exists.')
        #     return False

        file_size = os.path.getsize(file_path)

        file_symbol = 'pic'

        with open(file_path, 'rb') as f:
            file_md5 = hashlib.md5(f.read()).hexdigest()

        file_ = open(file_path, 'rb')
        try:
            chunks = math.ceil(file_size/self.UPLOAD_CHUNK_MAX_SIZE)
            upload_media_request = json.dumps(OrderedDict([
                ('UploadType', 2),
                ('BaseRequest', self.get_BaseRequest_content()),
                ('ClientMediaId', int(get_13_time())),
                ('TotalLen', file_size),
                ('StartPos', 0),
                ('DataLen', file_size),
                ('MediaType', 4),
                ('FromUserName', self.my_account['UserName']),
                ('ToUserName', to_user_name),
                ('FileMd5', file_md5)]
            ))

            for chunk in range(chunks):
                r = self.upload_chunk_file(file_path, file_symbol, file_size,
                                                 file_, chunk, chunks, upload_media_request)
                text = r.text
                MediaId = json.loads(text)['MediaId']
                if MediaId:
                    self.MediaId = MediaId
                    print("上传图片成功。。。。。。")
                    return MediaId
        finally:
            file_.close()

        print("上传图片失败。。。。。。")
        return False

    def upload_chunk_file(self, file_path, file_symbol, file_size, file, chunk, chunks, uploadMediaRequest):
        url = 'https://file.wx.qq.com/cgi-bin/mmwebwx-bin/webwxuploadmedia?f=json'
        file_name = os.path.basename(file_path)
        file_type = mimetypes.guess_type(file_name)[0] or 'application/octet-stream'

        '''
         fn, fp = v
         fn, fp = (None, file_name)
         fn = None
         fp = file_name
        '''
        files = OrderedDict([
            ('id', (None, 'WU_FILE_0')),
            ('name', (None, file_name)),
            ('type', (None, file_type)),
            ('lastModifiedDate', (None, time.strftime('%a %b %d %Y %H:%M:%S GMT+0800 (CST)'))),
            ('size', (None, str(file_size))),
            ('chunks', (None, str(chunks))),
            ('chunk', (None, str(chunk))),
            ('mediatype', (None, file_symbol)),
            ('uploadmediarequest', (None, uploadMediaRequest)),
            ('webwx_data_ticket', (None, self.s.cookies['webwx_data_ticket'])),
            ('pass_ticket', (None, self.pass_ticket)),
            ('filename', (file_name, file.read(self.UPLOAD_CHUNK_MAX_SIZE), 'application/octet-stream'))])
        if chunks == 1:
            del files['chunk']
            del files['chunks']
        return self.s.post(url, files=files, headers=UPLOAD_FILE_HEADERS)

    # 发送图片到指定的username
    def send_img(self, to_user_name='filehelper'):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxsendmsgimg'
        params = {
            'fun': 'async',
            'f': 'json',
            'pass_ticket': self.pass_ticket
        }
        data = {
            "BaseRequest": self.get_BaseRequest_content(),
            "Msg": {
                "Type": 3,
                "MediaId": self.MediaId,
                "Content": "",
                "FromUserName": self.my_account['UserName'],
                "ToUserName": to_user_name,
                "LocalID": self.get_LocalID(),
                "ClientMsgId": self.get_LocalID()
            },
            "Scene": 0
        }

        r = self.s.post(url, params=params, json=data)

        json_data = r.json()
        if 0 == json_data['BaseResponse']['Ret']:
            print('发送图片成功')
        else:
            print('发送图片失败 %s' % r.text)

    def get_LocalID(self):
        return str(time.time()) + str(random.random())[2:9]

    def get_synccheck_(self):
        if self.sync_check_:
            self.sync_check_ += 1
        else:
            self.sync_check_ = int(get_13_time())
        return str(self.sync_check_)

    def get_deviceID(self):
        return 'e' + str(random.random())[2:17]

    '''
    同步服务器是否有需要更新的消息，没有的话服务器阻塞25s返回0

    第一个的synccheck的参数是从init的response获取
    只要访问了webwxsync，就会更新synckey
    '''
    #拼接synckey
    # def get_str_from_synckey(self):
    #     l = self.SyncKey['list']
    #     return '|'.join([str(k['Key']) + '_' + str(k['Val']) for k in l])
    def get_str_from_synckey(self):
        l = self.SyncKey['List']
        return '|'.join([str(k['Key']) + '_' + str(k['Val']) for k in l ])

    def visit_synccheck(self):
        url = 'https://webpush.wx.qq.com/cgi-bin/mmwebwx-bin/synccheck'
        params = {
            'r': get_13_time(),
            'skey': self.skey,
            'sid': self.wxsid,
            'uin': self.wxuin,
            'deviceid': self.get_deviceID(),
            'synckey': self.get_str_from_synckey(),
            '_': self.get_synccheck_()
        }

        r = self.s.get(url, params=params)
        text = r.text
        matches = re.search('selector:"(.*?)"', text)
        selector = matches.group(1)

        if '0' == selector:
            print("没有收到消息")
        elif '2' == selector:
            print("收到消息，需要更新")
        else:
            print('未处理的情况%s ' % selector)

    def visit_webwxsync(self):
        url = 'https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxsync'
        params = {
            'sid': self.wxsid,
            'skey': self.skey,
            'pass_ticket': self.pass_ticket
        }
        data = {
            "BaseRequest": self.get_BaseRequest_content(),
            "SyncKey": self.SyncKey,
            "rr": ~int(time.time())
        }

        r = self.s.post(url, params=params, json=data)
        r.encoding = 'UTF-8'
        json_data = r.json()
        self.SyncKey = json_data['SyncKey']
        add_msg_list = json_data['AddMsgList']

        for msg in add_msg_list:
            print('消息类型：%s， 消息内容：%s， 从哪来：%s， 发给:%s' %
                  (msg['MsgType'], msg['Content'], msg['FromUserName'], msg['ToUserName']))

            # if json_data['BaseResponse']['Ret'] == 0:  # 更新同步键
            #     self.SyncKey = json_data['SyncKey']
            #     SyncKey = json_data['SyncCheckKey'] or json_data['SyncKey']
            #     self.sync_key = '|'.join([str(item['Key']) + '_' + str(item['Val']) for item in SyncKey['List']])
            # return json_data

    # 循环访问服务器，获取是否有更新的消息
    def loop_sync_check(self):
        # 增加死循环的停止控制
        while True:
            self.visit_synccheck()
            time.sleep(.5)

    def thread_loop_sync_check(self):
        self.thread_loop = threading.Thread(target=self.loop_sync_check, args=())
        self.thread_loop.start()

if __name__ == '__main__':
    wx = WXRobot()
    wx.visit_index()
    wx.visit_jslogin()
    wx.visit_vcode()
    b = wx.visit_login()

    if b:
        wx.visit_newloginpage()
        wx.visit_init()

        wx.visit_statusnotify()
        wx.visit_getcontact()

        #wx.visit_batchgetcontact()
        # wx.send_msg('测试内容!!')
        #
        # pic_path = os.path.join(os.getcwd(), 'qrcode.jpg')
        # wx.upload_media(pic_path)
        #
        # user_name = '"@0d51e94e04ddc6914640c93e32ba435db2a5e57693a9f5e9f723611b5b3894c0'
        # wx.send_img()

        wx.thread_loop_sync_check()
        wx.thread_loop.join()

    print('运行结束')