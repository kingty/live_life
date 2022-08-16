#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import re
import pinyin
import shutil

def getStrAllAplha(str):
    return pinyin.get_initial(str, delimiter="").upper()

def getStrFirstAplha(str):
    str=getStrAllAplha(str)
    str=str[0:1]
    return str.upper()



# 替换'logo'
def replaceLogoStr(bank):
    name = bank
    if  "logo" in bank:
        line = re.sub(r'logo.*\.png', "", bank)
        name = line.strip() + ".png"
    return name.replace(" todo", "")



# 更改名字
def rename(bank):
    result = bank
    if not " " in bank:
        if "银行.png" in bank:
            name = bank.replace("银行.png", "")
        else:
            name = bank.replace(".png", "")
        shortcut = getStrAllAplha(name)


        first = bank.replace(".png", "")

        second = "_" + shortcut + "BANK_T"
        result = first + second + ".png"
    else :
        result = bank.replace(" ", "_")

    return result



def collect(bank, list):
    strs = bank.split("_")
    key = strs[1].replace(".png", "")
    list.append((strs[0], key , bank))
    return key



path = "bank"
files = os.listdir(path)


bankkv = []



for file in files:
        if not os.path.isdir(file):
            list = []
            banks = os.listdir(path+"/"+file)
            for bank in banks:
                if ".DS_Store" in bank:
                        continue
                else:
                    name = rename(replaceLogoStr(bank))
                    key = collect(name, list)
                    src_dir = path+"/"+file+ "/" + bank
                    dst_dir = "../assets/keep_accounts/bank/"+ file+ "/"+ key + ".png"
#                     print(dst_dir)
#                     shutil.copy(src_dir,dst_dir)
            bankkv.append((file,list))



for k, v in bankkv:
    listBankData = []
    head = '''static Map<String, BankData> %s = <String, BankData>{''' % (k)
    for a, b , c in v:
        str = '''"%s": BankData(
                     key: '%s',
                     name: '%s',
                     logo: '%s'
                   )''' % (b, b, a, "assets/keep_accounts/bank/"+ k+ "/"+ b + ".png")
        listBankData.append(str)

    content = ', \n'.join(listBankData)

    tail = '\n};'

    print(head + content + tail)
