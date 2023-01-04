import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:project_5/models/location.dart' as location_model;

const _googleApiKey = 'AIzaSyCXH537vUkFjncxVYhxZTcH87eahrsfgbg';

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
  final lat = location.lat.toStringAsFixed(5);
  final long = location.long.toStringAsFixed(5);

  return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=$_googleApiKey";
}

Future<String> getLocationAddress(location_model.Location location) async {
  final lat = location.lat.toStringAsFixed(5);
  final long = location.long.toStringAsFixed(5);

  final requestUri = Uri.https("maps.googleapis.com", "/maps/api/geocode/json", {
    "latlng": "$lat,$long",
    "key": _googleApiKey
  });
  final response = await get(requestUri);
  final responseJson = jsonDecode(response.body) as dynamic;
  return responseJson["results"][0]["formatted_address"] as String;
}

