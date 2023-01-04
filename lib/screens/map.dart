import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_5/models/location.dart';

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;
  const MapScreen({
    super.key,
    this.initialLocation = const Location(lat: 30.018, long: 31.406),
    this.isSelecting = false
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  CameraPosition get _initialCameraPosition =>  CameraPosition(
    target: LatLng(widget.initialLocation.lat, widget.initialLocation.long),
    zoom: 16
  );

  Set<Marker> get _markers {
    if (_pickedLocation == null) {
      return <Marker>{};
    }
    else {
      return {
        Marker(
          markerId: const MarkerId("m1"),
          position: _pickedLocation!
        )
      };
    }
  }

  List<Widget> get _appBarActions {
    if(widget.isSelecting == true) {
      if(_pickedLocation == null) {
        return [];
      }
      else {
        return [
          IconButton(
            onPressed: () => Navigator.of(context).pop(
              Location(lat: _pickedLocation!.latitude, long: _pickedLocation!.longitude)
            ),
            icon: const Icon(Icons.check)
          )
        ];
      }
    }
    else {
      return [];
    }
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: _appBarActions,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onTap: _selectLocation,
        markers: _markers,
      ),
    );
  }
}