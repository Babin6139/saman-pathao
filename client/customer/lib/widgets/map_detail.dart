import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDetail extends StatelessWidget {
  const MapDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      height: 120,
      child: Column(
        children: [
          Text("Deliver"),
          Container(
            height: 100,
            child: FlutterMap(
              options: MapOptions(minZoom: 10.0),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
