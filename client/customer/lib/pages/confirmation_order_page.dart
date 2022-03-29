import 'dart:io';

import 'package:customer/models/placeorder.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PlaceOrderDetail placeOrderDetail =
        ModalRoute.of(context)!.settings.arguments as PlaceOrderDetail;
    print(placeOrderDetail.photo);
    return Material(
        color: MyColor.backColor,
        child: SafeArea(
            child: Container(
                child: Column(
          children: [
            Container(
              height: 50,
              width: size.width,
              color: Colors.white,
              child: Center(
                  child: Text(
                "Confirm your order",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: Image.file(File(placeOrderDetail.photo.toString())),
            ),
            Expanded(
                child: Container(
              decoration: MyDecoration.cardDecoration,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  ListTile(
                    leading: Text("Shipments : "),
                    title: Text(placeOrderDetail.shipments.toString().substring(
                        1, placeOrderDetail.shipments.toString().length - 1)),
                  ),
                  ListTile(
                    leading: Text("Shipment Weight : "),
                    title: Text(
                        "${placeOrderDetail.shipmentWeight.toString()} kg"),
                  ),
                  ListTile(
                    leading: Text("Distance : "),
                    title: Text("${placeOrderDetail.distance.toString()} km"),
                  ),
                  ListTile(
                    leading: Text("Max Budget : "),
                    title:
                        Text(" Rs. ${placeOrderDetail.maxBudget.toString()}"),
                  ),
                  ListTile(
                    leading: Text("Min Rated Transporter : "),
                    title: Text("${placeOrderDetail.minRated.toString()} "),
                  ),
                  ListTile(
                    leading: Text("Pick Up Point : "),
                    title: Text(placeOrderDetail.startPoint![0]),
                  ),
                  ListTile(
                    leading: Text("Pick Up Date : "),
                    title: Text(placeOrderDetail.timeFrame!.start),
                  ),
                  ListTile(
                    leading: Text("Delivery Date : "),
                    title: Text(placeOrderDetail.timeFrame!.end),
                  ),
                  ListTile(
                    leading: Text("Delivery Point : "),
                    title: Text(placeOrderDetail.destination![0]),
                  ),
                  ListTile(
                    leading: Text("Shipment Dimesnsion:"),
                    title: Text(
                        "length:${placeOrderDetail.shipmentDimension!.length.toString()}, width:${placeOrderDetail.shipmentDimension!.width.toString()}, height:${placeOrderDetail.shipmentDimension!.height.toString()}"),
                  ),
                  ListTile(
                    leading: Text("Bid Start : "),
                    title: Text(
                        "${placeOrderDetail.biddingTime!.start.toString()}"),
                  ),
                  ListTile(
                    leading: Text("Bid End :"),
                    title:
                        Text("${placeOrderDetail.biddingTime!.end.toString()}"),
                  ),
                ],
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      color: Colors.lightGreen,
                      child: Text("Confirm Order"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      color: Colors.blueGrey,
                      padding: EdgeInsets.all(6.0),
                      child: Text("Go Back"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, MyRoutes.homepage),
                    child: Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(6.0),
                      child: Text("Home"),
                    ),
                  )
                ],
              ),
            )
          ],
        ))));
  }
}
