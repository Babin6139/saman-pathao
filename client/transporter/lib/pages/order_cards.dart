import 'package:flutter/material.dart';

import 'package:transporter/models/bidedOrders.dart';

class OrderedCard extends StatefulWidget {
  final order_1;
  OrderedCard({
    Key? key,
    required this.order_1,
  }) : super(key: key);

  @override
  State<OrderedCard> createState() => _OrderedCardState(order_1);
}

class _OrderedCardState extends State<OrderedCard> {
  final BiddedOrders order;
  _OrderedCardState(this.order);
  @override
  Widget build(BuildContext context) {
    final DateTime postedTime =
        DateTime.parse(order.biddingTime.start).toLocal();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/order?orderId=${order.orderNo}',
            arguments: order);
      },
      child: Container(
        width: 230,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Card(
          elevation: 0,
          child: ListTile(
            title: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Order: ${order.orderNo}",
              ),
              Text(
                'Posted at: ${postedTime.hour}:${postedTime.minute}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
              ),
              SizedBox(
                height: 5,
              )
            ]),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(order.shipmentPhoto.toString()),
            ),
            subtitle: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 90,
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
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Materials: ${order.shipments[0]}...",
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey.shade700),
                        ),
                      ]),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            child: Icon(Icons.emoji_transportation, size: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Weight: ${order.shipmentWeight}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 10)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            child: Icon(Icons.attach_money_outlined,
                                color: Colors.green, size: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Budget: ${order.maxBudget}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 10)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            child: Icon(Icons.location_on_outlined, size: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Distance: ${order.maxBudget}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 10)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            child: Icon(Icons.low_priority_rounded, size: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Lowest Bid:${order.bids.bidAmount.reduce((curr, next) => curr < next ? curr : next)}",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
