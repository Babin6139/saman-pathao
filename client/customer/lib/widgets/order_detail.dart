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
    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      height: 120,
      child: Row(children: []),
    );
  }
}
