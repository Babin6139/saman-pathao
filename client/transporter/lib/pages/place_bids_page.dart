import 'package:flutter/material.dart';

class PlaceBidsPage extends StatefulWidget {
  const PlaceBidsPage({Key? key}) : super(key: key);

  @override
  State<PlaceBidsPage> createState() => _PlaceBidsPageState();
}

class _PlaceBidsPageState extends State<PlaceBidsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Place Bids"),
    );
  }
}
