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

  /// `Fazakir`
  String get app_name {
    return Intl.message(
      'Fazakir',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `The journey of light begins here, be the first to discover our new spiritual app`
  String get light_journey_begins_here {
    return Intl.message(
      'The journey of light begins here, be the first to discover our new spiritual app',
      name: 'light_journey_begins_here',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get show_all {
    return Intl.message(
      'Show All',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  /// `The Holy Quran`
  String get holy_quran {
    return Intl.message(
      'The Holy Quran',
      name: 'holy_quran',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Search for a zikr or hadith ...`
  String get search_zikr_or_hadith {
    return Intl.message(
      'Search for a zikr or hadith ...',
      name: 'search_zikr_or_hadith',
      desc: '',
      args: [],
    );
  }

  /// `Shortcuts`
  String get shortcuts {
    return Intl.message(
      'Shortcuts',
      name: 'shortcuts',
      desc: '',
      args: [],
    );
  }

  /// `Mention of the Day from..`
  String get mention_of_the_day {
    return Intl.message(
      'Mention of the Day from..',
      name: 'mention_of_the_day',
      desc: '',
      args: [],
    );
  }

  /// `About Religion`
  String get about_religion {
    return Intl.message(
      'About Religion',
      name: 'about_religion',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Your Home`
  String get your_home {
    return Intl.message(
      'Your Home',
      name: 'your_home',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_times {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_times',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Podcast: `
  String get podcast {
    return Intl.message(
      'Podcast: ',
      name: 'podcast',
      desc: '',
      args: [],
    );
  }

  /// `Some error occurred`
  String get some_error_occurred {
    return Intl.message(
      'Some error occurred',
      name: 'some_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `You are now facing the correct Qibla!`
  String get correct_qibla {
    return Intl.message(
      'You are now facing the correct Qibla!',
      name: 'correct_qibla',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for compass data ...`
  String get waiting_for_compass_data {
    return Intl.message(
      'Waiting for compass data ...',
      name: 'waiting_for_compass_data',
      desc: '',
      args: [],
    );
  }

  /// `Move for better results`
  String get move_for_better_results {
    return Intl.message(
      'Move for better results',
      name: 'move_for_better_results',
      desc: '',
      args: [],
    );
  }

  /// `Tilt and move your phone about 3 times like this:`
  String get tilt_and_move_phone {
    return Intl.message(
      'Tilt and move your phone about 3 times like this:',
      name: 'tilt_and_move_phone',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Sibha`
  String get sebha {
    return Intl.message(
      'Sibha',
      name: 'sebha',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
