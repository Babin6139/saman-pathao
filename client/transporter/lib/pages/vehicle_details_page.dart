import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({Key? key}) : super(key: key);

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDBE4FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          title: Text(
            "Vehicle Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.all(10),
            child: Text("This is vehicle details"),
          ),
        ),
      ),
    );
  }
}
