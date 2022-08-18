import 'dart:ui';

import 'package:flutter/material.dart';

class BankData {
  BankData(
      {this.key = '',
      this.name = '',
      this.logo = '',
      this.mainColor = Colors.white});

  String key;
  String name;
  String logo;
  Color mainColor;
  int temp = 23;

  String simpleName() {
    if (name == '中国银行') return name;
    return name.replaceAll('中国', '');
  }

  static List<Map<String, BankData>> banks = <Map<String, BankData>>[
    gydxsyyh, // 国有大型商业银行
    gfzsyyh, // 股份制商业银行
    cssyyh, // 城市商业银行
    wzfryh // 外资法人银行
  ];

  static Map<String, BankData> cssyyh = <String, BankData>{
    "MTBANK": BankData(
        key: 'MTBANK',
        name: '浙江民泰商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/MTBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "RBOZ": BankData(
        key: 'RBOZ',
        name: '珠海华润银行',
        logo: 'assets/keep_accounts/bank/cssyyh/RBOZ.png',
        mainColor: const Color.fromRGBO(244, 162, 28, 1.0)),
    "LZBANK": BankData(
        key: 'LZBANK',
        name: '兰州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LZBANK.png',
        mainColor: const Color.fromRGBO(0, 80, 158, 1.0)),
    "QLBANK": BankData(
        key: 'QLBANK',
        name: '齐鲁银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QLBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "GZCB": BankData(
        key: 'GZCB',
        name: '广州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GZCB.png',
        mainColor: const Color.fromRGBO(216, 35, 33, 1.0)),
    "SXCB": BankData(
        key: 'SXCB',
        name: '绍兴银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SXCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BOCY": BankData(
        key: 'BOCY',
        name: '朝阳银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOCY.png',
        mainColor: const Color.fromRGBO(2, 81, 152, 1.0)),
    "FXCB": BankData(
        key: 'FXCB',
        name: '阜新银行',
        logo: 'assets/keep_accounts/bank/cssyyh/FXCB.png',
        mainColor: const Color.fromRGBO(0, 91, 172, 1.0)),
    "KELBANK": BankData(
        key: 'KELBANK',
        name: '库尔勒银行',
        logo: 'assets/keep_accounts/bank/cssyyh/KELBANK.png',
        mainColor: const Color.fromRGBO(190, 51, 56, 1.0)),
    "LSCCB": BankData(
        key: 'LSCCB',
        name: '乐山市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LSCCB.png',
        mainColor: const Color.fromRGBO(218, 37, 28, 1.0)),
    "FJHXBC": BankData(
        key: 'FJHXBC',
        name: '福建海峡银行',
        logo: 'assets/keep_accounts/bank/cssyyh/FJHXBC.png',
        mainColor: const Color.fromRGBO(4, 122, 198, 1.0)),
    "YTBANK": BankData(
        key: 'YTBANK',
        name: '烟台银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YTBANK.png',
        mainColor: const Color.fromRGBO(107, 180, 43, 1.0)),
    "BOP": BankData(
        key: 'BOP',
        name: '平顶山银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOP.png',
        mainColor: const Color.fromRGBO(192, 4, 21, 1.0)),
    "BHB": BankData(
        key: 'BHB',
        name: '河北银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BHB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "JSB": BankData(
        key: 'JSB',
        name: '晋商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JSB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "LJBANK": BankData(
        key: 'LJBANK',
        name: '龙江银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LJBANK.png',
        mainColor: const Color.fromRGBO(251, 190, 2, 1.0)),
    "JXBANK": BankData(
        key: 'JXBANK',
        name: '嘉兴银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JXBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "XJBANK": BankData(
        key: 'XJBANK',
        name: '新疆银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XJBANK.png',
        mainColor: const Color.fromRGBO(0, 72, 122, 1.0)),
    "BOSZ": BankData(
        key: 'BOSZ',
        name: '苏州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOSZ.png',
        mainColor: const Color.fromRGBO(100, 143, 52, 1.0)),
    "XABANK": BankData(
        key: 'XABANK',
        name: '西安银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XABANK.png',
        mainColor: const Color.fromRGBO(0, 41, 90, 1.0)),
    "LZBANK": BankData(
        key: 'LZBANK',
        name: '泸州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LZBANK.png',
        mainColor: const Color.fromRGBO(166, 38, 38, 1.0)),
    "NXBANK": BankData(
        key: 'NXBANK',
        name: '宁夏银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NXBANK.png',
        mainColor: const Color.fromRGBO(236, 29, 36, 1.0)),
    "CZCB": BankData(
        key: 'CZCB',
        name: '浙江稠州商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CZCB.png',
        mainColor: const Color.fromRGBO(167, 34, 38, 1.0)),
    "ZGBANK": BankData(
        key: 'ZGBANK',
        name: '自贡银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ZGBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "CZBANK": BankData(
        key: 'CZBANK',
        name: '沧州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CZBANK.png',
        mainColor: const Color.fromRGBO(0, 67, 129, 1.0)),
    "YQCCB": BankData(
        key: 'YQCCB',
        name: '阳泉市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YQCCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "YASSYBANK": BankData(
        key: 'YASSYBANK',
        name: '雅安市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YASSYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SRBANK": BankData(
        key: 'SRBANK',
        name: '上饶银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SRBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "XJHHBANK": BankData(
        key: 'XJHHBANK',
        name: '新疆汇和银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XJHHBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "MSBANK": BankData(
        key: 'MSBANK',
        name: '蒙商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/MSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HRXJBANK": BankData(
        key: 'HRXJBANK',
        name: '华融湘江银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HRXJBANK.png',
        mainColor: const Color.fromRGBO(192, 4, 21, 1.0)),
    "LSBANK": BankData(
        key: 'LSBANK',
        name: '莱商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "NYBANK": BankData(
        key: 'NYBANK',
        name: '广东南粤银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "JHCCB": BankData(
        key: 'JHCCB',
        name: '金华银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JHCCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "JZZLBANK": BankData(
        key: 'JZZLBANK',
        name: '焦作中旅银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JZZLBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "YBCCB": BankData(
        key: 'YBCCB',
        name: '宜宾市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YBCCB.png',
        mainColor: const Color.fromRGBO(29, 32, 136, 1.0)),
    "CDBANK": BankData(
        key: 'CDBANK',
        name: '承德银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CDBANK.png',
        mainColor: const Color.fromRGBO(196, 35, 42, 1.0)),
    "JZBANK": BankData(
        key: 'JZBANK',
        name: '晋中银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JZBANK.png',
        mainColor: const Color.fromRGBO(194, 48, 51, 1.0)),
    "JSBANK": BankData(
        key: 'JSBANK',
        name: '江苏银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "LSBC": BankData(
        key: 'LSBC',
        name: '临商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LSBC.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "XCBANK": BankData(
        key: 'XCBANK',
        name: '西藏银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XCBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "CCQTGB": BankData(
        key: 'CCQTGB',
        name: '重庆三峡银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CCQTGB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HRBCB": BankData(
        key: 'HRBCB',
        name: '哈尔滨银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HRBCB.png',
        mainColor: const Color.fromRGBO(234, 92, 3, 1.0)),
    "BOYK": BankData(
        key: 'BOYK',
        name: '营口银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOYK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "MYSYBANK": BankData(
        key: 'MYSYBANK',
        name: '绵阳商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/MYSYBANK.png',
        mainColor: const Color.fromRGBO(0, 91, 172, 1.0)),
    "FDBANK": BankData(
        key: 'FDBANK',
        name: '富滇银行',
        logo: 'assets/keep_accounts/bank/cssyyh/FDBANK.png',
        mainColor: const Color.fromRGBO(180, 29, 34, 1.0)),
    "GSBANK": BankData(
        key: 'GSBANK',
        name: '甘肃银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "JNBANK": BankData(
        key: 'JNBANK',
        name: '济宁银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JNBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "QDCCB": BankData(
        key: 'QDCCB',
        name: '青岛银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QDCCB.png',
        mainColor: const Color.fromRGBO(216, 3, 19, 1.0)),
    "YNHTBANK": BankData(
        key: 'YNHTBANK',
        name: '云南红塔银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YNHTBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "ZZBANK": BankData(
        key: 'ZZBANK',
        name: '枣庄银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ZZBANK.png',
        mainColor: const Color.fromRGBO(0, 136, 194, 1.0)),
    "ASBANK": BankData(
        key: 'ASBANK',
        name: '鞍山银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ASBANK.png',
        mainColor: const Color.fromRGBO(204, 32, 30, 1.0)),
    "LFBANK": BankData(
        key: 'LFBANK',
        name: '廊坊银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LFBANK.png',
        mainColor: const Color.fromRGBO(0, 160, 232, 1.0)),
    "JXBANK": BankData(
        key: 'JXBANK',
        name: '江西银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JXBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "WZBANK": BankData(
        key: 'WZBANK',
        name: '温州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/WZBANK.png',
        mainColor: const Color.fromRGBO(249, 183, 31, 1.0)),
    "NDHB": BankData(
        key: 'NDHB',
        name: '宁波东海银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NDHB.png',
        mainColor: const Color.fromRGBO(221, 37, 37, 1.0)),
    "QHDBANK": BankData(
        key: 'QHDBANK',
        name: '秦皇岛银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QHDBANK.png',
        mainColor: const Color.fromRGBO(1, 92, 170, 1.0)),
    "JINCHB": BankData(
        key: 'JINCHB',
        name: '晋城银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JINCHB.png',
        mainColor: const Color.fromRGBO(196, 24, 41, 1.0)),
    "BOD": BankData(
        key: 'BOD',
        name: '东莞银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOD.png',
        mainColor: const Color.fromRGBO(222, 1, 18, 1.0)),
    "SNBANK": BankData(
        key: 'SNBANK',
        name: '遂宁银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SNBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BOSC": BankData(
        key: 'BOSC',
        name: '上海银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOSC.png',
        mainColor: const Color.fromRGBO(15, 70, 155, 1.0)),
    "TLCB": BankData(
        key: 'TLCB',
        name: '浙江泰隆商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/TLCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HSBANK": BankData(
        key: 'HSBANK',
        name: '衡水银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "XMBANK": BankData(
        key: 'XMBANK',
        name: '厦门银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XMBANK.png',
        mainColor: const Color.fromRGBO(0, 91, 156, 1.0)),
    "TLBANK": BankData(
        key: 'TLBANK',
        name: '铁岭银行',
        logo: 'assets/keep_accounts/bank/cssyyh/TLBANK.png',
        mainColor: const Color.fromRGBO(214, 25, 25, 1.0)),
    "LYBANK": BankData(
        key: 'LYBANK',
        name: '辽阳银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LYBANK.png',
        mainColor: const Color.fromRGBO(198, 0, 12, 1.0)),
    "CZBANK": BankData(
        key: 'CZBANK',
        name: '长治银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CZBANK.png',
        mainColor: const Color.fromRGBO(230, 33, 25, 1.0)),
    "JLBANK": BankData(
        key: 'JLBANK',
        name: '吉林银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JLBANK.png',
        mainColor: const Color.fromRGBO(220, 9, 23, 1.0)),
    "JZBANK": BankData(
        key: 'JZBANK',
        name: '锦州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JZBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "HNB": BankData(
        key: 'HNB',
        name: '海南银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HNB.png',
        mainColor: const Color.fromRGBO(0, 161, 98, 1.0)),
    "XTB": BankData(
        key: 'XTB',
        name: '邢台银行',
        logo: 'assets/keep_accounts/bank/cssyyh/XTB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "WFCCB": BankData(
        key: 'WFCCB',
        name: '潍坊银行',
        logo: 'assets/keep_accounts/bank/cssyyh/WFCCB.png',
        mainColor: const Color.fromRGBO(215, 14, 25, 1.0)),
    "RZB": BankData(
        key: 'RZB',
        name: '日照银行',
        logo: 'assets/keep_accounts/bank/cssyyh/RZB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "WHBANK": BankData(
        key: 'WHBANK',
        name: '乌海银行',
        logo: 'assets/keep_accounts/bank/cssyyh/WHBANK.png',
        mainColor: const Color.fromRGBO(210, 8, 25, 1.0)),
    "ZZBANK": BankData(
        key: 'ZZBANK',
        name: '郑州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ZZBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "JJCCB": BankData(
        key: 'JJCCB',
        name: '九江银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JJCCB.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "HLDBANK": BankData(
        key: 'HLDBANK',
        name: '葫芦岛银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HLDBANK.png',
        mainColor: const Color.fromRGBO(215, 1, 16, 1.0)),
    "SJBANK": BankData(
        key: 'SJBANK',
        name: '盛京银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SJBANK.png',
        mainColor: const Color.fromRGBO(230, 0, 25, 1.0)),
    "BOTS": BankData(
        key: 'BOTS',
        name: '唐山银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOTS.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "GZBANK": BankData(
        key: 'GZBANK',
        name: '贵州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GZBANK.png',
        mainColor: const Color.fromRGBO(222, 1, 18, 1.0)),
    "GHB": BankData(
        key: 'GHB',
        name: '广东华兴银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GHB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "QJSSYBANK": BankData(
        key: 'QJSSYBANK',
        name: '曲靖市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QJSSYBANK.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "KLB": BankData(
        key: 'KLB',
        name: '昆仑银行',
        logo: 'assets/keep_accounts/bank/cssyyh/KLB.png',
        mainColor: const Color.fromRGBO(192, 4, 21, 1.0)),
    "SICHUAN": BankData(
        key: 'SICHUAN',
        name: '四川天府银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SICHUAN.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SZSBK": BankData(
        key: 'SZSBK',
        name: '石嘴山银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SZSBK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HKB": BankData(
        key: 'HKB',
        name: '汉口银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HKB.png',
        mainColor: const Color.fromRGBO(0, 134, 178, 1.0)),
    "LZCCB": BankData(
        key: 'LZCCB',
        name: '柳州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LZCCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "NJCB": BankData(
        key: 'NJCB',
        name: '南京银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NJCB.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "DLB": BankData(
        key: 'DLB',
        name: '大连银行',
        logo: 'assets/keep_accounts/bank/cssyyh/DLB.png',
        mainColor: const Color.fromRGBO(199, 0, 12, 1.0)),
    "BSCB": BankData(
        key: 'BSCB',
        name: '长沙银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BSCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SMGJBANK": BankData(
        key: 'SMGJBANK',
        name: '厦门国际银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SMGJBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SCB": BankData(
        key: 'SCB',
        name: '四川银行',
        logo: 'assets/keep_accounts/bank/cssyyh/SCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "WHCCB": BankData(
        key: 'WHCCB',
        name: '威海市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/WHCCB.png',
        mainColor: const Color.fromRGBO(0, 104, 182, 1.0)),
    "BDBANK": BankData(
        key: 'BDBANK',
        name: '保定银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BDBANK.png',
        mainColor: const Color.fromRGBO(166, 13, 19, 1.0)),
    "TACCB": BankData(
        key: 'TACCB',
        name: '泰安银行',
        logo: 'assets/keep_accounts/bank/cssyyh/TACCB.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "PJBANK": BankData(
        key: 'PJBANK',
        name: '盘锦银行',
        logo: 'assets/keep_accounts/bank/cssyyh/PJBANK.png',
        mainColor: const Color.fromRGBO(229, 51, 43, 1.0)),
    "HBC": BankData(
        key: 'HBC',
        name: '湖北银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HBC.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "TJBANK": BankData(
        key: 'TJBANK',
        name: '天津银行',
        logo: 'assets/keep_accounts/bank/cssyyh/TJBANK.png',
        mainColor: const Color.fromRGBO(13, 87, 159, 1.0)),
    "DTBANK": BankData(
        key: 'DTBANK',
        name: '大同银行',
        logo: 'assets/keep_accounts/bank/cssyyh/DTBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "CDCB": BankData(
        key: 'CDCB',
        name: '成都银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CDCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "UCCB": BankData(
        key: 'UCCB',
        name: '乌鲁木齐银行',
        logo: 'assets/keep_accounts/bank/cssyyh/UCCB.png',
        mainColor: const Color.fromRGBO(0, 93, 169, 1.0)),
    "GYCCB": BankData(
        key: 'GYCCB',
        name: '贵阳银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GYCCB.png',
        mainColor: const Color.fromRGBO(231, 0, 18, 1.0)),
    "DZBANK": BankData(
        key: 'DZBANK',
        name: '德州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/DZBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BODD": BankData(
        key: 'BODD',
        name: '丹东银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BODD.png',
        mainColor: const Color.fromRGBO(185, 27, 36, 1.0)),
    "H3CB": BankData(
        key: 'H3CB',
        name: '内蒙古银行',
        logo: 'assets/keep_accounts/bank/cssyyh/H3CB.png',
        mainColor: const Color.fromRGBO(207, 0, 15, 1.0)),
    "TZBANK": BankData(
        key: 'TZBANK',
        name: '台州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/TZBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "QHBANK": BankData(
        key: 'QHBANK',
        name: '青海银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QHBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BGB": BankData(
        key: 'BGB',
        name: '广西北部湾银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BGB.png',
        mainColor: const Color.fromRGBO(250, 199, 2, 1.0)),
    "JSCJSYBANK": BankData(
        key: 'JSCJSYBANK',
        name: '江苏长江商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/JSCJSYBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "YKYHBANK": BankData(
        key: 'YKYHBANK',
        name: '营口沿海银行',
        logo: 'assets/keep_accounts/bank/cssyyh/YKYHBANK.png',
        mainColor: const Color.fromRGBO(215, 23, 24, 1.0)),
    "BXSSYBANK": BankData(
        key: 'BXSSYBANK',
        name: '本溪市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BXSSYBANK.png',
        mainColor: const Color.fromRGBO(231, 0, 18, 1.0)),
    "ZYBANK": BankData(
        key: 'ZYBANK',
        name: '中原银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ZYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "NBTSBANK": BankData(
        key: 'NBTSBANK',
        name: '宁波通商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NBTSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HDBANK": BankData(
        key: 'HDBANK',
        name: '邯郸银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HDBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "DCCB": BankData(
        key: 'DCCB',
        name: '达州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/DCCB.png',
        mainColor: const Color.fromRGBO(115, 82, 34, 1.0)),
    "ZJKCCB": BankData(
        key: 'ZJKCCB',
        name: '张家口银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ZJKCCB.png',
        mainColor: const Color.fromRGBO(235, 0, 24, 1.0)),
    "GLBANK": BankData(
        key: 'GLBANK',
        name: '桂林银行',
        logo: 'assets/keep_accounts/bank/cssyyh/GLBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BOB": BankData(
        key: 'BOB',
        name: '北京银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOB.png',
        mainColor: const Color.fromRGBO(229, 0, 18, 1.0)),
    "CABANK": BankData(
        key: 'CABANK',
        name: '长安银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CABANK.png',
        mainColor: const Color.fromRGBO(222, 5, 22, 1.0)),
    "CCHXBANK": BankData(
        key: 'CCHXBANK',
        name: '长城华西银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CCHXBANK.png',
        mainColor: const Color.fromRGBO(10, 125, 183, 1.0)),
    "NBCB": BankData(
        key: 'NBCB',
        name: '宁波银行',
        logo: 'assets/keep_accounts/bank/cssyyh/NBCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "DYCCB": BankData(
        key: 'DYCCB',
        name: '东营银行',
        logo: 'assets/keep_accounts/bank/cssyyh/DYCCB.png',
        mainColor: const Color.fromRGBO(222, 1, 18, 1.0)),
    "CQBANK": BankData(
        key: 'CQBANK',
        name: '重庆银行',
        logo: 'assets/keep_accounts/bank/cssyyh/CQBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "BOQZ": BankData(
        key: 'BOQZ',
        name: '泉州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/BOQZ.png',
        mainColor: const Color.fromRGBO(0, 102, 179, 1.0)),
    "QSBANK": BankData(
        key: 'QSBANK',
        name: '齐商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/QSBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "HSBANK": BankData(
        key: 'HSBANK',
        name: '徽商银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HSBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "ORDOSB": BankData(
        key: 'ORDOSB',
        name: '鄂尔多斯银行',
        logo: 'assets/keep_accounts/bank/cssyyh/ORDOSB.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "HMSSYBANK": BankData(
        key: 'HMSSYBANK',
        name: '哈密市商业银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HMSSYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HZCB": BankData(
        key: 'HZCB',
        name: '杭州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HZCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "LYBANK": BankData(
        key: 'LYBANK',
        name: '洛阳银行',
        logo: 'assets/keep_accounts/bank/cssyyh/LYBANK.png',
        mainColor: const Color.fromRGBO(0, 58, 129, 1.0)),
    "HZBANK": BankData(
        key: 'HZBANK',
        name: '湖州银行',
        logo: 'assets/keep_accounts/bank/cssyyh/HZBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "FSCB": BankData(
        key: 'FSCB',
        name: '抚顺银行',
        logo: 'assets/keep_accounts/bank/cssyyh/FSCB.png',
        mainColor: const Color.fromRGBO(213, 23, 25, 1.0))
  };
  static Map<String, BankData> gfzsyyh = <String, BankData>{
    "CMBC": BankData(
        key: 'CMBC',
        name: '中国民生银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/CMBC.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SPABANK": BankData(
        key: 'SPABANK',
        name: '平安银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/SPABANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "CMB": BankData(
        key: 'CMB',
        name: '招商银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/CMB.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "CIB": BankData(
        key: 'CIB',
        name: '兴业银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/CIB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "GDB": BankData(
        key: 'GDB',
        name: '广发银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/GDB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "EGBANK": BankData(
        key: 'EGBANK',
        name: '恒丰银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/EGBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "ZSBANK": BankData(
        key: 'ZSBANK',
        name: '浙商银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/ZSBANK.png',
        mainColor: const Color.fromRGBO(230, 0, 18, 1.0)),
    "BOHAIB": BankData(
        key: 'BOHAIB',
        name: '渤海银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/BOHAIB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SPDB": BankData(
        key: 'SPDB',
        name: '上海浦东发展银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/SPDB.png',
        mainColor: const Color.fromRGBO(1, 40, 130, 1.0)),
    "HXB": BankData(
        key: 'HXB',
        name: '华夏银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/HXB.png',
        mainColor: const Color.fromRGBO(216, 12, 24, 1.0)),
    "CEB": BankData(
        key: 'CEB',
        name: '中国光大银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/CEB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "CITIC": BankData(
        key: 'CITIC',
        name: '中信银行',
        logo: 'assets/keep_accounts/bank/gfzsyyh/CITIC.png',
        mainColor: const Color.fromRGBO(215, 0, 15, 1.0))
  };
  static Map<String, BankData> gydxsyyh = <String, BankData>{
    "CCB": BankData(
        key: 'CCB',
        name: '建设银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/CCB.png',
        mainColor: const Color.fromRGBO(6, 86, 159, 1.0)),
    "ICBC": BankData(
        key: 'ICBC',
        name: '中国工商银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/ICBC.png',
        mainColor: const Color.fromRGBO(207, 1, 6, 1.0)),
    "ABC": BankData(
        key: 'ABC',
        name: '中国农业银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/ABC.png',
        mainColor: const Color.fromRGBO(0, 152, 130, 1.0)),
    "COMM": BankData(
        key: 'COMM',
        name: '交通银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/COMM.png',
        mainColor: const Color.fromRGBO(0, 54, 122, 1.0)),
    "PSBC": BankData(
        key: 'PSBC',
        name: '中国邮政储蓄银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/PSBC.png',
        mainColor: const Color.fromRGBO(17, 138, 63, 1.0)),
    "BOC": BankData(
        key: 'BOC',
        name: '中国银行',
        logo: 'assets/keep_accounts/bank/gydxsyyh/BOC.png',
        mainColor: const Color.fromRGBO(184, 28, 34, 1.0))
  };
  static Map<String, BankData> wzfryh = <String, BankData>{
    "BOSH": BankData(
        key: 'BOSH',
        name: '新韩银行',
        logo: 'assets/keep_accounts/bank/wzfryh/BOSH.png',
        mainColor: const Color.fromRGBO(0, 116, 192, 1.0)),
    "FLBSDBANK": BankData(
        key: 'FLBSDBANK',
        name: '菲律宾首都银行',
        logo: 'assets/keep_accounts/bank/wzfryh/FLBSDBANK.png',
        mainColor: const Color.fromRGBO(22, 74, 162, 1.0)),
    "FGXYBANK": BankData(
        key: 'FGXYBANK',
        name: '法国兴业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/FGXYBANK.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "SMBC": BankData(
        key: 'SMBC',
        name: '三井住友银行',
        logo: 'assets/keep_accounts/bank/wzfryh/SMBC.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "DYZBANK": BankData(
        key: 'DYZBANK',
        name: '德意志银行',
        logo: 'assets/keep_accounts/bank/wzfryh/DYZBANK.png',
        mainColor: const Color.fromRGBO(38, 41, 138, 1.0)),
    "HGGMBANK": BankData(
        key: 'HGGMBANK',
        name: '韩国国民银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HGGMBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "RSBANK": BankData(
        key: 'RSBANK',
        name: '瑞士银行',
        logo: 'assets/keep_accounts/bank/wzfryh/RSBANK.png',
        mainColor: const Color.fromRGBO(171, 184, 226, 1.0)),
    "PGBANK": BankData(
        key: 'PGBANK',
        name: '盘谷银行',
        logo: 'assets/keep_accounts/bank/wzfryh/PGBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "KBANK": BankData(
        key: 'KBANK',
        name: '开泰银行',
        logo: 'assets/keep_accounts/bank/wzfryh/KBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HSBANK": BankData(
        key: 'HSBANK',
        name: '华商银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HSBANK.png',
        mainColor: const Color.fromRGBO(207, 1, 6, 1.0)),
    "DXBANK": BankData(
        key: 'DXBANK',
        name: '大新银行',
        logo: 'assets/keep_accounts/bank/wzfryh/DXBANK.png',
        mainColor: const Color.fromRGBO(181, 22, 80, 1.0)),
    "FGBLBANK": BankData(
        key: 'FGBLBANK',
        name: '法国巴黎银行',
        logo: 'assets/keep_accounts/bank/wzfryh/FGBLBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HKBEA": BankData(
        key: 'HKBEA',
        name: '东亚银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HKBEA.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "ANZ": BankData(
        key: 'ANZ',
        name: '澳大利亚和新西兰银行',
        logo: 'assets/keep_accounts/bank/wzfryh/ANZ.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "SCB": BankData(
        key: 'SCB',
        name: '渣打银行',
        logo: 'assets/keep_accounts/bank/wzfryh/SCB.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "TWYSBANK": BankData(
        key: 'TWYSBANK',
        name: '台湾玉山银行',
        logo: 'assets/keep_accounts/bank/wzfryh/TWYSBANK.png',
        mainColor: const Color.fromRGBO(0, 157, 150, 1.0)),
    "ZXBANK": BankData(
        key: 'ZXBANK',
        name: '正信银行',
        logo: 'assets/keep_accounts/bank/wzfryh/ZXBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "ZXYXGJBANK": BankData(
        key: 'ZXYXGJBANK',
        name: '中信银行国际',
        logo: 'assets/keep_accounts/bank/wzfryh/ZXYXGJBANK.png',
        mainColor: const Color.fromRGBO(215, 0, 15, 1.0)),
    "FGDFHLBANK": BankData(
        key: 'FGDFHLBANK',
        name: '法国东方汇理银行',
        logo: 'assets/keep_accounts/bank/wzfryh/FGDFHLBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "PFGGBANK": BankData(
        key: 'PFGGBANK',
        name: '浦发硅谷银行',
        logo: 'assets/keep_accounts/bank/wzfryh/PFGGBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HANABANK": BankData(
        key: 'HANABANK',
        name: '韩亚银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HANABANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "MGSDLGJBANK": BankData(
        key: 'MGSDLGJBANK',
        name: '摩根士丹利国际银行',
        logo: 'assets/keep_accounts/bank/wzfryh/MGSDLGJBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HGYLBANK": BankData(
        key: 'HGYLBANK',
        name: '韩国友利银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HGYLBANK.png',
        mainColor: const Color.fromRGBO(0, 156, 219, 1.0)),
    "NCB": BankData(
        key: 'NCB',
        name: '南洋商业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/NCB.png',
        mainColor: const Color.fromRGBO(215, 0, 16, 1.0)),
    "MGDTBANK": BankData(
        key: 'MGDTBANK',
        name: '摩根大通银行',
        logo: 'assets/keep_accounts/bank/wzfryh/MGDTBANK.png',
        mainColor: const Color.fromRGBO(3, 68, 146, 1.0)),
    "HSBANK": BankData(
        key: 'HSBANK',
        name: '恒生银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HSBANK.png',
        mainColor: const Color.fromRGBO(254, 0, 9, 1.0)),
    "DHBANK": BankData(
        key: 'DHBANK',
        name: '大华银行',
        logo: 'assets/keep_accounts/bank/wzfryh/DHBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "XLSYBANK": BankData(
        key: 'XLSYBANK',
        name: '新联商业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/XLSYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "YFBANK": BankData(
        key: 'YFBANK',
        name: '永丰银行',
        logo: 'assets/keep_accounts/bank/wzfryh/YFBANK.png',
        mainColor: const Color.fromRGBO(230, 37, 17, 1.0)),
    "GTSHBANK": BankData(
        key: 'GTSHBANK',
        name: '国泰世华银行',
        logo: 'assets/keep_accounts/bank/wzfryh/GTSHBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HQBANK": BankData(
        key: 'HQBANK',
        name: '花旗银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HQBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "HMBANK": BankData(
        key: 'HMBANK',
        name: '华美银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HMBANK.png',
        mainColor: const Color.fromRGBO(220, 2, 42, 1.0)),
    "HGQYBANK": BankData(
        key: 'HGQYBANK',
        name: '韩国企业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HGQYBANK.png',
        mainColor: const Color.fromRGBO(0, 164, 226, 1.0)),
    "HQYHBANK": BankData(
        key: 'HQYHBANK',
        name: '华侨永亨银行',
        logo: 'assets/keep_accounts/bank/wzfryh/HQYHBANK.png',
        mainColor: const Color.fromRGBO(229, 1, 19, 1.0)),
    "FBHYBANK": BankData(
        key: 'FBHYBANK',
        name: '富邦华一银行',
        logo: 'assets/keep_accounts/bank/wzfryh/FBHYBANK.png',
        mainColor: const Color.fromRGBO(0, 149, 204, 1.0)),
    "ZYSYBANK": BankData(
        key: 'ZYSYBANK',
        name: '彰银商业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/ZYSYBANK.png',
        mainColor: const Color.fromRGBO(230, 0, 32, 1.0)),
    "RSSYBANK": BankData(
        key: 'RSSYBANK',
        name: '瑞穗实业银行',
        logo: 'assets/keep_accounts/bank/wzfryh/RSSYBANK.png',
        mainColor: const Color.fromRGBO(161, 174, 215, 1.0)),
    "DBSCN": BankData(
        key: 'DBSCN',
        name: '星展银行',
        logo: 'assets/keep_accounts/bank/wzfryh/DBSCN.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0)),
    "MTLEBANK": BankData(
        key: 'MTLEBANK',
        name: '蒙特利尔银行',
        logo: 'assets/keep_accounts/bank/wzfryh/MTLEBANK.png',
        mainColor: const Color.fromRGBO(227, 0, 22, 1.0))
  };
}
