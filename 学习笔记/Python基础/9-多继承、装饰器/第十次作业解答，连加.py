x=1.2
'看清楚y没定义'
try:
    x * y
except NameError:
    print('啥东西未定义')
except TypeError:
    print('发生什么了')


class Rectangle:
    def __init__(self,length,width):
        try:
            if isinstance(length,(int,float)) and isinstance(width,(int,float)):
            #if ( type(length) == int or  type(length) == float )  and (type(width) ==int or type(widh) == float):
                self.length = length
                self.width = width
            else:
                raise Exception
        except TypeError:
            raise TypeError
        except NameError:
            print('kkk没定义')
        
    def area(self):
        return self.length * self.width
