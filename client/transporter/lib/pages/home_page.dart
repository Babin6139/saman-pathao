import 'package:flutter/material.dart';
import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/models/transporters.dart';
import 'package:transporter/pages/order_cards.dart';
import 'package:transporter/widgets/colored_tab_bar.dart';

class Homepage extends StatefulWidget {
  final args;
  const Homepage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState(args);
}

class _HomepageState extends State<Homepage> {
  final transporter;
  _HomepageState(this.transporter);
  final imageUrl =
      'https://images.unsplash.com/photo-1566275529824-cca6d008f3da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80';
  final orders = [
    {
      'orderNo': '1',
      'photo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfpEK6RTTafNTsDEuwIXw-gDI3YbswWfgndcHfbkVTkP8_rzJxsoUBd7FNFjQGhPAKJdo&usqp=CAU',
      'bids': [10, 20, 2000, 300],
      'biddingTime': {'startTime': '12:30', 'endTime': '1:30'},
      'maxBudget': '5000',
      'orderStatus': 'onbid',
      'timeFrame': {'startTime': '9:00', 'endTime': '4:30'},
      'startPoint': 'Gatthaghar',
      'destination': 'Gokarna',
      'weight': '',
      'distance': '20',
      'fragile': 'true',
    },
    {
      'orderNo': '12',
      'photo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfpEK6RTTafNTsDEuwIXw-gDI3YbswWfgndcHfbkVTkP8_rzJxsoUBd7FNFjQGhPAKJdo&usqp=CAU',
      'bids': [10, 20, 2000, 300],
      'biddingTime': {'startTime': '12:30', 'endTime': '1:30'},
      'maxBudget': '5000',
      'orderStatus': 'onbid',
      'timeFrame': {'startTime': '9:00', 'endTime': '4:30'},
      'startPoint': 'Gatthaghar',
      'destination': 'Gokarna',
      'weight': '',
      'distance': '20',
      'fragile': 'true',
    },
    {
      'orderNo': '123',
      'photo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfpEK6RTTafNTsDEuwIXw-gDI3YbswWfgndcHfbkVTkP8_rzJxsoUBd7FNFjQGhPAKJdo&usqp=CAU',
      'bids': [10, 20, 2000, 300],
      'biddingTime': {'startTime': '12:30', 'endTime': '1:30'},
      'maxBudget': '5000',
      'orderStatus': 'onbid',
      'timeFrame': {'startTime': '9:00', 'endTime': '4:30'},
      'startPoint': 'Gatthaghar',
      'destination': 'Gokarna',
      'weight': '',
      'distance': '20',
      'fragile': 'true',
    },
    {
      'orderNo': '1234',
      'photo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfpEK6RTTafNTsDEuwIXw-gDI3YbswWfgndcHfbkVTkP8_rzJxsoUBd7FNFjQGhPAKJdo&usqp=CAU',
      'bids': [10, 20, 2000, 300],
      'biddingTime': {'startTime': '12:30', 'endTime': '1:30'},
      'maxBudget': '5000',
      'orderStatus': 'onbid',
      'timeFrame': {'startTime': '9:00', 'endTime': '4:30'},
      'startPoint': 'Gatthaghar',
      'destination': 'Gokarna',
      'weight': '',
      'distance': '20',
      'fragile': 'true',
    },
    {
      'orderNo': '12345',
      'photo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfpEK6RTTafNTsDEuwIXw-gDI3YbswWfgndcHfbkVTkP8_rzJxsoUBd7FNFjQGhPAKJdo&usqp=CAU',
      'bids': [10, 20, 2000, 300],
      'biddingTime': {'startTime': '12:30', 'endTime': '1:30'},
      'maxBudget': '5000',
      'orderStatus': 'onbid',
      'timeFrame': {'startTime': '9:00', 'endTime': '4:30'},
      'startPoint': 'Gatthaghar',
      'destination': 'Gokarna',
      'weight': '',
      'distance': '20',
      'fragile': 'true',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Transporters transporterData = Transporters.fromMap(transporter);
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                          padding: EdgeInsets.all(8), child: Text("My Bids")),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                          padding: EdgeInsets.all(8), child: Text("New Bids")),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
