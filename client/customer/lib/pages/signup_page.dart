import 'dart:io';
import 'dart:convert';
import 'package:customer/models/users.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Users user = Users();
  String tempImage = "";
  bool checkPhoto = false;
  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      tempImage = image.path;
      setState(() {
        checkPhoto = true;
        user.photo = image.path;
      });
    }

    signUp() async {
      print(user.toMap());
      var data = jsonEncode(user.toMap());
      print(data);
    }

    Size size = MediaQuery.of(context).size;
    return Material(
      child: SingleChildScrollView(
        child: Stack(clipBehavior: Clip.none, children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 140, bottom: 40.0),
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.firstName = value;
                        });
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: Text("First name"),
                          hintText: "Enter your first name"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.middleName = value;
                        });
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: Text("Middle name"),
                          hintText: "Enter you middle name"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.lastName = value;
                        });
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: Text("Last name"),
                          hintText: "Enter your last name"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.email = value;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: Text("Email"), hintText: "Enter your email"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.contactNo = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          label: Text("Contact no"),
                          hintText: "Enter your contact no"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.address = value;
                        });
                      },
                      decoration: InputDecoration(
                          label: Text("Address"),
                          hintText: "Enter your address"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: pickImage,
                      child: AnimatedContainer(
                        clipBehavior: Clip.antiAlias,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: checkPhoto
                                ? BorderRadius.circular(100)
                                : BorderRadius.circular(0)),
                        width: checkPhoto ? 60 : 200.0,
                        height: checkPhoto ? 60 : 30.0,
                        alignment: Alignment.center,
                        child: user.photo != null
                            ? Image.file(File(tempImage))
                            : Text("Pick Image"),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          user.password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          hintText: "Enter your password"),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Material(
                      color: Colors.purpleAccent,
                      child: InkWell(
                        onTap: signUp,
                        splashColor: Colors.purple,
                        child: Container(
                          width: 50,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(text: "Not registered yet? "),
                          TextSpan(
                              text: "Log In",
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Hello");
                                })
                        ]))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: size.height / 2 - 210,
              left: size.width / 2 - 40.0,
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: 80.0,
                height: 80.0,
                child: Image.asset(
                  "assets/images/login.png",
                  fit: BoxFit.cover,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              )),
        ]),
      ),
    );
  }
}
