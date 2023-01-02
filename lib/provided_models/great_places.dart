import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_5/models/place.dart';
import 'package:project_5/provided_models/places_storage.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];
  final PlacesStorage? _placesStorage;

  GreatPlaces(this._placesStorage);

  Future<void> addPlace(String title, File image) async {
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image
    );
    _items.add(place);
    notifyListeners();
    assert(_placesStorage != null);
    await _placesStorage!.storePlace(place);
  }

  Future<List<Place>> getPlaces() async {
    assert(_placesStorage != null);
    return await _placesStorage!.getPlaces();
  }
}
