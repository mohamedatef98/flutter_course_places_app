import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_5/models/place.dart';
import 'package:project_5/provided_models/great_places.dart';
import 'package:project_5/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  createState() => PlacesListScreenState();
}

class PlacesListScreenState extends State<PlacesListScreen> {
  late List<Place> _places;
  late bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<GreatPlaces>(context).getPlaces().then((places) {
      setState(() {
        loading = false;
        _places = places;
      });
    });
  }

  Widget _renderPlaces() {
    if (loading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      if(_places.isNotEmpty) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final place = _places[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(place.image),
              ),
              title: Text(place.title),
            );
          },
          itemCount: _places.length,
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
      body: _renderPlaces()
    );
  }
}
