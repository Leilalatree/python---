# -*- coding:utf-8 -*-
import random

'''
    this.guideRandom = function () {
        return "xxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace
        (/[xy]/g, function (e) {
            var t = 16 * Math.random() | 0,
            n = "x" == e ? t : 3 & t | 8;
            return n.toString(16)
        }).toUpperCase()
    }
    ()

    function (e) {
        # | 0  其实就小数取整 ,   0<=Math.random()<1 ，
        # 最终，这个t 就是一个 :  0<= t < 16
        var t = 16 * Math.random() | 0,
        n = "x" == e ? t : 3 & t | 8;
        return n.toString(16)
    }

    gid的生成
'''

def gid_encrypt():
    s_raw = 'xxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

    s_ret = ''
    for s in s_raw:
        t = random.randint(0, 16)
        if 'x' == s:
            n = t
            s_ret += hex(n)[-1:]
        elif 'y' == s:
            n =  3 & t | 8
            s_ret += hex(n)[-1:]
        else:
            s_ret += s

    return s_ret.upper()

'''
    _SBCtoDBC：e为输入的密码
    _SBCtoDBC: function(e) {
        var t = "";
        if (e) {
            for (var n = e.length, i = 0; n > i; i++) {
                var s = e.charCodeAt(i);
                s = s >= 65281 && 65374 >= s ? s - 65248 : s,
                s = 12288 == s ? 32 : s,
                t += String.fromCharCode(s)
            }
            return t
        }
    }

    暂时可以不用理会。
'''
'''
    password:密码是先进行rsa加密，然后在进行base64


    pubkey进行转换，e为pubkey
    pn.prototype.parseKey = function(e) {
            try {
                var t = /^\s*(?:[0-9A-Fa-f][0-9A-Fa-f]\s*)+$/
                  , n = t.test(e) ? Hex.decode(e) : Base64.unarmor(e)
                  , i = ASN1.decode(n);
                if (9 === i.sub.length) {
                    var s = i.sub[1].getHexStringValue();
                    this.n = dn(s, 16);
                    var o = i.sub[2].getHexStringValue();
                    this.e = parseInt(o, 16);
                    var r = i.sub[3].getHexStringValue();
                    this.d = dn(r, 16);
                    var a = i.sub[4].getHexStringValue();
                    this.p = dn(a, 16);
                    var c = i.sub[5].getHexStringValue();
                    this.q = dn(c, 16);
                    var l = i.sub[6].getHexStringValue();
                    this.dmp1 = dn(l, 16);
                    var d = i.sub[7].getHexStringValue();
                    this.dmq1 = dn(d, 16);
                    var u = i.sub[8].getHexStringValue();
                    this.coeff = dn(u, 16)
                } else {
                    if (2 !== i.sub.length)
                        return !1;
                    var p = i.sub[1]
                      , g = p.sub[0]
                      , s = g.sub[0].getHexStringValue();
                    this.n = dn(s, 16);
                    var o = g.sub[1].getHexStringValue();
                    this.e = parseInt(o, 16)
                }
                return !0
            } catch (h) {
                return !1
            }
        }

        # pubkey 的base64解码
        decode = function(n) {
            var i;
            if (t === e) {
                var s = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
                  , o = "= \f\n\r	 \u2028\u2029";
                for (t = [],
                i = 0; 64 > i; ++i)
                    t[s.charAt(i)] = i;
                for (i = 0; i < o.length; ++i)
                    t[o.charAt(i)] = -1
            }
            var r = []
              , a = 0
              , c = 0;
            for (i = 0; i < n.length; ++i) {
                var l = n.charAt(i);
                if ("=" == l)
                    break;
                if (l = t[l],
                -1 != l) {
                    if (l === e)
                        throw "Illegal character at offset " + i;
                    a |= l,
                    ++c >= 4 ? (r[r.length] = a >> 16,
                    r[r.length] = a >> 8 & 255,
                    r[r.length] = 255 & a,
                    a = 0,
                    c = 0) : a <<= 6
                }
            }
            switch (c) {
            case 1:
                throw "Base64 encoding incomplete: at least 2 bits missing";
            case 2:
                r[r.length] = a >> 10;
                break;
            case 3:
                r[r.length] = a >> 16,
                r[r.length] = a >> 8 & 255
            }
            return r
        }
'''

import rsa
import binascii

def rsa_encrypt(message, rsa_n, rsa_e='10001'):
    rsa_e = int(rsa_e, 16)
    rsa_n = int(rsa_n, 16)
    key = rsa.PublicKey(rsa_n, rsa_e)  # 创建公钥
    message = rsa.encrypt(message, key)  # 加密
    message = binascii.b2a_hex(message)  # 将加密信息转换为16进制
    return message.decode()

def rsa_n_gen(pubkey):
    l = pubkey.split("\n")

    return ''.join(l[1:-2])  # 去掉列表的第一个和最后2个

import base64
pwd = '123'

pubkey = '-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8Xi84NDp0cJaLE59L6yINeF3Q\nr9TpcNSq2Eg\/s5O80vinCcjA+xJQL\/bEO4RT8drvrbh4hsEz1O5C3Jt0bl9GhiCP\nCo0t1fuHT66VzE0ALqYPgdBM5Od6UfMr8mD6tW28+zmhjN6++Q8DK25U16SujYaA\n0H8S0PqKlN6X\/ZHlTQIDAQAB\n-----END PUBLIC KEY-----\n'
rsa_n = rsa_n_gen(pubkey)

rsa_e = '010001'  # 和 rsa_e = '10001'  没区别

key = rsa_n_gen(pubkey)
print(key)
print(base64.b64decode(key))

# pwd_rsa = rsa_encry0pt(pwd, rsa_n, rsa_e)
# pwd_re = base64.b64encode(pwd_rsa.encode())

'''
    fp_uid:
    https://passport.baidu.com/static/passpc-base/js/dv/dm.min.js
    127行：
    function r() {
        for (var e = "", t = 0, n = 0; 32 > n; n++)
            if (12 == n)
                e += " ";
            else {
                var r = 16 * Math.random() | 0
                  , a = 16 != n ? r : 3 & r | 8;
                t += a,
                e += a.toString(16)
            }
        return e.replace(" ", (t % 16).toString(16)).toLowerCase()
    }
'''
def uid_encrypt():
    e = ""
    t = 0
    for n in range(32):
        if 12 == n:
            e += " "
        else:
            r = random.randint(0, 15)   # 0 <= r <= 15
            if 16 == n:
                a = 3 & r | 8
            else:
                a = r
            t += a
            e += hex(a)[2:]

    return e.replace(" ", hex(t % 16)[2:]).lower()


'''
    traceid:
    createHeadID: function() {
        var e = this
          , t = (new Date).getTime() + e.getRandom().toString()
          , n = Number(t).toString(16)
          , i = n.length
          , s = n.slice(i - 6, i).toUpperCase();
        e.headID = s
    }
    getFlowID: function(e) {
        var t = {
            login: "01",
            reg: "02"
        };
        return t[e]
    }

'''
import time
def trace_head_id_encrypt():
    t = str(int(time.time()*1000)) + str(random.randint(10, 100))
    t_hex = hex(int(t))
    t_ret = t_hex[-6:]

    return t_ret.upper()