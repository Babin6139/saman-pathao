import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/widgets/map_detail.dart';
import 'package:customer/widgets/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/display_order.dart';
import '../providers/orderDataProvide.dart';
import '../providers/userData.dart';
import 'package:http/http.dart' as http;

class FinalizedPage extends StatefulWidget {
  const FinalizedPage({Key? key}) : super(key: key);

  @override
  State<FinalizedPage> createState() => _FinalizedPageState();
}

class _FinalizedPageState extends State<FinalizedPage> {
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
                              children: [],
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
                      ]))
                    ])),
        ));
  }

  jsonDecode(String body) {}
}
