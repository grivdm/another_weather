import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/utilities/forecast_util.dart';
import 'package:flutter/material.dart';

class CityView extends StatelessWidget {
  const CityView({super.key, required this.weatherSnapshot});
  final AsyncSnapshot<WeatherForecast> weatherSnapshot;

  @override
  Widget build(BuildContext context) {
    var forecastList = weatherSnapshot.data!.list;
    var city = weatherSnapshot.data?.city!.name;
    var country = weatherSnapshot.data?.city!.country;
    var formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$city, $country',
          style: const TextStyle(
              color: Colors.black87, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text('${ForecastUtil.getFormattedDate(formattedDate)}')
      ],
    );
  }
}
