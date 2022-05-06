import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transporter/models/onBidOrders.dart';

class OnBidOrdersPage extends StatefulWidget {
  const OnBidOrdersPage({Key? key}) : super(key: key);

  @override
  State<OnBidOrdersPage> createState() => _OnBidOrdersPageState();
}

class _OnBidOrdersPageState extends State<OnBidOrdersPage> {
  StreamController<double> controller = StreamController();
  List<OnBidOrders> orders = [];
  getBids() async {
    Stream stream = controller.stream;
    var url =
        "http://10.0.2.2:7000/order/history?userType=transporter&orderStatus=onbid&rating=5";
    var response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    var responseBody = await jsonDecode(response.body);
    setState(() {
      orders = List<OnBidOrders>.from(
          responseBody.map((x) => OnBidOrders.fromMap(x)));
    });
  }

  @override
  void initState() {
    super.initState();
    getBids();
  }

  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty
        ? Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(18))),
            padding: EdgeInsets.all(10),
            height: 200,
            child: (orders.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Text('${orders[index]}');
                    },
                  )
                : Center(
                    child: Text("There are no orders"),
                  )))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
