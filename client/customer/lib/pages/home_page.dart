import 'package:customer/widgets/my_navigationbar.dart';
import "package:flutter/material.dart";
import "package:curved_navigation_bar/curved_navigation_bar.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Saman Pathao"),
        ),
        bottomNavigationBar: MyNavigationBar(
          index: 0,
        ));
  }
}
