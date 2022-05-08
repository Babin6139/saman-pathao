import 'dart:convert';

import 'package:customer/models/argument.dart';
import 'package:customer/models/display_order.dart';
import 'package:customer/models/transporter_model.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/providers/orderDataProvide.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:customer/widgets/bid_details.dart';
import 'package:customer/widgets/map_detail.dart';
import 'package:customer/widgets/order_detail.dart';
import 'package:customer/widgets/transorter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DisplayOrder extends StatefulWidget {
  const DisplayOrder({Key? key}) : super(key: key);

  @override
  State<DisplayOrder> createState() => _DisplayOrderState();
}

class _DisplayOrderState extends State<DisplayOrder> {
  OrderModel? data;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String userName = context.read<UserDataProvide>().userData.userName;
    String orderNo = context.read<OrderDataProvide>().userOrder.orderNo;

    var response = await http.get(
        Uri.parse(
            "http://10.0.2.2:7000/order?userName=${userName}&orderNo=${orderNo}"),
        headers: {'Content-Type': 'application/json'});
    var responseData = await jsonDecode(response.body);
    print(responseData["orders"][0]);
    data = OrderModel.fromMap(responseData["orders"][0]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String photo = context.watch<OrderDataProvide>().userOrder.photo;
    return Scaffold(
        backgroundColor: MyColor.backColor,
        body: SafeArea(
          child: Hero(
              tag: 0,
              child: data == null
                  ? Center(child: CircularProgressIndicator())
                  : CustomScrollView(slivers: [
                      SliverAppBar(
                        leadingWidth: 0,
                        pinned: true,
                        collapsedHeight: 60,
                        expandedHeight: 200,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          collapseMode: CollapseMode.parallax,
                          background: Image.network(
                            photo,
                            fit: BoxFit.cover,
                          ),
                          stretchModes: [StretchMode.zoomBackground],
                          title: Container(
                            color: Color.fromARGB(195, 251, 251, 251),
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(photo),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Order: ${context.watch<OrderDataProvide>().userOrder.orderNo}",
                                  style: TextStyle(color: MyColor.color1),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15, right: 15),
                          child: Container(
                            padding: EdgeInsets.only(top: 5),
                            decoration: MyDecoration.cardDecoration,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupUpdateDialog(context));
                                  },
                                  child: Column(children: [
                                    Icon(
                                      CupertinoIcons.arrow_2_circlepath,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    Text("Update")
                                  ]),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(context));
                                  },
                                  child: Column(children: [
                                    Icon(
                                      CupertinoIcons.xmark,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    Text("Delete")
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        OrderDetail(
                          data: data!,
                        ),
                        MapDetail(
                          startPoint: data!.startPoint,
                          endPoint: data!.destination,
                          deliveryTime: data!.timeFrame,
                        ),
                        data!.orderStatus == "finalized" ||
                                data!.orderStatus == "onDelivery"
                            ? TransporterPage()
                            : BidDetails(
                                bidDetail: data!.bids,
                                orderStatus: data!.orderStatus,
                                biddingTime: data!.biddingTime,
                              ),
                      ]))
                    ])),
        ));
  }

  Widget _buildPopupDialog(BuildContext context) {
    String userName = context.read<UserDataProvide>().userData.userName;
    String orderNo = context.read<OrderDataProvide>().userOrder.orderNo;

    return AlertDialog(
      title: const Text('Confirmation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are you sure you want to delete the order"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () async {
            print(orderNo);
            var url = "http://10.0.2.2:7000/order/";
            var data = jsonEncode({'userName': userName, 'orderNo': orderNo});
            var response = await http.delete(Uri.parse(url),
                headers: {'Content-Type': 'application/json'}, body: data);
            var responseData = await jsonDecode(response.body);
            if (responseData["message"] == "order cancelled") {
              Navigator.pushReplacementNamed(context, MyRoutes.homepage);
            } else {
              const info = SnackBar(
                content: Text('Order or user not found'),
              );

              ScaffoldMessenger.of(context).showSnackBar(info);
            }
          },
          child: const Text('Delete'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildPopupUpdateDialog(BuildContext context) {
    String userName = context.read<UserDataProvide>().userData.userName;
    String orderNo = context.read<OrderDataProvide>().userOrder.orderNo;
    int _maxBudget = 0;
    double minRated = 0;
    return AlertDialog(
      title: const Text('Update'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                if (value != null) {
                  _maxBudget = int.parse(value);
                  setState(() {});
                }
              }),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: MyDecoration.inputBorder,
                  hintText: "Max Budget"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.star),
                  border: MyDecoration.inputBorder,
                  hintText: "Min Rated Transporter"),
              onChanged: (value) => minRated = double.parse(value),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () async {},
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
