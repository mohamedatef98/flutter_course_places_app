import 'package:flutter/material.dart';
import 'package:project_5/models/place.dart';
import 'package:project_5/screens/map.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';
  const PlaceDetailsScreen({super.key});

  void _openPlaceOnMap(BuildContext context, Place place) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MapScreen(
        isSelecting: false,
        initialLocation: place.location,
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: Text(
              place.location.address,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => _openPlaceOnMap(context, place),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary)
            ),
            child: const Text("View on Map")
          )
        ],
      ),
    );
  }
}