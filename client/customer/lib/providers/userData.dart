import 'package:customer/models/user_data.dart';
import 'package:flutter/material.dart';

class UserDataProvide with ChangeNotifier {
  late UserData _userData;

  UserData get userData => _userData;

  void changeData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}
