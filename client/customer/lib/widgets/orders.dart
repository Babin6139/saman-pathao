import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final UserData userData;
  const Orders({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserData userData = ModalRoute.of(context)!.settings.arguments as UserData;
    return Container(
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
              "Your Orders",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userData.postBidOrders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(userOrder: userData.postBidOrders[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
