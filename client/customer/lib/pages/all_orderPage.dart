import 'dart:convert';

import 'package:customer/models/user_data.dart';
import 'package:customer/models/user_orders.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/widgets/order_card.dart';
import 'package:customer/widgets/order_detail.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllOrderPage extends StatefulWidget {
  const AllOrderPage({Key? key}) : super(key: key);

  @override
  State<AllOrderPage> createState() => _AllOrderPageState();
}

class _AllOrderPageState extends State<AllOrderPage> {
  var prebid, postbid, onbid;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    UserData userData = context.read<UserDataProvide>().userData;
    var url =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=prebid";
    var response = await http.get(Uri.parse(url));
    var data = await jsonDecode(response.body);
    print(data);
    if (data.length != 0) {
      prebid = data.map((e) => UserOrders.fromMap(e)).toList();
    } else {
      prebid = [];
    }
    print(prebid);
    setState(() {});
    var url1 =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=onbid";
    var response1 = await http.get(Uri.parse(url1));
    var data1 = await jsonDecode(response1.body);
    if (data1.length != 0) {
      onbid = data1.map((e) => UserOrders.fromMap(e)).toList();
    } else {
      onbid = [];
    }
    var url2 =
        "http://10.0.2.2:7000/order/history?userName=${userData.userName}&orderStatus=postbid";
    var response2 = await http.get(Uri.parse(url2));

    var data2 = await jsonDecode(response2.body);
    if (data2.length != 0) {
      postbid = data2.map((e) => UserOrders.fromMap(e)).toList();
    } else {
      postbid = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var title = ["Prebid", "Onbid", "Postbid"];

    var datas = [prebid ?? [], onbid ?? [], postbid ?? []];
    print(datas);
    return Container(
        color: MyColor.backColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Text(
                "All orders",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width - 30,
                  decoration: MyDecoration.cardDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          title[0],
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 80,
                          child: datas[0] == []
                              ? Center(
                                  child: Text("Currently there is no order"))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: datas[0].length,
                                  itemBuilder: (context, index) {
                                    return OrderCard(
                                        userOrder: datas[0][index]);
                                  }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          title[1],
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: datas[1] != []
                              ? Center(
                                  child: Text("Currently there is no order"))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: datas[1].length,
                                  itemBuilder: (context, index) {
                                    return OrderCard(
                                        userOrder: datas[1][index]);
                                  }),
                        ),
                        Text(
                          title[2],
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: datas[2] != []
                              ? Center(
                                  child: Text("Currently there is no order"))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: datas[2].length,
                                  itemBuilder: (context, index) {
                                    return OrderCard(
                                        userOrder: datas[2][index]);
                                  }),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
    return Text("Post bid");
  }
}
