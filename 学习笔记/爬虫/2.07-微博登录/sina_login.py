# -*- coding:utf-8 -*-
from urllib import parse
import base64
user = '15921052260'
def user_encrypt(user):
    user = parse.quote(user)
    user = base64.b64encode(user.encode())
    return user.decode()

print(user_encrypt(user))