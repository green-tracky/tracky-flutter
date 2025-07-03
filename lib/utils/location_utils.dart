import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getCurrentLatLng() async {
  final permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) return null;

  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return LatLng(position.latitude, position.longitude);
}
