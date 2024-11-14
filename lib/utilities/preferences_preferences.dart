import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const String defaultCityName = 'New York';
  static const String keyCityName = 'city_name';
  static final PreferencesManager _instance = PreferencesManager._internal();
  factory PreferencesManager() => _instance;
  PreferencesManager._internal();

  SharedPreferencesWithCache? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{keyCityName},
    ));
  }

  Future<void> setCityName(String value) async {
    return _prefs?.setString(keyCityName, value);
  }

  String getCityName() {
    return _prefs?.getString(keyCityName) ?? defaultCityName;
  }
}
