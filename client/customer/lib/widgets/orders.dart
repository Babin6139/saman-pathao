import 'dart:convert';

import 'package:customer/models/display_order.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  const Orders({
    Key? key,
  }) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var postbidOrders, onbidOrders;
  loadData() async {
    UserData userData = context.read<UserDataProvide>().userData;
    var url1 =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=onbid";
    var response1 = await http.get(Uri.parse(url1));
    var data1 = await jsonDecode(response1.body);
    if (data1.length != 0) {
      onbidOrders = data1.map((e) => UserOrders.fromMap(e)).toList();
    } else {}
    var url2 =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=postbid";
    var response2 = await http.get(Uri.parse(url2));

    var data2 = await jsonDecode(response2.body);
    if (data2.length != 0) {
      postbidOrders = data2.map((e) => UserOrders.fromMap(e)).toList();
    } else {}
    if (this.mounted) {
      setState(() {});
    }
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
    return Container(
      alignment: Alignment.centerLeft,
      width: size.width - 30,
      height: size.height / 5,
      decoration: MyDecoration.cardDecoration,
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
              child: postbidOrders == null && onbidOrders == null
                  ? Center(child: Text("Currently there is no order"))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: postbidOrders.length + onbidOrders.length,
                      itemBuilder: (context, index) {
                        if (postbidOrders.length > index) {
                          return OrderCard(userOrder: postbidOrders[index]);
                        } else {
                          var i = index - postbidOrders.length;
                          return OrderCard(userOrder: onbidOrders[i]);
                        }
                      }),
            )
          ],
        ),
      ),
    );
  }
}
