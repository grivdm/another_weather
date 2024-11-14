import 'package:another_weather/api/openweather_api.dart';
import 'package:another_weather/models/weather_forecast.dart';
import 'package:another_weather/screens/choose_city_screen.dart';
import 'package:another_weather/utilities/location.dart';
import 'package:another_weather/utilities/preference_manager.dart';
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
  Future<WeatherForecast>? _forecast;
  late String _cityName;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await PreferenceManager().init();
    _loadCityForecast();
  }

  void _loadCityForecast() {
    setState(() {
      _cityName = PreferenceManager().getCityName();
      _forecast = OpenweatherApi.fetchCityWeatherForecast(cityName: _cityName);
    });
  }

  void _loadLocationForecast() async {
    Location location = Location();
    await location.getLocation();

    Future<WeatherForecast> forecast =
        OpenweatherApi.fetchLocationWeatherForecast(
            lat: location.ltd, lng: location.lng);

    String cityNameFromLocation =
        await forecast.then((snapshot) => snapshot.city!.name ?? '');
    PreferenceManager().setCityName(cityNameFromLocation);
    setState(() {
      _forecast = forecast;
      _cityName = cityNameFromLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              _loadLocationForecast();
            },
            icon: const Icon(Icons.my_location_rounded)),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseCityScreen(),
                  ),
                );
                _loadCityForecast();
              },
              icon: const Icon(Icons.location_city_rounded))
        ],
      ),
      body: FutureBuilder<WeatherForecast>(
          future: _forecast,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    CityView(weatherSnapshot: snapshot),
                    const SizedBox(
                      height: 20,
                    ),
                    TodayView(snapshot),
                    WeekView(snapshot)
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 25),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
