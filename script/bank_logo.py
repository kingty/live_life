#!/usr/bin/python
# -*- coding: UTF-8 -*-

# 打开一个文件
import json
import requests
with open('banklogo.json', 'r') as fcc_file:
    fcc_data = json.load(fcc_file)

    for k, v in fcc_data.items():
        print(v[0]['logo'])
        print(k + '.png')
        myfile = requests.get(v[0]['logo'])
        open(k + '.png', 'wb').write(myfile.content)
#         wget.download(v[0]['logo'], k + '.png')
