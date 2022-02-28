import 'package:customer/models/display_order.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
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
          Container(
              child: Row(
            children: [
              Icon(Icons.local_shipping_outlined),
              Text(" Packages : "),
              for (var string in data.shipments) Text("$string ")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(Icons.monetization_on_sharp),
              Text(" Max Budget : Rs. ${data.maxBudget}")
            ],
          )),
          Container(
              child: Row(
            children: [
              Icon(Icons.drive_eta),
              Text(" Distance : ${data.distance} km")
            ],
          )),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.green),
                  Text(getDate(data.biddingTime.start))
                ],
              )),
              Container(
                  child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.red),
                  Text(getDate(data.biddingTime.end))
                ],
              )),
            ],
          )),
        ]),
      ),
    );
  }
}
