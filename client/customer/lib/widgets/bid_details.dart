import 'package:customer/models/bids.dart';
import 'package:customer/models/time_frame.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BidDetails extends StatelessWidget {
  final Bids bidDetail;
  final String orderStatus;
  final TimeFrame biddingTime;
  const BidDetails({
    Key? key,
    required this.bidDetail,
    required this.orderStatus,
    required this.biddingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getDate(String givenDate) {
      var date = DateTime.parse(givenDate).toLocal();
      String time =
          "${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}";
      return time;
    }

    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: Text("Bids",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.green),
                  Text(getDate(biddingTime.start))
                ],
              )),
              Container(
                  child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.red),
                  Text(getDate(biddingTime.end))
                ],
              )),
            ],
          )),
        ),
        for (int i = 0; i < bidDetail.transporter.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(18.0),
                      topLeft: Radius.circular(18.0))),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(bidDetail.transporter[i].userName),
                  Text("Rs. ${bidDetail.bidAmount[i].toString()}"),
                  orderStatus == "onbid"
                      ? SizedBox()
                      : Icon(
                          CupertinoIcons.check_mark_circled,
                          color: Colors.green,
                        )
                ],
              ),
            ),
          ),
        bidDetail.transporter.length == 0
            ? Text("Currently there are no bids")
            : Text("")
      ]),
    );
    ;
  }
}
