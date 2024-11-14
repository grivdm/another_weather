import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/widgets/forecast_card.dart';
import 'package:flutter/material.dart';

class WeekView extends StatelessWidget {
  const WeekView(this.weatherSnapshot, {super.key});
  final AsyncSnapshot<WeatherForecast> weatherSnapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '7-DAY WEATHER FORECAST',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 147,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black54,
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: 160,
                  child: ForecastCard(weatherSnapshot, index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: weatherSnapshot.data!.list!.length),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
