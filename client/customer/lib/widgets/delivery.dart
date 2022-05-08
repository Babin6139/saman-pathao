import 'dart:convert';

import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:http/http.dart' as http;
import '../utils/mycolor.dart';

class Delivery extends StatefulWidget {
  const Delivery({
    Key? key,
  }) : super(key: key);

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  var onDeliveryOrder;
  loadData() async {
    UserData userData = context.read<UserDataProvide>().userData;
    var url =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=onDelivery";
    var response = await http.get(Uri.parse(url));
    var data = await jsonDecode(response.body);
    if (data.length != 0) {
      onDeliveryOrder = data.map((e) => UserOrders.fromMap(e)).toList();
    } else {}
    print(onDeliveryOrder);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

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
                "On delivery",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: onDeliveryOrder == null
                    ? Center(
                        child: Text("Currently there is no orders delivering"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: onDeliveryOrder.length,
                        itemBuilder: (context, index) {
                          return OrderCard(userOrder: onDeliveryOrder[index]);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
