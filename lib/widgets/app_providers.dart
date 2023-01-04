import 'package:flutter/material.dart';
import 'package:project_5/provided_models/great_places.dart';
import 'package:project_5/provided_models/places_storage.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlacesStorage>(create: (_) => PlacesStorage()),
        ChangeNotifierProxyProvider<PlacesStorage, GreatPlaces>(
          create: (context) => GreatPlaces(null),
          update: (context, placesStorage, _) => GreatPlaces(placesStorage),
        )
      ],
      child: child,
    );
  }
}