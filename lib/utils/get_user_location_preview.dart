import 'package:location/location.dart';
import 'package:project_5/models/location.dart' as location_model;

Future<location_model.Location> getUserLocation() async {
  Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    assert(serviceEnabled == true);
    if (!serviceEnabled) {
    }
  }

  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    assert(permissionGranted == PermissionStatus.granted);
  }

  final locationData = await location.getLocation();
  return location_model.Location(lat: locationData.latitude!, long: locationData.longitude!);
 
}

String getLocationPreviewUrl(location_model.Location location) {
  const googleApiKey = "AIzaSyCXH537vUkFjncxVYhxZTcH87eahrsfgbg";

  final lat = location.lat.toStringAsFixed(5);
  final long = location.long.toStringAsFixed(5);

  return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=$googleApiKey";
}

