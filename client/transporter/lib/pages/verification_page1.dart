import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/changePageProvider.dart';

class VerificationPage1 extends StatefulWidget {
  const VerificationPage1({Key? key}) : super(key: key);

  @override
  State<VerificationPage1> createState() => _VerificationPage1State();
}

class _VerificationPage1State extends State<VerificationPage1> {
  String licenseNo = '';
  String vehicleNo = '';
  double? weightCapacity;
  double? length;
  double? breadth;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Please Enter Details below"),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return "* License Number cannot be empty";
                }
                return null;
              }),
              onChanged: (value) {
                setState(() {
                  licenseNo = value;
                });
              },
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                prefixIcon: Icon(
                  Icons.assignment,
                ),
                hintText: "License Number",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return "* Vehicle Number cannot be empty";
                }
                return null;
              }),
              onChanged: (value) {
                setState(() {
                  vehicleNo = value;
                });
              },
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                prefixIcon: Icon(
                  Icons.directions_car,
                ),
                hintText: "Vehicle Number",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return "* Weight capacity cannot be empty";
                }
                return null;
              }),
              onChanged: (value) {
                setState(() {
                  weightCapacity = double.parse(value);
                });
              },
              textAlign: TextAlign.left,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                prefixIcon: Icon(
                  Icons.monitor_weight_outlined,
                ),
                hintText: "Maximum Weight",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Vehicle Dimension"),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 5,
              runSpacing: 15,
              children: [
                Container(
                  width: 120,
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "* Length cannot be empty";
                      }
                      return null;
                    }),
                    onChanged: (value) {
                      setState(() {
                        length = double.parse(value);
                      });
                    },
                    textAlign: TextAlign.left,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.arrow_forward_rounded),
                      hintText: "Length",
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "* Breadth cannot be empty";
                      }
                      return null;
                    }),
                    onChanged: (value) {
                      setState(() {
                        breadth = double.parse(value);
                      });
                    },
                    textAlign: TextAlign.left,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(
                        Icons.line_weight,
                      ),
                      hintText: "Breadth",
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "* Height cannot be empty";
                      }
                      return null;
                    }),
                    onChanged: (value) {
                      setState(() {
                        height = double.parse(value);
                      });
                    },
                    textAlign: TextAlign.left,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.height),
                      hintText: "Height",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  var currentPage = context.read<ChangePageProvider>().page;
                  context.read<ChangePageProvider>().changeData(++currentPage);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
