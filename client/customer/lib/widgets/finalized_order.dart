import 'dart:convert';

import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/widgets/finalized_ordercard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/userData.dart';
import '../utils/mydecoration.dart';
import 'order_card.dart';
import 'package:http/http.dart' as http;

class FinalizedOrder extends StatefulWidget {
  const FinalizedOrder({Key? key}) : super(key: key);

  @override
  State<FinalizedOrder> createState() => _FinalizedOrderState();
}

class _FinalizedOrderState extends State<FinalizedOrder> {
  var finalizeOrder;
  loadData() async {
    UserData userData = context.read<UserDataProvide>().userData;
    var url =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=finalized";
    var response = await http.get(Uri.parse(url));
    var data = await jsonDecode(response.body);
    if (data.length != 0) {
      finalizeOrder = data.map((e) => UserOrders.fromMap(e)).toList();
    } else {}
    print(data);
    print("Hello");
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
                "Finalized Order",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: finalizeOrder == null
                    ? Center(
                        child: Text("Currently there is no orders"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: finalizeOrder.length,
                        itemBuilder: (context, index) {
                          return OrderCard(userOrder: finalizeOrder[index]);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
