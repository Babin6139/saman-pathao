import 'package:customer/models/user_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDataProvide with ChangeNotifier {
  late UserOrders _userOrders;

  UserOrders get userOrder => _userOrders;

  void changeData(UserOrders userOrder) {
    _userOrders = userOrder;
    notifyListeners();
  }
}
