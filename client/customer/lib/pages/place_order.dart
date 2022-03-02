import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int _items = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                child: Column(
                  children: [
                    Text("Shipment Details"),
                    Container(
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          _items = int.parse(value);
                        }),
                        decoration: InputDecoration(
                            border: MyDecoration.inputBorder,
                            hintText: "Shipment count"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
