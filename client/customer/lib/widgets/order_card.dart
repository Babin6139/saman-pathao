import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/providers/orderDataProvide.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class OrderCard extends StatelessWidget {
  final UserOrders userOrder;
  const OrderCard({
    Key? key,
    required this.userOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvide>().userData;
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(18.0),
              topLeft: Radius.circular(18.0))),
      width: 200,
      child: Hero(
        tag: userOrder.orderNo,
        child: Card(
          elevation: 0,
          child: ListTile(
            onTap: () {
              context.read<OrderDataProvide>().changeData(userOrder);
              Navigator.pushNamed(context, MyRoutes.orderPage);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(userOrder.photo),
            ),
            title: Text("Order: ${userOrder.orderNo}"),
            subtitle: Column(
              children: [
                Text(
                  "${userOrder.shipments[0]}",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Max Budget: ${userOrder.maxBudget}",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Lowest bid : ${userOrder.lowestbids == -1 ? "No bid" : userOrder.lowestbids}",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
