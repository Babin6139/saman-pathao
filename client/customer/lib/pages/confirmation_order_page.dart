import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:customer/models/placeorder.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserData userData = context.read<UserDataProvide>().userData;
    Size size = MediaQuery.of(context).size;
    PlaceOrderDetail placeOrderDetail =
        ModalRoute.of(context)!.settings.arguments as PlaceOrderDetail;
    print(placeOrderDetail.shipmentPhoto);

    placeOrder() async {
      placeOrderDetail.userName = userData.userName;
      placeOrderDetail.email = userData.email;
      var random = Random();
      placeOrderDetail.orderNo = random.nextInt(100).toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          File(placeOrderDetail.shipmentPhoto.toString())
              .path
              .split('/')
              .last
              .toString());
      UploadTask upload =
          ref.putFile(File(placeOrderDetail.shipmentPhoto.toString()));
      await upload.then((res) async {
        await res.ref
            .getDownloadURL()
            .then((value) => placeOrderDetail.shipmentPhoto = value);
      });
      print(await json.encode(placeOrderDetail.toMap()));
      var data = jsonEncode(placeOrderDetail.toMap());
      print(data);
      var url = "http://10.0.2.2:7000/order";
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: data);
      if (await jsonDecode(response.body)["message"] ==
          "Your Order has been created") {
        Navigator.pushReplacementNamed(context, MyRoutes.homepage);
      }
    }

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
              child:
                  Image.file(File(placeOrderDetail.shipmentPhoto.toString())),
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
                    title: Text(placeOrderDetail.startPoint[0]),
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
                    title: Text(placeOrderDetail.destination[0]),
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
                    onTap: placeOrder,
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
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Enter your password"),
              content: TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              actions: [TextButton(onPressed: () {}, child: Text("Confirm"))],
            ));
  }
}
