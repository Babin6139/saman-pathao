import 'dart:convert';

import 'package:customer/models/time_frame.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapDetail extends StatelessWidget {
  final List<String> startPoint;
  final List<String> endPoint;
  final TimeFrame deliveryTime;
  const MapDetail({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    required this.deliveryTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(LatLng(double.parse(startPoint[1]), double.parse(startPoint[2])));
    getDate(String givenDate) {
      var date = DateTime.parse(givenDate).toLocal();
      String time =
          "${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}";
      return time;
    }

    // getData() async{
    //   var url = "https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248d1de629205604d079e594d9110a46430&start=${double.parse(startPoint[0]},${double.parse(endPoint[0]}end=${double.parse(startPoint[1]},${double.parse(endPoint[1]}";
    //       var response = await http.get(Uri.parse(url));
    //       var data=await jsonDecode(response.body);
    //       print(data);
    // }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: MyDecoration.cardDecoration,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Deliver",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    Icon(Icons.timer, color: Colors.green),
                    Text(getDate(deliveryTime.start))
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Icon(Icons.timer, color: Colors.red),
                    Text(getDate(deliveryTime.end))
                  ],
                )),
              ],
            )),
            Container(
              height: 100,
              child: FlutterMap(
                options: MapOptions(
                    zoom: 10,
                    minZoom: 10.0,
                    center: LatLng(double.parse(startPoint[1]),
                        double.parse(startPoint[2]))),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(markers: [
                    Marker(
                        point: LatLng(double.parse(startPoint[1]),
                            double.parse(startPoint[2])),
                        builder: (context) => new Container(
                              child: Icon(
                                Icons.location_on,
                              ),
                            )),
                    Marker(
                        point: LatLng(double.parse(endPoint[1]),
                            double.parse(endPoint[2])),
                        builder: (context) => new Container(
                              child:
                                  Icon(Icons.location_on, color: Colors.green),
                            ))
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
