import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../utils/mycolor.dart';

class Delivery extends StatelessWidget {
  final UserData userData;
  const Delivery({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userData = context.watch<UserDataProvide>().userData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        width: size.width - 30,
        height: size.height / 5,
        decoration: MyDecoration.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "On Delivery",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: userData.onDeliveryOrders.length == 0
                    ? Center(
                        child: Text("Currently there is no delivery"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userData.postBidOrders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                              userOrder: userData.onDeliveryOrders[index]);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
