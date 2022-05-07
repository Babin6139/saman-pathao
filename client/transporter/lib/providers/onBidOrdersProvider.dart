import 'package:flutter/material.dart';
import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/models/onBidOrders.dart';

class OnBidOrdersProvider with ChangeNotifier {
  late List<OnBidOrders> _onBidOrders;
  late int index;

  List<OnBidOrders> get onBidOrdersData => _onBidOrders;

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void updateOrder(OnBidOrders order) {
    _onBidOrders[index] = order;
    notifyListeners();
  }

  void changeData(List<OnBidOrders> onBidOrdersData) {
    _onBidOrders = onBidOrdersData;
    notifyListeners();
  }
}
