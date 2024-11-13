import 'package:another_weather/api/openweather_api.dart';
import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/widgets/city_view.dart';
import 'package:another_weather/widgets/today_view.dart';
import 'package:another_weather/widgets/week_view.dart';
import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecast;
  String _cityName = 'Toronto';

  @override
  void initState() {
    super.initState();
    forecast = OpenweatherApi().fetchCityWeatherForecast(cityName: _cityName);

    forecast.then((weather) {
      print(weather);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.my_location_rounded)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.location_city_rounded))
        ],
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<WeatherForecast>(
              future: forecast,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      CityView(weatherSnapshot: snapshot),
                      const SizedBox(
                        height: 20,
                      ),
                      TodayView(snapshot),
                      WeekView(snapshot)
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
