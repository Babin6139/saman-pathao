import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/widgets/delivery.dart';
import 'package:customer/widgets/detail_card.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/widgets/orders.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as UserData;
    Size size = MediaQuery.of(context).size;
    return Container(
      color: MyColor.backColor,
      child: Column(children: [
        DetailCard(
          userData: userData,
        ),
        Orders(
          userData: userData,
        ),
        Delivery(
          userData: userData,
        )
      ]),
    );
  }
}
