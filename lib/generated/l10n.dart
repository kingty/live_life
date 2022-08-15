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

  /// `HOME`
  String get HOME {
    return Intl.message(
      'HOME',
      name: 'HOME',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get KEEP_ACCOUNTS_OVERVIEW {
    return Intl.message(
      'Overview',
      name: 'KEEP_ACCOUNTS_OVERVIEW',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get KEEP_ACCOUNTS_INCOME {
    return Intl.message(
      'Income',
      name: 'KEEP_ACCOUNTS_INCOME',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get KEEP_ACCOUNTS_BALANCE {
    return Intl.message(
      'Balance',
      name: 'KEEP_ACCOUNTS_BALANCE',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get KEEP_ACCOUNTS_EXPENSES {
    return Intl.message(
      'Expenses',
      name: 'KEEP_ACCOUNTS_EXPENSES',
      desc: '',
      args: [],
    );
  }

  /// `RMB`
  String get KEEP_ACCOUNTS_RMB {
    return Intl.message(
      'RMB',
      name: 'KEEP_ACCOUNTS_RMB',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get KEEP_ACCOUNTS_ACCOUNT {
    return Intl.message(
      'Accounts',
      name: 'KEEP_ACCOUNTS_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get KEEP_ACCOUNTS_TODAY {
    return Intl.message(
      'Today',
      name: 'KEEP_ACCOUNTS_TODAY',
      desc: '',
      args: [],
    );
  }

  /// `This week`
  String get KEEP_ACCOUNTS_THIS_WEEK {
    return Intl.message(
      'This week',
      name: 'KEEP_ACCOUNTS_THIS_WEEK',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get KEEP_ACCOUNTS_THIS_MORE {
    return Intl.message(
      'Edit',
      name: 'KEEP_ACCOUNTS_THIS_MORE',
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
