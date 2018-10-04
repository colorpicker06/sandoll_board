# -*- coding: utf-8 -*-
import sys
import io
reload(sys)
sys.setdefaultencoding('utf-8')

#sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')
#sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')

import requests
import pymysql
from bs4 import BeautifulSoup
from datetime import datetime

url = "http://www.sandollcloud.com/font/Sandoll.html"
print(url)

response = requests.get(url)

conn = pymysql.connect(host='localhost', user='root', password='1234', db='sandoll_board',charset='utf8')
cursor = conn.cursor()

soup = BeautifulSoup(response.text, 'html.parser')

list = soup.select('dl')
div = list[0]
for li in list:
    a = li.find('dt')

    title = a.text.strip()

    replace_1 = title.replace("Sandoll"," ")

    #print(title)
    print(replace_1)
    sql = "INSERT INTO font_family(font_family_name) values(%s)"
    cursor.execute(sql,(replace_1))

conn.commit()
conn.close()
