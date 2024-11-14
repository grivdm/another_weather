import 'package:another_weather/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _defaultCityName = Constants.DEFAULT_CITY;
  static const String keyCityName = 'city_name';
  static final PreferenceManager _instance = PreferenceManager._internal();
  factory PreferenceManager() => _instance;
  PreferenceManager._internal();

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
    return _prefs?.getString(keyCityName) ?? _defaultCityName;
  }
}
