class Settings {
  int startHour = 0;
  int endHour = 24;
  bool _isDarkMode = false;

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