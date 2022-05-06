import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/onDeliveryOrders.dart';

import 'package:transporter/models/transporters.dart';
import 'package:transporter/pages/home_page_more.dart';
import 'package:transporter/pages/khalti_integration.dart';
import 'package:transporter/pages/place_bids_page.dart';
import 'package:transporter/providers/biddedOrdersProvider.dart';
import 'package:transporter/providers/changePageProvider.dart';
import 'package:transporter/providers/deliveryOrdersProvider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';
import 'package:transporter/widgets/order_cards.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int page = 0;
  PageController _controller = PageController();
  void _scrollToIndex(int index) {
    _controller.animateToPage(index,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
  }

  bool bidSelected = true;
  bool newOrderSelected = false;
  @override
  Widget build(BuildContext context) {
    final transporterData =
        context.watch<TransporterDataProvider>().transporterData;
    final biddedOrders = context.watch<BiddedOrdersProvider>().biddedOrdersData;
    final deliveryOrders =
        context.watch<DeliveryOrdersProvider>().deliveryOrdersData;
    final imageUrl = transporterData.photo;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDBE4FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          automaticallyImplyLeading: false,
          title: Text(
            "Saman Pathao",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/details");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
              ),
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xFF7DBED3),
          index: page,
          items: [
            Icon(Icons.home),
            Icon(Icons.attach_money_outlined),
            Icon(Icons.message),
            Icon(Icons.menu)
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                setState(() {
                  _scrollToIndex(value);
                  page = value;
                });
                break;
              case 1:
                setState(() {
                  _scrollToIndex(value);
                  page = value;
                });
                break;
              case 2:
                setState(() {
                  _scrollToIndex(value);
                  page = value;
                });
                break;
              case 3:
                setState(() {
                  _scrollToIndex(value);
                  page = value;
                });
                break;
              default:
                break;
            }
          },
        ),
        body: PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: transporterData == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              ChoiceChip(
                                selected: bidSelected,
                                backgroundColor: Colors.white,
                                elevation: 1,
                                autofocus: true,
                                selectedColor: Colors.teal.shade100,
                                label: Text("Bids"),
                                onSelected: (value) {
                                  if (!bidSelected) {
                                    setState(() {
                                      newOrderSelected = !newOrderSelected;
                                      bidSelected = !bidSelected;
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ChoiceChip(
                                backgroundColor: Colors.white,
                                selectedColor: Colors.teal.shade100,
                                selected: newOrderSelected,
                                elevation: 1,
                                label: Text("New Bids"),
                                onSelected: (value) {
                                  if (!newOrderSelected) {
                                    setState(() {
                                      bidSelected = !bidSelected;
                                      newOrderSelected = !newOrderSelected;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          padding: EdgeInsets.all(10),
                          height: 170,
                          child: Column(
                            children: [
                              Text(
                                "Bidded Orders",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: (!biddedOrders.isEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: biddedOrders.length,
                                        itemBuilder: (context, index) {
                                          return OrderedCard(
                                              order_1: biddedOrders[index],
                                              index: index);
                                        },
                                      )
                                    : Center(
                                        child:
                                            Text("There are no bidded orders"),
                                      )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(children: [
                            Text(
                              "Delivery Orders",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: (!deliveryOrders.isEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: deliveryOrders.length,
                                      itemBuilder: (context, index) {
                                        return OrderedCard(
                                            order_1: deliveryOrders[index],
                                            index: index);
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        "Currently No Delivery Orders",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                    )),
                            )
                          ]),
                        )
                      ],
                    ),
            ),
            KhaltiPaymentApp(),
            Text("Message"),
            HomepageMore()
          ],
        ),
      ),
    );
  }
}
