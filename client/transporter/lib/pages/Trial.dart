import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:io';

import 'package:transporter/models/onBidOrders.dart';
import 'package:transporter/providers/markerProvider.dart';
import 'package:transporter/providers/onBidOrdersProvider.dart';
import 'package:transporter/widgets/onBid_order_card.dart';

class Trial extends StatefulWidget {
  const Trial({
    Key? key,
  }) : super(key: key);

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  LocationData? currentLocationData;
  OnBidOrders? selectedOrder;
  Set<Marker> markers = new Set();
  bool orderTap = false;

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
    if (mounted) {
      setState(() {
        currentLocationData = currentLocation;
      });
    }
  }

  List<OnBidOrders> orders = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableLocation();
    getAllOnBidOrders();
    // setPolyLines();
  }

  getAllOnBidOrders() async {
    // Stream stream = controller.stream;
    var url =
        "http://10.0.2.2:7000/order/history?userType=transporter&orderStatus=onbid&rating=5";
    var response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    var responseBody = await jsonDecode(response.body);
    if (mounted) {
      setState(() {
        orders = List<OnBidOrders>.from(
            responseBody.map((x) => OnBidOrders.fromMap(x)));
      });
    }
    if (orders.isNotEmpty) {
      context.read<OnBidOrdersProvider>().changeData(orders);
      int count = -1;
      orders.forEach((OnBidOrders element) {
        count++;
        markers.add(
          Marker(
            onTap: () {
              Marker requiredMarker = markers.firstWhere((marker) =>
                  marker.markerId == MarkerId('${element.orderNo} source'));
              var requiredIndex =
                  requiredMarker.infoWindow.snippet!.substring(12);
              context
                  .read<OnBidOrdersProvider>()
                  .updateIndex(int.parse(requiredIndex));
              LatLng origin = LatLng(double.parse(element.startPoint[1]),
                  double.parse(element.startPoint[2]));
              LatLng destination = LatLng(double.parse(element.destination[1]),
                  double.parse(element.destination[2]));
              setPolyLines(origin, destination);
              setState(() {
                selectedOrder = element;
                orderTap = true;
                markers = {
                  requiredMarker,
                  Marker(
                    markerId: MarkerId('${element.orderNo} destination'),
                    position: LatLng(
                        double.parse(element.destination[1]),
                        double.parse(
                            element.destination[2])), //position of marker
                    infoWindow: InfoWindow(
                      //popup info
                      title: 'Delivery location ',
                      snippet: 'Deliver here $count',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen), //Icon for Marker
                  )
                };
              });
            },
            //add first marker
            markerId: MarkerId('${element.orderNo} source'),
            position: LatLng(double.parse(element.startPoint[1]),
                double.parse(element.startPoint[2])), //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: 'PickUp location ',
              snippet: 'Pickup here $count',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan), //Icon for Marker
          ),
        );
      });
      context.read<MarkerProvider>().updateMarkerData(markers);
    }
  }

  PolylinePoints polyPoints = PolylinePoints();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  setPolyLines(LatLng origin, LatLng destination) async {
    var body = jsonEncode({
      "locations": [
        {"lat": origin.latitude, "long": origin.longitude},
        {"lat": destination.latitude, "long": destination.longitude}
      ]
    });
    var response = await http.post(
        Uri.parse('http://10.0.2.2:7000/bid/trial?userName=hb'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    var responseBody = await jsonDecode(response.body) as List<dynamic>;
    if (responseBody.isNotEmpty) {
      responseBody.forEach((var element) {
        polylineCoordinates.add(LatLng(element[1], element[0]));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          geodesic: true,
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  Completer<GoogleMapController> _googleMapController = Completer();
  LatLng position = const LatLng(27.675396686559694, 85.39714593440296);
  bool onbidSelected = true;
  bool deliverySelected = false;
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

    Widget order() {
      return SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(children: [
              Text(
                "Order Detail",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bidOrder');
                      },
                      child: OnBidOrderCard(order: selectedOrder)))
            ])),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDBE4FF),
        body: (currentLocationData == null || circles == null)
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Row(
                      children: [
                        ChoiceChip(
                          selected: onbidSelected,
                          backgroundColor: Colors.white,
                          elevation: 1,
                          autofocus: true,
                          selectedColor: Colors.teal.shade100,
                          label: Text("All Orders"),
                          onSelected: (value) {
                            // if (!bidSelected) {
                            //   setState(() {
                            //     newOrderSelected = !newOrderSelected;
                            //     bidSelected = !bidSelected;
                            //   });
                            // }
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ChoiceChip(
                          backgroundColor: Colors.white,
                          selectedColor: Colors.teal.shade100,
                          selected: deliverySelected,
                          elevation: 1,
                          label: Text("My Delivery"),
                          onSelected: (value) {
                            // if (!newOrderSelected) {
                            //   setState(() {
                            //     bidSelected = !bidSelected;
                            //     newOrderSelected = !newOrderSelected;
                            //   });
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: GoogleMap(
                      onTap: (coordinates) {
                        setState(() {
                          orderTap = false;
                          var currentMarkers =
                              context.read<MarkerProvider>().markerData;
                          markers = currentMarkers;
                          _polylines.clear();
                          polylineCoordinates.clear();
                          //   position = coordinates;
                          //   markers.add(Marker(
                          //     //add second marker
                          //     markerId: MarkerId(position.toString()),
                          //     position: coordinates, //position of marker
                          //     infoWindow: InfoWindow(
                          //       //popup info
                          //       title: 'Delivery Location ',
                          //       snippet: 'Deliver here',
                          //     ),
                          //     icon: BitmapDescriptor
                          //         .defaultMarker, //Icon for Marker
                          //   ));
                        });
                      },
                      zoomControlsEnabled: true,
                      rotateGesturesEnabled: true,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (controller) =>
                          _googleMapController.complete(controller),
                      mapToolbarEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              currentLocationData!.latitude as double,
                              currentLocationData!.longitude as double),
                          zoom: 12),
                      circles: circles as Set<Circle>,
                      markers: markers,
                      polylines: _polylines.isNotEmpty ? _polylines : {},
                    ),
                  ),
                  if (orderTap && selectedOrder != null) order()
                ],
              ),
      ),
    );
  }
}
