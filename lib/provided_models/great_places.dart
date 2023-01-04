import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_5/models/place.dart';
import 'package:project_5/provided_models/places_storage.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _places = [];
  bool _isLoading = true;
  final PlacesStorage? _placesStorage;

  bool get isLoading => _isLoading;

  List<Place> get places => [..._places];

  GreatPlaces(this._placesStorage) {
    if (_placesStorage != null) {
      loadPlaces();
    }
  }

  Future<void> addPlace(String title, File image) async {
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image
    );
    _places.add(place);
    notifyListeners();
    assert(_placesStorage != null);
    await _placesStorage!.storePlace(place);
  }

  Future<void> loadPlaces() async {
    assert(_placesStorage != null);
    _places.clear();
    (await _placesStorage!.getPlaces()).forEach((place) => _places.add(place));
    _isLoading = false;
    notifyListeners();
  }
}
