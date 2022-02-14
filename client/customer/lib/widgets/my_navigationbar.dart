import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final index;
  const MyNavigationBar({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      items: [
        Icon(Icons.home),
        Icon(Icons.person),
        Icon(Icons.message_rounded),
        Icon(Icons.local_shipping),
      ],
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.pushNamed(context, MyRoutes.homepage);
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          default:
        }
      },
    );
  }
}
