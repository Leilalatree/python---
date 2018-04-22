import pymysql
import random
#数据库配置
HOST = '101.132.73.130'
PORT = 3306
USER = 'huangrixin'
PASSWD = 'huang123'
DB = 'proxypool'
CHARSET = 'utf8'

class GetIP(object):

    def get_ip(self):
        config = {
            'host': HOST,
            'port': PORT,
            'user': USER,
            'passwd': PASSWD,
            'db': DB,
            'charset': CHARSET
        }
        db = pymysql.connect(**config)
        cursor = db.cursor()
        PROXIES_POOL = []
        # 执行SQL语句
        cursor.execute(
            '''
            select ip,port
            from proxypool.available
            WHERE type = "HTTPS"
            ''')
        # 获取所有记录列表
        results = cursor.fetchall()
        for result in results:
            ip = {'ip_port':'{}:{}'.format(result[0],result[1])}
            PROXIES_POOL.append(ip)
        db.close()
        #print(PROXIES_POOL)
        return PROXIES_POOL

    def get_random_ip(self,PROXIES_POOL):
        ip_list = []
        for i in PROXIES_POOL:
            ip = i['ip_port']
            ip_list.append(ip)
        one_ip = random.choice(ip_list)
        return one_ip

