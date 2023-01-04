import 'package:flutter/material.dart';
import 'package:project_5/provided_models/great_places.dart';
import 'package:project_5/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  Widget _renderPlaces(BuildContext context, GreatPlaces greatPlaces, _) {
    if (greatPlaces.isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      final places = greatPlaces.places;
      if(places.isNotEmpty) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(place.image),
              ),
              title: Text(place.title),
              subtitle: Text(
                place.location.address,
                softWrap: false,
              ),
              onTap: () {},
            );
          },
          itemCount: places.length,
        );
      }
      else {
        return const Center(
          child: Text("No Places yet!"),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: _renderPlaces
      )
    );
  }
}
