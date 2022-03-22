import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String licenseNo = '';
  String vehicleNo = '';
  double? weightCapacity;
  double? length;
  double? breadth;
  double? height;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          title: Text("Verification"),
        ),
        backgroundColor: Color(0xFFDBE4FF),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,

        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.circle_outlined)),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
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
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
