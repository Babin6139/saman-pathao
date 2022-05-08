import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/widgets/delivery.dart';
import 'package:customer/widgets/detail_card.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/widgets/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/finalized_order.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvide>().userData;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: MyColor.backColor,
        child: Column(children: [
          DetailCard(
            userData: userData,
          ),
          Orders(),
          Delivery(),
          FinalizedOrder()
        ]),
      ),
    );
  }
}
