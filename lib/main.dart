import 'package:flutter/material.dart';
import 'package:project_5/screens/add_place.dart';
import 'package:project_5/screens/places_list.dart';
import 'package:project_5/widgets/app_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return MaterialApp(
      title: 'Great Places',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber
        )
      ),
      home: const AppProviders(
        child: PlacesListScreen(),
      ),
      routes: {
        AddPlaceScreen.routeName:(context) => const AddPlaceScreen()
      },
    );
  }
}
