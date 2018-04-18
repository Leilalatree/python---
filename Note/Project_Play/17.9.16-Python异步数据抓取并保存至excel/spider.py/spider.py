import requests
import xlwt
headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
             'AppleWebKit/537.36 (KHTML, like Gecko) Chrome'
             '/60.0.3112.113 Safari/537.36',
'Cookie':'user_trace_token=20170919101443-a577808e-f752-452e-8a60-a7bf8bc4af9c; LGUID=20170919101444-4da62ae0-9ce0-11e7-919b-5254005c3644; JSESSIONID=ABAAABAACDBABJBFDF3BF78FC7599990B472A114A37F279; _putrc=A24BAB7EE3B1FDC5; login=true; unick=%E9%BB%84%E6%97%A5%E6%96%B0; showExpriedIndex=1; showExpriedCompanyHome=1; showExpriedMyPublish=1; hasDeliver=0; TG-TRACK-CODE=search_code; X_HTTP_TOKEN=d1dc24d44ce64ffd54643033d5fbc329; _gat=1; PRE_UTM=; PRE_HOST=; PRE_SITE=https%3A%2F%2Fwww.lagou.com%2Fjobs%2Flist_%25E7%2588%25AC%25E8%2599%25AB%3Fpx%3Ddefault%26city%3D%25E5%2585%25A8%25E5%259B%25BD; PRE_LAND=https%3A%2F%2Fwww.lagou.com%2Fjobs%2Flist_python%3Fcity%3D%25E5%2585%25A8%25E5%259B%25BD%26cl%3Dfalse%26fromSearch%3Dtrue%26labelWords%3D%26suginput%3D; _ga=GA1.2.1024338724.1505787272; _gid=GA1.2.1751725820.1505787272; LGSID=20170919141637-17d15d19-9d02-11e7-97ec-525400f775ce; LGRID=20170919142150-d28b3cad-9d02-11e7-97ed-525400f775ce; Hm_lvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1505787861,1505792004,1505794828,1505795250; Hm_lpvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1505802098; SEARCH_ID=74a02f4486904479a478268d09bb42a2; index_location_city=%E5%85%A8%E5%9B%BD',
'Referer':'https://www.lagou.com/jobs/list_python?px=default&city=%E5%8C%97%E4%BA%AC'
}


def getJobList(page):
    data = {
        'first': 'true',
        'pn': page,
        'kd': 'python'
    }
    res = requests.post('https://www.lagou.com/jobs/positionAja'
                        'x.json?px=default&city=%E5%8C%97%E4%BA'
                        '%AC&needAddtionalResult=false&isSchoolJ'
                        'ob=0',data=data,headers=headers)#发起一个post请求

    result = res.json()
    jobs = result['content']['positionResult']['result']
    return jobs

excelTable = xlwt.Workbook()#创建excel对象
sheet1 = excelTable.add_sheet('lagou',cell_overwrite_ok=True)

sheet1.write(0, 0, '岗位名')
sheet1.write(0, 1, '薪酬范围')
sheet1.write(0, 2, '工作年限')
sheet1.write(0, 3, '学历')
sheet1.write(0, 4,'全职/兼职')
sheet1.write(0, 5, '城市')
sheet1.write(0, 6, '公司别名')
sheet1.write(0, 7, '区域')
# sheet1.write(0, 8, job['positionLables'])
sheet1.write(0, 8, '公司人数')
sheet1.write(0, 9, '岗位类型')
sheet1.write(0, 10, '公司全称')
n = 1

for page in range(1,31):
    print(page)
    data = getJobList(page=page)
    print(page)
    for job in data:
        print(job)
        sheet1.write(n, 0, job['positionName'])
        sheet1.write(n, 1, job['salary'])
        sheet1.write(n, 2, job['workYear'])
        sheet1.write(n, 3, job['education'])
        sheet1.write(n, 4, job['jobNature'])
        sheet1.write(n, 5, job['city'])
        sheet1.write(n, 6, job['companyShortName'])
        sheet1.write(n, 7, job['district'])
        # sheet1.write(0, 8, job['positionLables'])
        sheet1.write(n, 8, job['companySize'])
        sheet1.write(n, 9, job['secondType'])
        sheet1.write(n, 10, job['companyFullName'])
        n += 1
     #   import time
    #time.sleep(1)

excelTable.save('lagou.xls')