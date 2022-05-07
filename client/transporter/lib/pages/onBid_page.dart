import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:transporter/models/onBidOrders.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/locationProvider.dart';
import 'package:transporter/providers/onBidOrdersProvider.dart';
import 'package:transporter/widgets/onBid_order_card.dart';

class OnBidOrdersPage extends StatefulWidget {
  const OnBidOrdersPage({Key? key}) : super(key: key);

  @override
  State<OnBidOrdersPage> createState() => _OnBidOrdersPageState();
}

class _OnBidOrdersPageState extends State<OnBidOrdersPage> {
  StreamController<double> controller = StreamController();
  List<OnBidOrders> orders = [];
  getBids() async {
    LocationData currentLocation =
        context.read<LocationProvider>().locationData;
    // Stream stream = controller.stream;
    print(currentLocation);
    var url =
        "http://10.0.2.2:7000/order/history?userType=transporter&orderStatus=onbid&rating=5";
    var response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    var responseBody = await jsonDecode(response.body);
    setState(() {
      orders = List<OnBidOrders>.from(
          responseBody.map((x) => OnBidOrders.fromMap(x)));
      context.read<OnBidOrdersProvider>().changeData(orders);
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
        ? (orders.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        context.read<OnBidOrdersProvider>().updateIndex(index);
                        Navigator.pushNamed(context, '/bidOrder');
                      },
                      child:
                          OnBidOrderCard(order: orders[index], index: index));
                },
              )
            : Center(
                child: Text("There are no orders"),
              ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
