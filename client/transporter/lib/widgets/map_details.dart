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
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      height: 250,
      child: Column(
        children: [
          Text(
            "Deliver",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.directions_car,
                  size: 12,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              FittedBox(
                child: Text(
                  "${startPoint[0]}",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Icon(
                Icons.arrow_forward_outlined,
                size: 15,
              ),
              SizedBox(
                width: 24,
              ),
              Container(
                child: Icon(
                  Icons.directions_car,
                  size: 12,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                  width: 90,
                  child: FittedBox(
                      child: Text(
                    "${endPoint[0]}",
                    style: TextStyle(fontSize: 12),
                  ))),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 150,
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
