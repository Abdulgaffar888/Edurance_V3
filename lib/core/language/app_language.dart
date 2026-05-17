import 'package:flutter/foundation.dart';

/// A lightweight, centralized language state manager.
class AppLanguage {
  /// The currently selected application language code.
  /// Defaults to English ('en'). Supported values: 'en', 'hi'.
  static final ValueNotifier<String> currentLanguage = ValueNotifier('en');

  /// Toggles between English ('en') and Hindi ('hi').
  static void toggleLanguage() {
    currentLanguage.value = currentLanguage.value == 'en' ? 'hi' : 'en';
  }
}
