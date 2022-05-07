import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/onBidOrders.dart';
import 'package:transporter/providers/onBidOrdersProvider.dart';
import 'package:transporter/widgets/coutdown_timer.dart';
import 'package:transporter/widgets/fragile.dart';

class OnBidOrderDetails extends StatefulWidget {
  const OnBidOrderDetails({Key? key}) : super(key: key);

  @override
  State<OnBidOrderDetails> createState() => _OnBidOrderDetailsState();
}

class _OnBidOrderDetailsState extends State<OnBidOrderDetails> {
  @override
  Widget build(BuildContext context) {
    int index = context.read<OnBidOrdersProvider>().index;
    OnBidOrders orderDetails =
        context.read<OnBidOrdersProvider>().onBidOrdersData[index];
    var pickUpTime = DateTime.parse(orderDetails.timeFrame.start).toLocal();
    var deliveryTime = DateTime.parse(orderDetails.timeFrame.end).toLocal();
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              orderDetails.fragile ? Fragile() : SizedBox.shrink()
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.shopping_bag_outlined,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Materials: ${orderDetails.shipments}",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.emoji_transportation,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Weight: ${orderDetails.shipmentWeight} kg",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.attach_money_outlined,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Budget: Rs.${orderDetails.maxBudget}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.location_on_outlined,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Distance: ${orderDetails.distance} km",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.low_priority_rounded,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Lowest Bid: Rs. ${orderDetails.bids.bidAmount.isNotEmpty ? orderDetails.bids.bidAmount.reduce((curr, next) => curr < next ? curr : next) : 'No bids yet'}",
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.timer,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Pickup: ${pickUpTime.toString().substring(0, 16)}",
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.timer,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Deliver: ${deliveryTime.toString().substring(0, 16)}",
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [countDownTimer(endTime: orderDetails.biddingTime.end)],
          )
        ]));
  }
}
