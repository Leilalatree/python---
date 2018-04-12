#!/usr/bin/env python
# -*- coding: utf-8 -*-
from urllib import parse
from urllib.parse import unquote

__author__ = 'Terry'

base_url = 'https://s.taobao.com/search?sourceId=tb.index&search_type=item' \
               '&ssid=s5-e&commend=all&imgfile=&q={}' \
               '&_input_charset=utf-8&wq=&suggest_query=&source=suggest' \
               '&sort=sale-desc&bcoffset=0&p4ppushleft=%2C{}&s={}'

print(base_url.format(1,2,3))