import 'package:location/location.dart';

Future<String> getUserLocationPreviewImageUrl() async {
  const googleApiKey = "AIzaSyCXH537vUkFjncxVYhxZTcH87eahrsfgbg";
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
  final lat = locationData.latitude!.toStringAsFixed(5);
  final long = locationData.longitude!.toStringAsFixed(5);

  return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=$googleApiKey";
}

