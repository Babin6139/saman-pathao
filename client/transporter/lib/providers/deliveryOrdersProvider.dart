import 'package:flutter/material.dart';
import 'package:transporter/models/onBidOrders.dart';

class DeliveryOrdersProvider with ChangeNotifier {
  late List<OnBidOrders> _onDeliveryOrders;
  late int index;

  List<OnBidOrders> get deliveryOrdersData => _onDeliveryOrders;

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void updateOrder(OnBidOrders order) {
    _onDeliveryOrders[index] = order;
    notifyListeners();
  }

  void changeData(List<OnBidOrders> deliveryOrdersData) {
    _onDeliveryOrders = deliveryOrdersData;
    notifyListeners();
  }
}
