import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/transporter_vehicle.dart';
import 'package:transporter/models/transporters.dart';
import 'package:transporter/models/transporter_details.dart';

class FormValueProvider with ChangeNotifier {
  late VehicleDetails details;
  //first page
  late String licenseNo;
  late String vehicleNo;
  late double weightCapacity;
  late double length;
  late double breadth;
  late double height;
  late GlobalKey<FormState> formkey;
  //second page
  String? licencePhoto;
  //Third page
  late String blueBookPhoto;

//Fourth page
  late String vehiclePhoto;

  void setDetailsFirstPage(String licenseNo, String vehicleNo,
      double weightCapacity, double length, double breadth, double height) {
    licenseNo = licenseNo;
    vehicleNo = vehicleNo;
    weightCapacity = weightCapacity;
    length = length;
    breadth = breadth;
    height = height;
    notifyListeners();
  }

  void setDetailsSecondPage(String licencePhoto) {
    licencePhoto = licencePhoto;
    notifyListeners();
  }

  void setDetailsThirdPage(String blueBookPhoto) {
    blueBookPhoto = blueBookPhoto;
    notifyListeners();
  }

  void setDetailsFourthPage(String vehiclePhoto) {
    vehiclePhoto = vehiclePhoto;
    notifyListeners();
  }

  void setDetails(VehicleDetails givenDetails) {
    details = givenDetails;
  }
}
