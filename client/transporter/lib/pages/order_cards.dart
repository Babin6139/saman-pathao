import 'package:flutter/material.dart';
import 'dart:math';

import 'package:transporter/models/biddedOrders.dart';

class OrderedCard extends StatefulWidget {
  final biddedOrders order_1;
  OrderedCard({
    Key? key,
    required this.order_1,
  }) : super(key: key);

  @override
  State<OrderedCard> createState() => _OrderedCardState(order_1);
}

class _OrderedCardState extends State<OrderedCard> {
  final biddedOrders order;
  _OrderedCardState(this.order);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: 290,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            spreadRadius: 1,
            offset: Offset(-4, -4),
            blurRadius: 15,
          )
        ],
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFFC8E0EA),
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Text("Order No: ${order.orderNo}"),
                    ),
                  ),
                  Text(
                    'Posted at: ${order.biddingTime.startTime}',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.grey)),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(order.photo),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color(0xFFDBE4FF)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.card_travel),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Materials"),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.emoji_transportation),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Weight: ${order.weight}"),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(
                                Icons.attach_money_outlined,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Budget: ${order.maxBudget}"),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.location_on_outlined),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Distance: ${order.maxBudget}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                      "Lowest Bid: ${order.bids.reduce((curr, next) => curr > next ? next : curr)}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
