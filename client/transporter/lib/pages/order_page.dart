import 'package:flutter/material.dart';
import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/widgets/map_details.dart';
import 'package:transporter/widgets/order_details.dart';
import 'package:transporter/widgets/personal_details.dart';

class OrderPage extends StatefulWidget {
  final args;
  const OrderPage({Key? key, this.args}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState(args);
}

class _OrderPageState extends State<OrderPage> {
  final BiddedOrders orderData;
  _OrderPageState(this.orderData);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFDBE4FF),
      body: SafeArea(
        child: Hero(
          tag: 0,
          child: orderData == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leadingWidth: 0,
                      backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
                      pinned: true,
                      collapsedHeight: 60,
                      expandedHeight: 200,
                      automaticallyImplyLeading: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        background: Image.network(
                          orderData.shipmentPhoto,
                          fit: BoxFit.cover,
                        ),
                        stretchModes: [StretchMode.zoomBackground],
                        title: Container(
                          width: size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.all(3),
                                  child: Text(
                                    "Order No: ${orderData.orderNo}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          OrderDetail(
                            args: orderData,
                          ),
                          MapDetail(
                              startPoint: orderData.startPoint,
                              endPoint: orderData.destination),
                          PersonalDetail(),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
