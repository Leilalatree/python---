# -*- coding:utf-8 -*-
import gevent
import requests

def get_response(url):
    html = requests.get(url).text