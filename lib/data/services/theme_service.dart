import 'package:hive/hive.dart';

class ThemeService {
  static const _boxName = 'settingsBox';
  static const _key = 'isDarkMode';

  /// Save theme preference
  static Future<void> saveTheme(bool isDarkMode) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_key, isDarkMode);
  }

  /// Load saved theme, defaults to false (light)
  static Future<bool> loadTheme() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_key, defaultValue: false);
  }
}
