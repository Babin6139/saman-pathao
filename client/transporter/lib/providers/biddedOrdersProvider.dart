import 'package:flutter/material.dart';
import 'package:transporter/models/bidedOrders.dart';

class BiddedOrdersProvider with ChangeNotifier {
  late List<BiddedOrders> _biddedOrders;
  late int index;

  List<BiddedOrders> get biddedOrdersData => _biddedOrders;

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void updateOrder(BiddedOrders order) {
    _biddedOrders[index] = order;
    notifyListeners();
  }

  void changeData(List<BiddedOrders> biddedOrdersData) {
    _biddedOrders = biddedOrdersData;
    notifyListeners();
  }
}
