import 'package:customer/models/display_order.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final OrderModel data;
  const OrderDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getDate(String date) {
      var date = DateTime.parse(data.biddingTime.start).toLocal();
      String time =
          "${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}";
      return time;
    }

    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text("Order Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Container(
              child: Row(
            children: [
              Icon(Icons.local_shipping_outlined, size: 15),
              Text(" Packages : "),
              for (var string in data.shipments) Text("$string ")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(Icons.monetization_on_sharp, size: 15),
              Text(" Max Budget : Rs. ${data.maxBudget}")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(Icons.drive_eta, size: 15),
              Text(" Distance : ${data.distance} km")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(
                CupertinoIcons.briefcase_fill,
                size: 15,
              ),
              Text(" Weight : ${data.shipmentWeight} kg")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(
                CupertinoIcons.map,
                size: 15,
              ),
              Text(" Route : ${data.startPoint[0]} -> ${data.destination[0]}")
            ],
          )),
        ]),
      ),
    );
  }
}
