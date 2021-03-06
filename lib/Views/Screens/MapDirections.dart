import 'dart:async';

import 'package:events_app/Controllers/LocationController.dart';
import 'package:flutter/material.dart';
import 'package:map_pin_picker/map_pin_picker.dart';

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapDirections extends StatefulWidget {

  MapDirections({
    @required this.latitude,
    @required this.longitude,
});

  final double latitude;
  final double longitude;


  @override
  _MapDirectionsState createState() => _MapDirectionsState();
}

class _MapDirectionsState extends State<MapDirections> {
  Set<Marker> markers = Set();
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    markers.add(
        Marker(
          position: LatLng(widget.latitude,widget.longitude),
          markerId: MarkerId('1') ,
        )
    );
    super.initState();
  }

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.latitude,widget.longitude),
      zoom: 10,
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                //Camera Started Moving
                // mapPickerController.mapMoving();
              },
              onCameraMove: (nCameraPosition) {
                cameraPosition = nCameraPosition;
              },
              onCameraIdle: () async {
                //Camera Stopped
                // mapPickerController.mapFinishedMoving();
              },
            ),
          ),
        ],
      ),
    );
  }
}