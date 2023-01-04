import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_5/models/location.dart';
import 'package:project_5/screens/map.dart';
import 'package:project_5/utils/get_user_location_preview.dart';

class LocationInput extends StatefulWidget {
  final void Function(Location) onLocationSelected;
  const LocationInput({
    super.key,
    required this.onLocationSelected
  });

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

  void setPreviewUrlForLocation(Location location) {
    final previewUrl = getLocationPreviewUrl(location);
    widget.onLocationSelected(location);
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  void _fetchUserLocation() async {
    final userLocation = await getUserLocation();
    setPreviewUrlForLocation(userLocation);
  }

  void _openMap() {
    Navigator.of(context).push<Location>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const MapScreen(isSelecting: true,),
    )).then((pickedLocation) {
      if(pickedLocation != null) {
        setPreviewUrlForLocation(pickedLocation);
      }
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
              onPressed: _openMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map')
            ),
          ],
        )
      ],
    );
  }
}