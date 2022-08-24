#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import re
import pinyin
import shutil
import colorsys
from PIL import Image, ImageDraw, ImageFont

def get_dominant_colors(infile):
    image = Image.open(infile)

    max_score = 0
    dominant_color = 0

    for count, (r, g, b, a) in image.getcolors(image.size[0] * image.size[1]):
       # 跳过纯黑色
       if a == 0:
           continue
       if r == 180 and g == 195 and b == 240:
           continue


       saturation = colorsys.rgb_to_hsv(r / 255.0, g / 255.0, b / 255.0)[1]

       y = min(abs(r * 2104 + g * 4130 + b * 802 + 4096 + 131072) >> 13, 235)

       y = (y - 16.0) / (235 - 16)

       # 忽略高亮色
       if y > 0.9:
           continue

       # Calculate the score, preferring highly saturated colors.
       # Add 0.1 to the saturation so we don't completely ignore grayscale
       # colors by multiplying the count by zero, but still give them a low
       # weight.
       score = (saturation + 0.1) * count

       if score > max_score:
           max_score = score
           dominant_color = (r, g, b)

    return dominant_color





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



def collect(path, name, banklist):
    color = get_dominant_colors(path)
#     print(path)
#     print(color)
    strs = name.split("_")
    key = strs[1].replace(".png", "")
    banklist.append((strs[0], key , name, color))
    return key




def forIcons():
    bankkv = []
    for file in files:
            if not os.path.isdir(file):
                banklist = []
                banks = os.listdir(path+"/"+file)
                for bank in banks:
                    if ".DS_Store" in bank:
                            continue
                    else:
                        name = rename(replaceLogoStr(bank))
                        src_dir = path+"/"+file+ "/" + bank
                        key = collect(src_dir, name, banklist)
                        dst_dir = "../assets/keep_accounts/bank/"+ file+ "/"+ key + ".png"
    #                     shutil.copy(src_dir,dst_dir)
                bankkv.append((file,banklist))
                print ("deal dir " + file)
    return bankkv


def generateBank(bankkv):
    srccode = ''' ///GenerateCodeStart
    static List<Map<String, BankData>> banks = <Map<String, BankData>>[
     gydxsyyh, // 国有大型商业银行
     gfzsyyh, // 股份制商业银行
     cssyyh, // 城市商业银行
     wzfryh // 外资法人银行
    ];\n'''
    for k, v in bankkv:
        print(k)
        listBankData = []
        head = '''  static Map<String, BankData> %s = <String, BankData>{''' % (k)
        for a, b , c, d in v:
            str = '''  "%s": BankData(
                             key: '%s',
                             name: '%s',
                             logo: '%s',
                             mainColor: const Color.fromRGBO(%s, %s, %s, 1.0)
                            )''' % (b, b, a, "assets/keep_accounts/bank/"+ k+ "/"+ b + ".png", d[0], d[1], d[2])
            listBankData.append(str)

        content = ', \n'.join(listBankData)
        tail = '\n};'
        srccode = srccode + head + content + tail
    return srccode + '\n  ///GenerateCodeEnd'

path = "bank"
files = os.listdir(path)

bankkv = forIcons()
print(len(bankkv))
content = generateBank(bankkv)

file = open('../lib/keep_accounts/models/bank_data.dart',mode='r')

all_of_it = file.read()
all_of_it = re.sub(r'///GenerateCodeStart[\s\S]*///GenerateCodeEnd', content, all_of_it)
file.close()
print(all_of_it)
with open('../lib/keep_accounts/models/bank_data.dart', 'w') as f:
    f.write(all_of_it + "")
