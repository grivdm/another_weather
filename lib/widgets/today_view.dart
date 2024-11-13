import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/weather_forecast.dart';

class TodayView extends StatelessWidget {
  const TodayView(this.weatherSnapshot, {super.key});
  final AsyncSnapshot<WeatherForecast> weatherSnapshot;

  @override
  Widget build(BuildContext context) {
    final DailyWeather todayForecast = weatherSnapshot.data!.list![0];
    final String iconUrl = todayForecast.getIconUrl();
    final String temperature = todayForecast.temp!.day!.toStringAsFixed(0);
    final String description = todayForecast.weather![0].description!;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                filterQuality: FilterQuality.high,
                iconUrl,
                scale: 0.4,
                width: 100,
                height: 100,
              ),
            ),
            Column(
              children: [
                Text(
                  '$temperature °C',
                  style: const TextStyle(fontSize: 42, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(description.toUpperCase(),
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 8),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _todayInfoItem(Icons.thermostat_rounded,
                  todayForecast.pressure!.toInt(), 'mm Hg'),
              _todayInfoItem(FontAwesomeIcons.cloudRain,
                  todayForecast.humidity!.toInt(), "%"),
              _todayInfoItem(
                  FontAwesomeIcons.wind, todayForecast.speed!.toInt(), "m/s"),
            ],
          ),
        ),
      ],
    );
  }
}

Column _todayInfoItem(IconData iconData, int value, String units) {
  return Column(
    children: [
      Icon(
        iconData,
        color: Colors.black87,
        size: 26,
      ),
      const SizedBox(height: 8),
      Text(value.toString(),
          style: const TextStyle(color: Colors.black87, fontSize: 20)),
      Text(units, style: const TextStyle(color: Colors.black54, fontSize: 16))
    ],
  );
}
