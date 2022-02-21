import 'package:customer/models/user_data.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:flutter/material.dart';

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
    UserData userData = ModalRoute.of(context)!.settings.arguments as UserData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        width: size.width - 30,
        height: size.height / 5,
        decoration: BoxDecoration(
            boxShadow: MyColor.shadow1,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
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
