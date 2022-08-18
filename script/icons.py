#!/usr/bin/python
# -*- coding: UTF-8 -*-

import json


def parseFontJson():
    f = open('IconFont.json')
    icons = json.load(f)
    for icon in icons:
        print(icon['unicode'])

def dealCategory():
    outcome = []
    income = []
    in_cas = []
    cas = outcome

    with open('category.md') as md:
        lines = md.readlines()
        for line in lines:
            if line.strip().startswith('#') or line.strip() == "":
                continue
            else:
                if line.startswith('----'):
                    cas = income
                elif line.startswith('-'):
                    in_cas = []
                    cas.append((line.strip(), in_cas))
                else:
                    in_cas.append(line.strip())

    return (outcome, income)
cas = dealCategory()

for ca in cas[0]:
    print(ca)

print('-----------')
for ca in cas[1]:
    print(ca)