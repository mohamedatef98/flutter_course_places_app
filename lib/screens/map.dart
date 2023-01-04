import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  CameraPosition get _initialCameraPosition =>  CameraPosition(
    target: LatLng(widget.initialLocation.lat, widget.initialLocation.long),
    zoom: 16
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}