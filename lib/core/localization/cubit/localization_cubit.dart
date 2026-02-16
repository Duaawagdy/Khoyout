import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../db/cash_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  // Singleton accessor for easier retrieval in the widget tree
  static LocalizationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  // Current locale (default is set to system's locale or a default locale)
  Locale _locale = CashHelper.getString(key: Keys.language) != null
      ? Locale(CashHelper.getString(key: Keys.language)!)
      : ui.window.locale; // Default to English

  // Getter for the current locale
  Locale get locale => _locale;

  //Method to change the locale
  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await CashHelper.putString(key: Keys.language, value: languageCode);
    emit(
        LocalizationChanged(Locale(languageCode))); // Emit the new locale state
  }


  Future<void> toggleLanguage() async {
    // Toggle between Arabic and English
    if (_locale.languageCode == 'en') {
      _locale = const Locale('ar');
      await CashHelper.putString(key: Keys.language, value: 'ar');
    } else {
      _locale = const Locale('en');
      await CashHelper.putString(key: Keys.language, value: 'en');
    }
    emit(LocalizationChanged(_locale));
  }
}
