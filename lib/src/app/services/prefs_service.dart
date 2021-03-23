import 'package:shared_preferences/shared_preferences.dart';

/// Constants for SharedPreferences
class SharedPrefKeys {
  SharedPrefKeys._();
  static const String theme = 'theme';
}

class SharedPreferencesService {
  SharedPreferencesService._internal();

  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService?> get instance async {
    _instance ??= SharedPreferencesService._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  Future<void> setTheme(String theme) async =>
      await _preferences?.setString(SharedPrefKeys.theme, theme);

  String? get theme => _preferences?.getString(SharedPrefKeys.theme);
}
