import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/transporters.dart';
import 'package:transporter/models/transporter_details.dart';

class TransporterDataProvider with ChangeNotifier {
  late Transporters _transporterData;
  late TransporterDetail _transporterDetails;

  Transporters get transporterData => _transporterData;
  TransporterDetail get transporterDetails => _transporterDetails;

  void setDetails(TransporterDetail transporterDetails) {
    _transporterDetails = transporterDetails;
    notifyListeners();
  }

  void changeData(Transporters transporterData) {
    _transporterData = transporterData;
    notifyListeners();
  }
}
