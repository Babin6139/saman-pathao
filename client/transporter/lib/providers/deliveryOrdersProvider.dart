import 'package:flutter/material.dart';
import 'package:transporter/models/onDeliveryOrders.dart';

class DeliveryOrdersProvider with ChangeNotifier {
  late List<OnDeliveryOrders> _onDeliveryOrders;
  late int index;

  List<OnDeliveryOrders> get deliveryOrdersData => _onDeliveryOrders;

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void updateOrder(OnDeliveryOrders order) {
    _onDeliveryOrders[index] = order;
    notifyListeners();
  }

  void changeData(List<OnDeliveryOrders> deliveryOrdersData) {
    _onDeliveryOrders = deliveryOrdersData;
    notifyListeners();
  }
}
