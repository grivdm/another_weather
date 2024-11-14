import 'package:another_weather/utilities/preferences_preferences.dart';
import 'package:flutter/material.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<ChooseCityScreen> createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  cityName = value;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.location_city_rounded),
                    hintText: 'Enter City',
                    hintStyle: TextStyle(color: Colors.black45)),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Get weather',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
