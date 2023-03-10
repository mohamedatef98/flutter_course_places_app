import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_5/models/location.dart';
import 'package:project_5/provided_models/great_places.dart';
import 'package:project_5/widgets/image_input.dart';
import 'package:project_5/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _storedImage;
  Location? _selectedLocation;

  void _handleImagePick(File image) {
    setState(() {
      _storedImage = image;
    });
  }

  void _savePlace() {
    if(_titleController.text.isNotEmpty && _storedImage != null && _selectedLocation != null) {
      Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _storedImage!, _selectedLocation!);
      Navigator.of(context).pop();
    }
  }

  void _handleLocationSelected(Location selectedLocation) {
    setState(() {
      _selectedLocation = selectedLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title'
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(
                      image: _storedImage,
                      onImagePick: _handleImagePick
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(
                      onLocationSelected: _handleLocationSelected,
                    )
                  ],
                ),
              )
            )
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
            ),
          )
        ],
      ),
    );
  }
}