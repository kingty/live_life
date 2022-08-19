#!/usr/bin/python
# encoding:utf-8
import json
import re

def generateCustomIconsCode():
    f = open('IconFont.json')
    icons = json.load(f)
    lines = []
    lines2 = []
    srccode = '''///GenerateCodeStart\n'''
    for icon in icons:
        name = icon['name'].replace('/', '_').replace('-', '_')
        line = '''  static const IconData %s = IconData(0x%s, fontFamily: 'IconFont'); '''% (name, icon['unicode'])
        line2 = '''      "%s" : %s,'''% (name, name)
        lines.append(line)
        lines2.append(line2)
    srccode = srccode + ' \n'.join(lines)

    srccode = srccode + ' \n'

    srccode = srccode + '''  static Map<String, IconData> customIcons = <String, IconData>{\n'''
    srccode = srccode + ' \n'.join(lines2)
    srccode = srccode + '''\n   };'''
    srccode = srccode + '''\n  ///GenerateCodeEnd'''

    file = open('../lib/icons/custom_icons.dart',mode='r')
    all_of_it = file.read()
    all_of_it = re.sub(r'///GenerateCodeStart[\s\S]*///GenerateCodeEnd', srccode, all_of_it)
    file.close()
    with open('../lib/icons/custom_icons.dart', 'w') as f:
        f.write(all_of_it + "")


def getDetails(ca):

    pair = ca.replace("- ", "").split("%")
    obj = {
      "name": pair[0],
      "icon": pair[1],
      "id": int(pair[2])
    }
    return obj

def dealCategory():
    outcome = []
    income = []
    in_cas = []
    cas = outcome

    with open('category.md', encoding="utf-8") as md:
        lines = md.readlines()
        for line in lines:
            if line.strip().startswith('#') or line.strip() == "":
                continue
            else:
                if line.startswith('----'):
                    cas = income
                elif line.startswith('-'):
                    in_cas = []
                    obj = (getDetails(line.strip()))
                    obj['children'] = in_cas
                    cas.append(obj)
                else:
                    in_cas.append(getDetails(line.strip()))

    return {'income': income, 'outcome': outcome}

def generateCategoryJson():
    cas = dealCategory()
    all_of_it=json.dumps(cas, ensure_ascii=False, sort_keys=True, indent=4, separators=(', ', ': '))

    with open('../assets/keep_accounts/category.json', 'w') as f:
            f.write(all_of_it + "")

generateCustomIconsCode()
generateCategoryJson()