import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings {
  int startHour = 0;
  int endHour = 24;
  bool _isDarkMode = false;
  bool autoLogin = false;
  bool selectedHalfHourLines = false;
  String currentLocale = 'en';

  void setLocale(String locale) {
    currentLocale = locale;
  }

  String getLocale() {
    return currentLocale;
  }

  void setSelectedHalfHourLines(bool halfHourLines) {
    selectedHalfHourLines = halfHourLines;
  }

  bool getSelectedHalfHourLines() {
    return selectedHalfHourLines;
  }

  void setAutoLogin(bool value) {
    autoLogin = value;
  }

  bool getAutoLogin() {
    return autoLogin;
  }

  void setStartHour(int hour) {
    startHour = hour;
  }

  int getStartHour() {
    return startHour;
  }

  void setEndHour(int hour) {
    endHour = hour;
  }

  int getEndHour() {
    return endHour;
  }

  bool isDarkMode() {
    return _isDarkMode;
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
  }
}
