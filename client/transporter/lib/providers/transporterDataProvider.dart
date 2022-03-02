import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/transporters.dart';

class TransporterDataProvider with ChangeNotifier {
  late Transporters _transporterData;

  Transporters get transporterData => _transporterData;

  void changeData(Transporters transporterData) {
    _transporterData = transporterData;
    notifyListeners();
  }
}
