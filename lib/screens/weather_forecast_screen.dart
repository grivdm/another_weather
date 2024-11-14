import 'package:another_weather/api/openweather_api.dart';
import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/screens/choose_city_screen.dart';
import 'package:another_weather/utilities/preferences_preferences.dart';
import 'package:another_weather/widgets/city_view.dart';
import 'package:another_weather/widgets/today_view.dart';
import 'package:another_weather/widgets/week_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecast;
  String _cityName = 'New York';

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await PreferencesManager().init();
    String _cityName = PreferencesManager().getCityName();

    setState(() {
      forecast = OpenweatherApi.fetchCityWeatherForecast(cityName: _cityName);
    });
  }

  void _loadCityName() {
    setState(() {
      _cityName = PreferencesManager().getCityName();
      forecast = OpenweatherApi.fetchCityWeatherForecast(cityName: _cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              PreferencesManager()
                  .setCityName(PreferencesManager().getCityName());
              _loadCityName();
            },
            icon: const Icon(Icons.my_location_rounded)),
        actions: [
          IconButton(
              onPressed: () async {
                String filledName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseCityScreen(),
                  ),
                );
                PreferencesManager().setCityName(filledName);
                _loadCityName();
              },
              icon: const Icon(Icons.location_city_rounded))
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
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
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
