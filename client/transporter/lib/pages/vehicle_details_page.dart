import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:transporter/models/transporter_vehicle.dart';
import 'package:transporter/providers/transporterDataProvider.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({Key? key}) : super(key: key);

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  VehicleDetails? details;

  getVehicleData() async {
    String userName =
        context.read<TransporterDataProvider>().transporterData.userName;
    var url =
        'http://10.0.2.2:7000/users/transporter/details?userName=$userName';
    var response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    var responseData = await jsonDecode(response.body);
    var vehicleDetail = responseData["vehicleDetails"];
    if (vehicleDetail == null) {
      setState(() {
        details = null;
      });
    } else {
      setState(() {
        details = VehicleDetails.fromMap(vehicleDetail);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getVehicleData();
  }

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
          child: (details != null)
              ? Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.all(10),
                  child: Text("$details"),
                )
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "You do not have Vehicle details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal.shade300),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/verification');
                          },
                          child: Text("Enter Details"),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
