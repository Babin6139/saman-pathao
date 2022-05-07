import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late LocationData _locationData;

  LocationData get locationData => _locationData;

  void updateLocationData(LocationData location) {
    _locationData = location;
    notifyListeners();
  }
}
