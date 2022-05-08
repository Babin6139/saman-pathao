import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/demo.dart';
import 'package:transporter/models/onBidOrders.dart';
import 'package:transporter/providers/onBidOrdersProvider.dart';
import 'package:transporter/widgets/coutdown_timer.dart';

class OnBidOrderCard extends StatefulWidget {
  final order;
  const OnBidOrderCard({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  State<OnBidOrderCard> createState() => _OnBidOrderCardState(order);
}

class _OnBidOrderCardState extends State<OnBidOrderCard> {
  OnBidOrders order;
  _OnBidOrderCardState(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Column(
        children: [
          Card(
            elevation: 0,
            child: ListTile(
              title: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Order: ${order.orderNo}",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                )
              ]),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(order.shipmentPhoto.toString()),
              ),
              subtitle: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xFFDBE4FF),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListView(
                      children: [
                        Row(children: [
                          Container(
                            width: 20,
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 18,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              "Materials: ${order.shipments[0]}...",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.emoji_transportation, size: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Weight: ${order.shipmentWeight}",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 15)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.attach_money_outlined,
                                  color: Colors.green, size: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Budget: ${order.maxBudget}",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 15)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.location_on_outlined, size: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Distance: ${order.distance}",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 15)),
                          ],
                        ),
                        //lowest bid
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.low_priority_rounded, size: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Lowest Bid:${order.bids.bidAmount.isNotEmpty ? order.bids.bidAmount.reduce((curr, next) => curr < next ? curr : next) : 'No bids yet'}",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              child: Icon(Icons.star, size: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Min Rating: ${order.minRated}",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [countDownTimer(endTime: order.biddingTime.end)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
