#第十次 作业：
'''

'''

#1.打开文件，修改内容，写入另一个文件。
#  把文件reform.txt中的名人名言改成“某某说：......”的形式保存到另一个文件中。
'例：雨果说：大胆是取得进步所付出的代价。'





  
#2.针对实例化矩行类时，输入字符串等错误参数，写一个提示异常。
'''
class Rectangle:
    def __init__(self,length,width):
        if isinstance(length,(int,float)) and isinstance(width,(int,float)):
        #if ( type(length) == int or  type(length) == float )  and (type(width) ==int or type(widh) == float):
            self.length = length
            self.width = width
        else:
            return 'ERROR'
    def area(self):
        return self.length * self.width
  
'''
'''
try:
    n
except Exception:
    print(Exception)
'''


