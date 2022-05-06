import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:io';

class Trial extends StatefulWidget {
  const Trial({
    Key? key,
  }) : super(key: key);

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  LocationData? currentLocationData;
  final Set<Marker> markers = new Set();

  enableLocation() async {
    var location = new Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var currentLocation = await location.getLocation();
    setState(() {
      currentLocationData = currentLocation;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableLocation();
  }

  Completer<GoogleMapController> _googleMapController = Completer();
  LatLng position = const LatLng(27.675396686559694, 85.39714593440296);

  @override
  Widget build(BuildContext context) {
    Set<Circle>? circles;
    if (currentLocationData != null) {
      circles = Set.from([
        Circle(
          circleId: CircleId("Random_ID"),
          center: LatLng(currentLocationData?.latitude as double,
              currentLocationData?.longitude as double),
          fillColor: Colors.blue.shade100.withAlpha(100),
          strokeWidth: 2,
          radius: 2000,
        )
      ]);
    }
    markers.add(Marker(
      //add first marker
      markerId: MarkerId('122'),
      position:
          LatLng(27.675396686559694, 85.39714593440296), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'PickUp location ',
        snippet: 'Pickup here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return SafeArea(
      child: Scaffold(
        body: (currentLocationData == null || circles == null)
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: GoogleMap(
                  onTap: (coordinates) {
                    setState(() {
                      position = coordinates;
                      markers.add(Marker(
                        //add second marker
                        markerId: MarkerId(position.toString()),
                        position: coordinates, //position of marker
                        infoWindow: InfoWindow(
                          //popup info
                          title: 'Delivery Location ',
                          snippet: 'Deliver here',
                        ),
                        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                      ));
                    });
                  },
                  zoomControlsEnabled: false,
                  rotateGesturesEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) =>
                      _googleMapController.complete(controller),
                  mapToolbarEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocationData!.latitude as double,
                          currentLocationData!.longitude as double),
                      zoom: 12),
                  circles: circles as Set<Circle>,
                  markers: markers,
                ),
              ),
      ),
    );
  }
}
