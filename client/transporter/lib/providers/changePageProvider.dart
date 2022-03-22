import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/transporters.dart';

class ChangePageProvider with ChangeNotifier {
  int page = 0;
  PageController controller = PageController();
  void resetIndex() {
    page = 0;
  }

  void changeData(int index) {
    page = index;
    controller.animateToPage(index,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
    notifyListeners();
  }
}
