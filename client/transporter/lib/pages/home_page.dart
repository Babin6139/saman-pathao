import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transporter/models/transporters.dart';
import 'package:transporter/providers/transporterDataProvider.dart';
import 'package:transporter/widgets/order_cards.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final int? _value = 1;
  bool bidSelected = true;
  bool newOrderSelected = false;
  @override
  Widget build(BuildContext context) {
    final transporterData =
        context.watch<TransporterDataProvider>().transporterData;
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
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                padding: EdgeInsets.all(10),
                height: 170,
                child: !transporterData.biddedOrders.isEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: transporterData.biddedOrders.length,
                        itemBuilder: (context, index) {
                          return OrderedCard(
                              order_1: transporterData.biddedOrders[index]);
                        },
                      )
                    : Center(
                        child: Text("There are no orders"),
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Text(
                    "Delivery Orders",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Currently No Delivery Orders",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 12),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
