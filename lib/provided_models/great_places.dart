import 'package:flutter/material.dart';
import 'package:project_5/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items => _items.toList();
}