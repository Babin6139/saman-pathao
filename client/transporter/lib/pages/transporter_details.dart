import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transporter/models/transporter_details.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:transporter/providers/transporterDataProvider.dart';

class TransporterDetails extends StatefulWidget {
  const TransporterDetails({Key? key}) : super(key: key);

  @override
  State<TransporterDetails> createState() => _TransporterDetailsState();
}

class _TransporterDetailsState extends State<TransporterDetails> {
  TransporterDetail? detail;
  String tempImage = "";

  bool photo = true;
  bool edit = false;
  String name = "";
  String contact = "";
  String address = "";
  final _formkey = GlobalKey<FormState>();

  loadData() async {
    String userName =
        context.read<TransporterDataProvider>().transporterData.userName;
    var response = await http.get(
        Uri.parse(
            "http://192.168.254.2:7000/users/transporter/details?userName=$userName"),
        headers: {'Content-Type': 'application/json'});
    var responseData = await jsonDecode(response.body);
    var transporteDetail = responseData["userDetails"];
    setState(() {
      detail = TransporterDetail.fromMap(transporteDetail);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final transporterData =
        context.watch<TransporterDataProvider>().transporterData;
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      tempImage = image.path;
      setState(() {
        photo = true;
        // transporter.photo = image.path;
      });
    }

    Widget Edit(BuildContext context) {
      return Column(
        children: [
          TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return "* Name cannot be empty";
              }
              return null;
            }),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            textAlign: TextAlign.left,
            initialValue: name,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(
                Icons.person_outline,
              ),
              hintText: "Name",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return "* Contact cannot be empty";
              }
              return null;
            }),
            onChanged: (value) {
              setState(() {
                contact = value;
              });
            },
            textAlign: TextAlign.left,
            initialValue: contact,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(
                Icons.phone,
              ),
              hintText: "Contact No.",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return "* Address cannot be empty";
              }
              return null;
            }),
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
            textAlign: TextAlign.left,
            initialValue: address,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(
                Icons.location_on,
              ),
              hintText: "Address",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: TextButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                setState(() {
                  edit = !edit;
                });
              }
              // Navigator.pushNamed(context, MyRoutes.homepage);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blue.shade400)),
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          )),
        ],
      );
    }

    Widget NotEdit(BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${detail!.firstName} ${detail!.middleName} ${detail!.lastName}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 5,
                ),
                Text(
                  detail!.contactNo.join(','),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 5,
                ),
                Text(detail!.address, style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      );
    }

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDBE4FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          title: Text(
            "Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: (detail == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: tempImage.isEmpty
                                ? NetworkImage(transporterData.photo)
                                : FileImage(File(tempImage))
                                    as ImageProvider<Object>,
                            maxRadius: 40,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(40)),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 80,
                        child: ChoiceChip(
                          autofocus: true,
                          backgroundColor: Colors.white,
                          elevation: 1,
                          selectedColor: Colors.teal.shade100,
                          label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Edit"),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                )
                              ]),
                          selected: edit,
                          onSelected: (selected) {
                            setState(() {
                              if (!edit) {
                                edit = !edit;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Form(
                        key: _formkey,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              if (edit) Edit(context) else NotEdit(context),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState() {
                                    edit = !edit;
                                  }
                                  // Navigator.pushNamed(context, MyRoutes.homepage);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.blue.shade400)),
                                child: Text(
                                  "Add Bio",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
