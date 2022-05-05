import 'dart:convert';
import 'dart:developer';

import 'package:customer/models/placeorder.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

class MapPlaceOrder extends StatefulWidget {
  const MapPlaceOrder({Key? key}) : super(key: key);

  @override
  State<MapPlaceOrder> createState() => _MapPlaceOrderState();
}

class _MapPlaceOrderState extends State<MapPlaceOrder> {
  late MapController mapController;
  @override
  void initState() {
    // TODO: implement initState
    mapController = MapController();

    super.initState();
  }

  var mapOption = [];
  var homePoint = [];
  var pickupPoint = [];
  var deliveryPoint = [];
  var placeName = '';
  @override
  Widget build(BuildContext context) {
    PlaceOrderDetail placeOrderDetail =
        ModalRoute.of(context)!.settings.arguments as PlaceOrderDetail;
    Size size = MediaQuery.of(context).size;
    return Material(
        child: SafeArea(
      child: Stack(
        children: [
          Container(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  zoom: 10,
                  minZoom: 10.0,
                  onTap: (tapPosition, point) {
                    if (mapOption.length < 1) {
                      setState(() {
                        mapOption.add(point.latitude);
                        mapOption.add(point.longitude);
                      });
                    } else {
                      setState(() {
                        mapOption[1] = point.longitude;
                        mapOption[0] = point.latitude;
                      });
                    }
                  },
                  center: homePoint.length == 0
                      ? LatLng(27.700001, 85.333336)
                      : LatLng(homePoint[0], homePoint[1])),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: [
                  if (homePoint.length > 0)
                    Marker(
                        point: LatLng(homePoint[0], homePoint[1]),
                        builder: (context) => new Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            )),
                  for (var i = 0; i < mapOption.length; i++)
                    Marker(
                        point: LatLng(mapOption[0], mapOption[1]),
                        builder: (context) => new Container(
                              child: Icon(
                                Icons.location_on,
                              ),
                            )),
                ])
              ],
            ),
          ),
          Positioned(
            top: 30,
            child: Container(
                width: size.width / 1.2,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(15),
                decoration: MyDecoration.cardDecoration,
                child: Center(
                    child: pickupPoint.length < 1
                        ? Text("Point out the pick up location")
                        : Text("Point out the delivery location"))),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: GestureDetector(
              onTap: getUserLocation,
              child: Container(
                width: 40,
                decoration: BoxDecoration(color: Colors.white),
                child: Icon(Icons.gps_fixed),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: () => pickupPoint.length < 1
                  ? Navigator.pop(context)
                  : setState(() {
                      pickupPoint = [];
                    }),
              child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.arrow_back_ios_new)),
            ),
          ),
          Positioned(
              top: 80,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: size.width - 30,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: size.width / 1.2 - 30,
                        child: TextFormField(
                          onChanged: (value) => setState(() {
                            placeName = value;
                          }),
                          decoration: InputDecoration(
                              border: MyDecoration.inputBorder,
                              hintText: "Type the place to point"),
                        )),
                    IconButton(
                        onPressed: () async {
                          var data = await getPlaceLatLang();
                          mapController.move(
                              LatLng(data["lat"], data['lng']), 10);
                          mapOption = [];
                          mapOption.add(data["lat"]);
                          mapOption.add(data["lng"]);
                          setState(() {});
                        },
                        icon: Icon(Icons.search))
                  ],
                ),
              )),
          Positioned(
              bottom: 20,
              child: pickupPoint.length < 1
                  ? ElevatedButton(
                      onPressed: () async {
                        var data = await getPlaceName(mapOption);
                        setState(() {
                          pickupPoint.add(data);
                          pickupPoint.add(mapOption[0]);
                          pickupPoint.add(mapOption[1]);
                          mapOption = [];
                          placeOrderDetail.startPoint = pickupPoint;
                        });
                      },
                      child: Text("Pick Destination"))
                  : ElevatedButton(
                      onPressed: () async {
                        var data = await getPlaceName(mapOption);
                        setState(() {
                          deliveryPoint.add(data);
                          deliveryPoint.add(mapOption[0]);
                          deliveryPoint.add(mapOption[1]);
                          placeOrderDetail.destination = deliveryPoint;
                          placeOrderDetail.distance = calculateDistance(
                              pickupPoint[1],
                              pickupPoint[2],
                              deliveryPoint[1],
                              deliveryPoint[2]);
                        });
                        print(deliveryPoint[0]);
                        Navigator.pushNamed(context, MyRoutes.confirmOrder,
                            arguments: placeOrderDetail);
                      },
                      child: Text("Pick and Proceed")))
        ],
      ),
    ));
  }

  Future getPlaceName(data) async {
    var response = await http.get(Uri.parse(
        "https://api.opencagedata.com/geocode/v1/json?q=${data[0]},${data[1]}&pretty=1&key=e602c675c5ee4e7a9a48d2e37a854322"));
    var nameData = await jsonDecode(response.body);
    print(nameData["results"][0]["formatted"]);
    return nameData["results"][0]["formatted"];
  }

  Future getPlaceLatLang() async {
    var response = await http.get(Uri.parse(
        "https://api.opencagedata.com/geocode/v1/json?q=${placeName}&key=e602c675c5ee4e7a9a48d2e37a854322&language=en&pretty=1"));
    var nameData = await jsonDecode(response.body);
    print(nameData["results"][0]["geometry"]['lat']);
    return nameData["results"][0]["geometry"];
  }

  getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (homePoint.length > 0) {
      homePoint = [];
    }
    setState(() {
      homePoint.add(_locationData.latitude);
      homePoint.add(_locationData.longitude);
      print(_locationData.latitude as double);
      mapController.move(
          LatLng(_locationData.latitude as double,
              _locationData.longitude as double),
          10.0);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
