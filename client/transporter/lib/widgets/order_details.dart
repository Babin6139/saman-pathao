import 'package:flutter/material.dart';
import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/widgets/coutdown_timer.dart';
import 'package:transporter/widgets/fragile.dart';

class OrderDetail extends StatefulWidget {
  final args;
  const OrderDetail({Key? key, this.args}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState(args);
}

class _OrderDetailState extends State<OrderDetail> {
  final BiddedOrders orderDetails;
  _OrderDetailState(this.orderDetails);
  @override
  Widget build(BuildContext context) {
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
                "Lowest Bid: Rs. ${orderDetails.bids.bidAmount.reduce((curr, next) => curr < next ? curr : next)}",
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
