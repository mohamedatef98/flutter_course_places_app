import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_5/utils/get_user_location_preview.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Widget _renderPreviewImage() {
    if(_previewImageUrl == null) {
      return const Text(
        "No Location choosen.",
        textAlign: TextAlign.center,
      );
    }
    else {
      return Image.network(
        _previewImageUrl!,
        fit: BoxFit.cover,
      );
    }
  }

  void _fetchUserLocation() async {
    final previewUrl = await getUserLocationPreviewImageUrl();
    setState(() {
      _previewImageUrl = previewUrl;
      print(previewUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1
            )
          ),
          child: _renderPreviewImage(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _fetchUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location')
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map')
            ),
          ],
        )
      ],
    );
  }
}