import 'package:customer/providers/orderDataProvide.dart';
import 'package:flutter/material.dart';

import '../utils/mydecoration.dart';
import 'package:provider/provider.dart';

class TransporterPage extends StatelessWidget {
  const TransporterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var transporter = context.read<OrderDataProvide>().userOrder.transporter;
    var bidcost = context.read<OrderDataProvide>().userOrder.lowestbids;
    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Text("Transporter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Transporter ID: ${transporter}"),
          SizedBox(
            height: 10,
          ),
          Text("Amount : Rs. ${bidcost.toString()}"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
