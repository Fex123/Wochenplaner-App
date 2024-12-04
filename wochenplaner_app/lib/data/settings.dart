class Settings {
  int startHour = 0;
  int endHour = 24;
  bool _isDarkMode = false;
  bool autoLogin = false;
  bool selectedHalfHourLines = false;
  
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