import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:transporter/providers/transporterDataProvider.dart';

class TransporterDetails extends StatefulWidget {
  const TransporterDetails({Key? key}) : super(key: key);

  @override
  State<TransporterDetails> createState() => _TransporterDetailsState();
}

class _TransporterDetailsState extends State<TransporterDetails> {
  String tempImage = "";
  bool photo = true;
  bool edit = false;
  String name = "Shreya Rasali";
  String contact = "041-66766";
  String address = "Hetauda";
  final _formkey = GlobalKey<FormState>();

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

    List<Widget> Edit = [
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
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
    ];

    List<Widget> NotEdit = [
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 5,
            ),
            Text(
              name,
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
              contact,
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
            Text(address, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Divider(
          color: Colors.black,
        ),
      ),
    ];

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
        body: SingleChildScrollView(
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
                          : FileImage(File(tempImage)) as ImageProvider<Object>,
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
                        if (edit) ...[...Edit] else ...[...NotEdit],
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
