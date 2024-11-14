import 'package:geolocator/geolocator.dart';

class Location {
  late double ltd;
  late double lng;
  late LocationPermission permission;
  Future<void> getLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition();
      ltd = position.latitude;
      lng = position.longitude;
    } catch (e) {
      throw 'Get location error: $e';
    }
  }
}
