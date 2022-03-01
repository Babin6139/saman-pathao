import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDetail extends StatelessWidget {
  final List<String> startPoint;
  final List<String> endPoint;
  const MapDetail({
    Key? key,
    required this.startPoint,
    required this.endPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(LatLng(double.parse(startPoint[1]), double.parse(startPoint[2])));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 120,
      child: Column(
        children: [
          Text("Deliver"),
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
                      point: LatLng(
                          double.parse(endPoint[1]), double.parse(endPoint[2])),
                      builder: (context) => new Container(
                            child: Icon(Icons.location_on, color: Colors.green),
                          ))
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
