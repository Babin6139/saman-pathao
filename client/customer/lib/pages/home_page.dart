import 'package:customer/models/user_data.dart';
import 'package:customer/pages/place_order.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/pages/home.dart';
import 'package:customer/widgets/my_navigationbar.dart';
import "package:flutter/material.dart";
import "package:curved_navigation_bar/curved_navigation_bar.dart";
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  PageController _controller = PageController();
  void _scrollToIndex(int index) {
    _controller.animateToPage(index,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvide>().userData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(userData.photo.toString()),
              ),
            ),
          )
        ],
        title: Text(
          "Saman Pathao",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: MyColor.color1,
        index: page,
        items: [
          Icon(Icons.home),
          Icon(Icons.person),
          Icon(Icons.message_rounded),
          Icon(Icons.local_shipping),
        ],
        onTap: (value) {
          switch (value) {
            case 0:
              setState(() {
                _scrollToIndex(value);
                page = value;
              });
              break;
            case 1:
              setState(() {
                _scrollToIndex(value);
                page = value;
              });
              break;
            case 2:
              setState(() {
                _scrollToIndex(value);
                page = value;
              });
              break;
            case 3:
              setState(() {
                _scrollToIndex(value);
                page = value;
              });
              break;
            default:
          }
        },
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            print(value);
            page = value;
          });
        },
        children: [
          Home(),
          Container(
            child: Text("Hello ${userData.userName}"),
          ),
          Container(
            child: Text("Hello"),
          ),
          PlaceOrder(),
        ],
      ),
    );
  }
}
