import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Position> determinePosition() async {
  // the method to show the permission and git the user location
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }

  Position position = await Geolocator.getCurrentPosition();

  // Reverse geocoding to get the address
  List<Placemark> placeMarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  Placemark placeMark = placeMarks[0]; // Take the first result

  String address = // to return the address with the listed
      '${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}';

  // Save the address in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('address', address);
  prefs.setDouble('latitude', position.latitude);
  prefs.setDouble('longitude', position.longitude);

  return position;
}
