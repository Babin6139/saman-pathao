import 'dart:convert';

import 'package:customer/models/bids.dart';
import 'package:customer/models/time_frame.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orderDataProvide.dart';
import '../providers/userData.dart';
import 'package:http/http.dart' as http;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            GestureDetector(
              onTap: () async {
                String userName =
                    context.read<UserDataProvide>().userData.userName;
                String orderNo =
                    context.read<OrderDataProvide>().userOrder.orderNo;
                String orderId =
                    context.read<OrderDataProvide>().userOrder.orderId;

                var uri =
                    "http://10.0.2.2:7000/bid/specific?userName=${userName}&orderNo=${orderNo}&transporterUserName=${bidDetail.transporter[i].userName}";
                print(uri);
                var response = await http.get(Uri.parse(uri),
                    headers: {'Content-Type': 'application/json'});
                var data = await jsonDecode(response.body);
                var transporter = data["orders"][0]["bids"]["transporter"][0];
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildPopupDialog(
                        context,
                        transporter,
                        userName,
                        orderId,
                        bidDetail.bidAmount[i]));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
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
            ),
          bidDetail.transporter.length == 0
              ? Text("Currently there are no bids")
              : Text("")
        ]),
      ),
    );
    ;
  }

  Widget _buildPopupDialog(
      BuildContext context, transporter, userName, orderId, bidAmount) {
    print(transporter);
    print(orderId);
    return AlertDialog(
      title: const Text('Transporter Detail'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(transporter["photo"]),
          ),
          SizedBox(height: 10),
          Text("${transporter["firstName"]} ${transporter["lastName"]}"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.orangeAccent,
              ),
              Text(
                  "${transporter["rating"] == -1 ? "Unrated" : transporter["rating"]} (${transporter["ratedBy"]})"),
            ],
          ),
          SizedBox(height: 10),
          Text(transporter["email"])
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: orderStatus != "postbid"
                  ? null
                  : () async {
                      var uri = "http://10.0.2.2:7000/order/bidFinalized";
                      var data = jsonEncode({
                        'userName': userName,
                        'transporter': transporter["_id"],
                        'id': orderId,
                        'bidCost': bidDetail.bidAmount[0]
                      });
                      print(bidAmount);
                      print(data);
                      var response = await http.patch(Uri.parse(uri),
                          headers: {'Content-Type': 'application/json'},
                          body: data);
                      var responseData = await jsonDecode(response.body);
                      if (responseData["message"] == "bid finalized") {
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.homepage);
                      }
                    },
              child: const Text('Accept'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        )
      ],
    );
  }
}
