import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/utilities/constants.dart';

class OpenweatherApi {
  static Future<WeatherForecast> fetchCityWeatherForecast(
      {required String cityName}) async {
    var queryParameters = {
      'units': 'metric',
      'appid': Constants.OPENWEATHERAPP_KEY,
      'q': cityName
    };

    Uri uri = Uri.https(Constants.OPENWEATHER_BASE_URL,
        Constants.OPENWEATHER_FORECAST_PATH, queryParameters);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return Future.error('City not found');
    } else {
      throw Exception('Error response: ${response.body}');
    }
  }

  static Future<WeatherForecast> fetchLocationWeatherForecast(
      {required double lat, required double lng}) async {
    var queryParameters = {
      'units': 'metric',
      'appid': Constants.OPENWEATHERAPP_KEY,
      'lat': lat.toString(),
      'lon': lng.toString()
    };

    Uri uri = Uri.https(Constants.OPENWEATHER_BASE_URL,
        Constants.OPENWEATHER_FORECAST_PATH, queryParameters);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
