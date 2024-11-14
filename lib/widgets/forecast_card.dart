import 'package:another_weather/models/weather_forecast.dart';
import 'package:flutter/material.dart';
import '../utilities/forecast_util.dart';

Widget ForecastCard(AsyncSnapshot<WeatherForecast> weatherSnapshot, int index) {
  DailyWeather forecastItem = weatherSnapshot.data!.list![index];
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(forecastItem.dt! * 1000);
  String fullDate = ForecastUtil.getFormattedDate(dateTime);
  String dayOfWeek = fullDate.split(',')[0];
  final String iconUrl = forecastItem.getIconUrl();

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          dayOfWeek,
          style: const TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${forecastItem.temp!.eve!.toStringAsFixed(0)} °C",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            Image.network(
              iconUrl,
              width: 50,
              height: 50,
            )
          ],
        )
      ],
    ),
  );
}
