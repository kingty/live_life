// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `主页`
  String get HOME {
    return Intl.message(
      '主页',
      name: 'HOME',
      desc: '',
      args: [],
    );
  }

  /// `本月`
  String get KEEP_ACCOUNTS_OVERVIEW {
    return Intl.message(
      '本月',
      name: 'KEEP_ACCOUNTS_OVERVIEW',
      desc: '',
      args: [],
    );
  }

  /// `收入`
  String get KEEP_ACCOUNTS_INCOME {
    return Intl.message(
      '收入',
      name: 'KEEP_ACCOUNTS_INCOME',
      desc: '',
      args: [],
    );
  }

  /// `结余`
  String get KEEP_ACCOUNTS_BALANCE {
    return Intl.message(
      '结余',
      name: 'KEEP_ACCOUNTS_BALANCE',
      desc: '',
      args: [],
    );
  }

  /// `支出`
  String get KEEP_ACCOUNTS_EXPENSES {
    return Intl.message(
      '支出',
      name: 'KEEP_ACCOUNTS_EXPENSES',
      desc: '',
      args: [],
    );
  }

  /// `元`
  String get KEEP_ACCOUNTS_RMB {
    return Intl.message(
      '元',
      name: 'KEEP_ACCOUNTS_RMB',
      desc: '',
      args: [],
    );
  }

  /// `资产`
  String get KEEP_ACCOUNTS_ACCOUNT {
    return Intl.message(
      '资产',
      name: 'KEEP_ACCOUNTS_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `今天支出`
  String get KEEP_ACCOUNTS_TODAY {
    return Intl.message(
      '今天支出',
      name: 'KEEP_ACCOUNTS_TODAY',
      desc: '',
      args: [],
    );
  }

  /// `本周支出`
  String get KEEP_ACCOUNTS_THIS_WEEK {
    return Intl.message(
      '本周支出',
      name: 'KEEP_ACCOUNTS_THIS_WEEK',
      desc: '',
      args: [],
    );
  }

  /// `管理`
  String get KEEP_ACCOUNTS_THIS_EDIT {
    return Intl.message(
      '管理',
      name: 'KEEP_ACCOUNTS_THIS_EDIT',
      desc: '',
      args: [],
    );
  }

  /// `近期账单`
  String get KEEP_ACCOUNTS_TRANSACTION {
    return Intl.message(
      '近期账单',
      name: 'KEEP_ACCOUNTS_TRANSACTION',
      desc: '',
      args: [],
    );
  }

  /// `更多`
  String get KEEP_ACCOUNTS_THIS_MORE {
    return Intl.message(
      '更多',
      name: 'KEEP_ACCOUNTS_THIS_MORE',
      desc: '',
      args: [],
    );
  }

  /// `资产管理`
  String get KEEP_ACCOUNTS_ASSET_MANAGEMENT {
    return Intl.message(
      '资产管理',
      name: 'KEEP_ACCOUNTS_ASSET_MANAGEMENT',
      desc: '',
      args: [],
    );
  }

  /// `收支日历`
  String get KEEP_ACCOUNTS_TRANSACTION_CALENDER {
    return Intl.message(
      '收支日历',
      name: 'KEEP_ACCOUNTS_TRANSACTION_CALENDER',
      desc: '',
      args: [],
    );
  }

  /// `添加账户`
  String get KEEP_ACCOUNTS_ADD_ACCOUNT {
    return Intl.message(
      '添加账户',
      name: 'KEEP_ACCOUNTS_ADD_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `编辑账户`
  String get KEEP_ACCOUNTS_EDIT_ACCOUNT {
    return Intl.message(
      '编辑账户',
      name: 'KEEP_ACCOUNTS_EDIT_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `统计`
  String get KEEP_ACCOUNTS_STATISTICS {
    return Intl.message(
      '统计',
      name: 'KEEP_ACCOUNTS_STATISTICS',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ch'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
