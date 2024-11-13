import 'package:another_weather/models/weather_forecast.dart';
import 'package:flutter/material.dart';
import '../utilities/forecast_util.dart';

Widget ForecastCard(AsyncSnapshot<WeatherForecast> weatherSnapshot, int index) {
  DailyWeather forecastItem = weatherSnapshot.data!.list![index];
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(forecastItem.dt! * 1000);
  String fullDate = ForecastUtil.getFormattedDate(dateTime);
  String dayOfWeek = fullDate.split(',')[0];

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(children: <Widget>[
      Text(
        dayOfWeek,
        style: const TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ]),
  );
}
