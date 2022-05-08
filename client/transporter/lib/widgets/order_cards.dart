import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/providers/biddedOrdersProvider.dart';

class OrderedCard extends StatefulWidget {
  final order_1;
  final index;
  OrderedCard({Key? key, required this.order_1, required this.index})
      : super(key: key);

  @override
  State<OrderedCard> createState() => _OrderedCardState(order_1, index);
}

class _OrderedCardState extends State<OrderedCard> {
  final BiddedOrders order;
  final int index;
  _OrderedCardState(this.order, this.index);
  @override
  Widget build(BuildContext context) {
    final DateTime postedTime =
        DateTime.parse(order.biddingTime.start).toLocal();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        context.read<BiddedOrdersProvider>().updateIndex(index);
        Navigator.pushNamed(context, '/biddedOrder', arguments: index);
      },
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Card(
          elevation: 0,
          child: ListTile(
            title: Column(mainAxisSize: MainAxisSize.min, children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Order: ${order.orderNo}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Text(
                'Posted at: ${postedTime.hour}:${postedTime.minute}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
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
                  height: 120,
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
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade700),
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
                                  color: Colors.grey.shade700, fontSize: 12)),
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
                                  color: Colors.grey.shade700, fontSize: 12)),
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
                          Text("Distance: ${order.maxBudget}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 12)),
                        ],
                      ),
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
                            "Lowest Bid:${order.bids.bidAmount.isNotEmpty ? order.bids.bidAmount.reduce((curr, next) => curr < next ? curr : next) : "No bids yet"}",
                            style: TextStyle(fontSize: 12),
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
