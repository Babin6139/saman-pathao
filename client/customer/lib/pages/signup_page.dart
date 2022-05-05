import 'dart:io';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer/models/users.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Users user = Users();
  String tempImage = "";
  final _formkey = GlobalKey<FormState>();
  bool showLabel = false;

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
      setState(() {
        showLabel = true;
      });
      if (_formkey.currentState!.validate() && user.photo != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage
            .ref()
            .child(File(user.photo.toString()).path.split('/').last.toString());
        UploadTask upload = ref.putFile(File(user.photo.toString()));
        await upload.then((res) async {
          await res.ref.getDownloadURL().then((value) => user.photo = value);
          setState(() {});
        });
        print(user.photo);
        var data = jsonEncode(user.toMap());
        var url = "http://10.0.2.2:7000/users/client/signup";
        var response = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'}, body: data);
        if (await jsonDecode(response.body)["message"] == "SignUp sucessfull") {
          Navigator.pushReplacementNamed(context, MyRoutes.login);
        }
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.backColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [Colors.blueAccent, Colors.green, Colors.black38],
              // )),
              ),
          child: SafeArea(
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                width: size.width,
                top: 10.0,
                child: Column(
                  children: [
                    Text(
                      "Saman Pathao",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MyColor.color1),
                    ),
                    AnimatedTextKit(repeatForever: true, animatedTexts: [
                      TypewriterAnimatedText("WE DELIVER",
                          speed: Duration(milliseconds: 400))
                    ])
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 140, bottom: 40.0),
                  width: size.width - 100,
                  decoration: BoxDecoration(
                    color: MyColor.cardColor,
                    borderRadius: BorderRadius.circular(35),

                    boxShadow: MyColor.shadow1,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: MyColor.color1,
                    //     offset: Offset(5.0, 5.0),
                    //     blurRadius: 10.0,
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formkey,
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your first name";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                user.firstName = value;
                              });
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: MyDecoration.inputBorder,
                                hintText: "First name",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                user.middleName = value;
                              });
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: MyDecoration.inputBorder,
                                hintText: "Middle name",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your last name";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                user.lastName = value;
                              });
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: MyDecoration.inputBorder,
                                hintText: "Last name",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!EmailValidator.validate(value)) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                user.email = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.at),
                                border: MyDecoration.inputBorder,
                                hintText: "Email",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Contact no required";
                              } else if (value.length < 10) {
                                return "10 digits required";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                user.contactNo = value;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.phone),
                                border: MyDecoration.inputBorder,
                                hintText: "Contact no",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address required";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                user.address = value;
                              });
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.home),
                                border: MyDecoration.inputBorder,
                                hintText: "Address",
                                hintStyle: TextStyle(color: MyColor.color1)),
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
                                  color: MyColor.color1,
                                  borderRadius: checkPhoto
                                      ? BorderRadius.circular(100)
                                      : BorderRadius.circular(0)),
                              width: checkPhoto ? 60 : 200.0,
                              height: checkPhoto ? 60 : 30.0,
                              alignment: Alignment.center,
                              child: user.photo != null
                                  ? Image.file(File(tempImage))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Icon(
                                            CupertinoIcons.photo,
                                            color: Colors.black45,
                                          ),
                                          SizedBox(width: 5),
                                          Text("Pick Image")
                                        ]),
                            ),
                          ),
                          user.photo == null && showLabel
                              ? Text(
                                  "Image is required",
                                  style: TextStyle(color: MyColor.color1),
                                )
                              : Text(""),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password required";
                              } else if (value.length < 6) {
                                return "Password length > 6";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                user.password = value;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: MyDecoration.inputBorder,
                                hintText: "Password",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            color: MyColor.color1,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              onTap: signUp,
                              splashColor: Colors.purple,
                              child: Container(
                                width: 100,
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
                                        Navigator.pushNamed(
                                            context, MyRoutes.login);
                                      })
                              ]))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 60,
                  left: size.width / 2 - 40.0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: 80.0,
                    height: 80.0,
                    child: Image.asset(
                      "assets/images/login.png",
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0)),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
