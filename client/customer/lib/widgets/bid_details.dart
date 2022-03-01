import 'package:customer/models/bids.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BidDetails extends StatelessWidget {
  final Bids bidDetail;
  final String orderStatus;
  const BidDetails({
    Key? key,
    required this.bidDetail,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: Text("Bids"),
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
