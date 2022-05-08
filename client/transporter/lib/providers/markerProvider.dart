import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerProvider with ChangeNotifier {
  late Set<Marker> _markerData;

  Set<Marker> get markerData => _markerData;

  void updateMarkerData(Set<Marker> markerData) {
    _markerData = markerData;
    notifyListeners();
  }
}
