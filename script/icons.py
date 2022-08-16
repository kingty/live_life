#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import re
import pinyin
import shutil

iconskv = []

path = "../assets/keep_accounts/icons/icons_dark"
files = os.listdir(path)
for dir in files:
    icons = os.listdir(path + "/" + dir)
    list = []
    for icon in icons:
        list.append(icon)
    iconskv.append((dir, list))


for k, v in iconskv:
    print("- assets/keep_accounts/icons/icons_dark/" + k)
    print("- assets/keep_accounts/icons/icons_light/" + k)