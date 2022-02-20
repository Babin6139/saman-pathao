import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:transporter/models/transporters.dart';
import 'package:transporter/utils/mycolors.dart';
import 'package:transporter/utils/route.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Transporters tranporter = Transporters();
  String tempImage = "";
  bool photo = false;
  @override
  Widget build(BuildContext context) {
    final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      tempImage = image.path;
      setState(() {
        photo = true;
      });
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xFF3E4346).withOpacity(1),
            ),
            backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
            title: Text(
              "Saman Pathao",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xFF90B5B7)),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Personal Information")),
              ),
              SizedBox(height: 10),
              Column(children: [
                Text("Add Your Photo"),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: photo
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(tempImage)),
                          maxRadius: 40,
                        )
                      : AnimatedContainer(
                          clipBehavior: Clip.antiAlias,
                          duration: Duration(seconds: 1),
                          width: size.width / 4,
                          height: size.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFF44ADC9)),
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width / 2 + 70,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Full Name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width / 2 + 70,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: "E-mail",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width / 2 + 70,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width / 2 + 70,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Address",
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: size.width / 2,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black,
                        //     offset: Offset(5.0, 5.0),
                        //     blurRadius: 10.0,
                        //   ),
                        // ],
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.circular(40)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.login);
                        },
                        child: Text(
                          "Sign Up",
                        )))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
