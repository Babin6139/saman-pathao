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

class SuitableBidsPage extends StatefulWidget {
  const SuitableBidsPage({Key? key}) : super(key: key);

  @override
  State<SuitableBidsPage> createState() => _SuitableBidsPageState();
}

class _SuitableBidsPageState extends State<SuitableBidsPage> {
  StreamController<double> controller = StreamController();
  List<OnBidOrders> orders = [];
  getBids() async {
    LocationData currentLocation =
        context.read<LocationProvider>().locationData;
    // Stream stream = controller.stream;
    print(currentLocation);
    var url =
        "http://10.0.2.2:7000/order/history?orderStatus=onbid&userType=transporter&rating=5&lat=${currentLocation.latitude}&long=${currentLocation.longitude}";
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
                      child: OnBidOrderCard(order: orders[index]));
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
