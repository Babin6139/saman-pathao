import 'dart:io';

import 'package:customer/models/placeorder.dart';
import 'package:customer/models/sipment_dimension.dart';
import 'package:customer/models/time_frame.dart';
import 'package:customer/models/users.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int _maxBudget = 0;
  int _itemCount = 1;
  DateTime selectedDate = DateTime.now();
  DateTime pickupDate = DateTime.now();
  DateTime deliveryDate = DateTime.now();
  DateTime bidStartDate = DateTime.now();
  DateTime bidEndDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay pickupTime = TimeOfDay.now();
  TimeOfDay deliveryTime = TimeOfDay.now();
  TimeOfDay bidStartTime = TimeOfDay.now();
  TimeOfDay bidEndTime = TimeOfDay.now();
  List<double> length = [];
  List<double> width = [];
  List<double> height = [];
  List<String> name = [];
  List<String> count = [];

  bool fragile = false;
  int _radioValue = -1;
  PlaceOrderDetail placeOrderDetail = PlaceOrderDetail(
      startPoint: [], shipmentCount: [], destination: [], shipments: []);
  String tempImage = "";
  bool checkPhoto = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      tempImage = image.path;
      setState(() {
        checkPhoto = true;
      });
    }

    return SingleChildScrollView(
      child: Container(
          color: MyColor.backColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 50,
                  decoration: MyDecoration.cardDecoration,
                  child: Center(
                      child: Text(
                    "Place your order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: MyDecoration.cardDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Shipment Details"),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() {
                              if (value != null) {
                                placeOrderDetail.maxBudget = int.parse(value);
                              }
                            }),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.monetization_on),
                                border: MyDecoration.inputBorder,
                                hintText: "Max Budget"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.cases),
                                border: MyDecoration.inputBorder,
                                hintText: " Total Shipment Weight"),
                            onChanged: (value) {
                              placeOrderDetail.shipmentWeight =
                                  double.parse(value);
                            },
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
                            onChanged: (value) =>
                                placeOrderDetail.minRated = double.parse(value),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Fragile:"),
                            Container(
                              width: size.width / 3,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Radio(
                                        value: 1,
                                        activeColor: Colors.black,
                                        groupValue: _radioValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _radioValue =
                                                int.parse(value.toString());
                                            fragile = true;
                                            placeOrderDetail.fragile = true;
                                          });
                                        }),
                                  ),
                                  Text("yes")
                                ],
                              ),
                            ),
                            Container(
                              width: size.width / 3,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Radio(
                                        value: 2,
                                        activeColor: Colors.black,
                                        groupValue: _radioValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _radioValue =
                                                int.parse(value.toString());
                                            fragile = false;
                                            placeOrderDetail.fragile = false;
                                          });
                                        }),
                                  ),
                                  Text("no")
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: pickImage,
                          child: AnimatedContainer(
                            clipBehavior: Clip.antiAlias,
                            duration: Duration(seconds: 1),
                            decoration: BoxDecoration(
                                color: MyColor.color1,
                                borderRadius: checkPhoto
                                    ? BorderRadius.circular(100)
                                    : BorderRadius.circular(0)),
                            width: checkPhoto ? 60 : 200.0,
                            height: checkPhoto ? 60 : 30.0,
                            alignment: Alignment.center,
                            child: tempImage != ''
                                ? Image.file(File(tempImage))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Icon(
                                          CupertinoIcons.photo,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: 5),
                                        Text("Pick Shipment Photo")
                                      ]),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: MyColor.color1,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () async {
                            DateTime date =
                                await _startDate(context) ?? pickupDate;
                            setState(() {
                              pickupDate = date;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text =
                                      pickupDate.toString().substring(0, 10),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Pickup Date",
                                    prefixIcon:
                                        Icon(Icons.date_range_outlined)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time =
                                await _startTime(context, pickupTime) ??
                                    pickupTime;
                            setState(() {
                              pickupTime = time;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = pickupTime.format(context),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Pick Up Time",
                                    prefixIcon: Icon(CupertinoIcons.clock)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: MyColor.color1,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () async {
                            DateTime date =
                                await _finishDate(context, pickupDate) ??
                                    deliveryDate;
                            setState(() {
                              deliveryDate = date;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text =
                                      deliveryDate.toString().substring(0, 10),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Delivery Date",
                                    prefixIcon:
                                        Icon(Icons.date_range_outlined)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time =
                                await _startTime(context, deliveryTime) ??
                                    deliveryTime;
                            setState(() {
                              deliveryTime = time;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = deliveryTime.format(context),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Delivery Time",
                                    prefixIcon: Icon(CupertinoIcons.clock)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: MyColor.color1,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () async {
                            DateTime date =
                                await _startDate(context) ?? bidStartDate;
                            setState(() {
                              bidStartDate = date;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text =
                                      bidStartDate.toString().substring(0, 10),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Bid Start Date",
                                    prefixIcon:
                                        Icon(Icons.date_range_outlined)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time =
                                await _startTime(context, bidStartTime) ??
                                    bidStartTime;
                            setState(() {
                              bidStartTime = time;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = bidStartTime.format(context),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Bid Start Time",
                                    prefixIcon: Icon(CupertinoIcons.clock)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: MyColor.color1,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () async {
                            DateTime date =
                                await _finishDate(context, bidStartDate) ??
                                    bidEndDate;
                            setState(() {
                              bidEndDate = date;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text =
                                      bidEndDate.toString().substring(0, 10),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Bid End Date",
                                    prefixIcon:
                                        Icon(Icons.date_range_outlined)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time =
                                await _startTime(context, bidEndTime) ??
                                    bidEndTime;
                            setState(() {
                              bidEndTime = time;
                            });
                          },
                          child: AbsorbPointer(
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = bidEndTime.format(context),
                                decoration: InputDecoration(
                                    border: MyDecoration.inputBorder,
                                    labelText: "Bid End Time",
                                    prefixIcon: Icon(CupertinoIcons.clock)),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                for (var i = 1; i <= _itemCount; i++) shipment_detail(i),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _itemCount = _itemCount + 1;
                        });
                      },
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        size: 42,
                      ),
                    ),
                    if (_itemCount > 1)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _itemCount = _itemCount - 1;
                          });
                        },
                        child: Icon(
                          CupertinoIcons.minus_circle,
                          size: 42,
                        ),
                      ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    placeOrderDetail.biddingTime = TimeFrame(
                        start: bidStartDate.toString().substring(0, 10) +
                            " " +
                            bidStartTime
                                .format(context)
                                .toString()
                                .substring(0, 4),
                        end: bidEndDate.toString().substring(0, 10) +
                            " " +
                            bidEndTime
                                .format(context)
                                .toString()
                                .substring(0, 4));

                    placeOrderDetail.timeFrame = TimeFrame(
                        start: pickupDate.toString().substring(0, 10) +
                            " " +
                            pickupTime
                                .format(context)
                                .toString()
                                .substring(0, 4),
                        end: deliveryDate.toString().substring(0, 10) +
                            " " +
                            deliveryTime
                                .format(context)
                                .toString()
                                .substring(0, 4));
                    placeOrderDetail.shipmentDimension = ShipmentDimension(
                        length: length, width: width, height: height);
                    placeOrderDetail.shipments = name;
                    placeOrderDetail.shipmentPhoto = tempImage;
                    placeOrderDetail.shipmentCount = count;
                    Navigator.pushNamed(context, MyRoutes.mapPlaceOrderPage,
                        arguments: placeOrderDetail);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: MyColor.color1),
                    child: Text("Continue"),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      print(picked);
      return picked;
    }
  }

  _finishDate(BuildContext context, DateTime finish) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: finish,
        firstDate: finish,
        lastDate: DateTime(2100));
    if (picked != null) {
      print(picked);
      return picked;
    }
  }

  _startTime(BuildContext context, TimeOfDay time) async {
    final TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: time);
    if (timeOfDay != null) {
      return timeOfDay;
    }
  }

  getDate(String givenDate) {
    var date = DateTime.parse(givenDate).toLocal();
    String time =
        "${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}";
    return time;
  }

  Widget shipment_detail(itemCount) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: MyDecoration.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Shipment ${itemCount}"),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  if (name.length < itemCount) {
                    name.add(value);
                  } else {
                    name[itemCount - 1] = value;
                  }
                },
                decoration: InputDecoration(
                    border: MyDecoration.inputBorder,
                    hintText: "Shipment Name"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  if (count.length < itemCount) {
                    count.add(value);
                  } else {
                    count[itemCount - 1] = value;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: MyDecoration.inputBorder,
                    hintText: "Shipment Count"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: MyColor.color1,
            ),
            Text("Dimension"),
            SizedBox(height: 5),
            Container(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  if (length.length < itemCount) {
                    length.add(double.parse(value));
                  } else {
                    length[itemCount - 1] = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: MyDecoration.inputBorder,
                    hintText: "Length of shipment"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  if (width.length < itemCount) {
                    width.add(double.parse(value));
                  } else {
                    width[itemCount - 1] = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: MyDecoration.inputBorder,
                    hintText: "Width of shipment"),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  if (height.length < itemCount) {
                    height.add(double.parse(value));
                  } else {
                    height[itemCount - 1] = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: MyDecoration.inputBorder,
                    hintText: "Height of shipment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
