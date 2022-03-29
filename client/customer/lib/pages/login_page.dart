import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/models/users.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    login() async {
      if (_formkey.currentState!.validate()) {
        var data = jsonEncode({'email': email, 'password': password});
        var url = "http://10.0.2.2:7000/users/client";
        var response = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'}, body: data);
        var responseBody = await jsonDecode(response.body);
        if (responseBody["message"] == "Login sucessfull") {
          var data = responseBody["data"];
          context.read<UserDataProvide>().changeData(UserData.fromMap(data));
          Navigator.pushReplacementNamed(context, MyRoutes.homepage);
        } else {}
      }
    }

    Size size = MediaQuery.of(context).size;
    return Material(
      color: MyColor.backColor,
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [Colors.blueAccent, Colors.green, Colors.black38],
              // )
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
                  height: 300.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: MyColor.shadow1
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
                            "Log In",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: MyDecoration.inputBorder,
                                prefixIcon: Icon(Icons.person),
                                // label: Text("Email / Username",
                                //     style: TextStyle(color: MyColor.color1)),
                                hintText: "Email",
                                hintStyle: TextStyle(color: MyColor.color1)),
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
                              password = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                                border: MyDecoration.inputBorder,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {},
                                ),
                                // label: Text("Password",
                                //     style: TextStyle(color: MyColor.color1)),
                                hintText: "Password",
                                hintStyle: TextStyle(color: MyColor.color1)),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(100),
                            color: MyColor.color1,
                            child: InkWell(
                              onTap: () async {
                                login();
                              },
                              splashColor: Colors.purple,
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text("Log In"),
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
                                    text: "Sign Up",
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, MyRoutes.signup);
                                      })
                              ]))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 2 - 230,
                left: size.width / 2 - 40.0,
                child: CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: AssetImage("assets/images/login.png"),
                ),
              )
              // child: Container(
              //   clipBehavior: Clip.antiAlias,
              //   width: 80.0,
              //   height: 80.0,
              //   child: Image.asset(
              //     "assets/images/login.png",
              //     fit: BoxFit.cover,
              //   ),
              //   decoration:
              //       BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              // )),
            ]),
          ),
        ),
      ),
    );
  }
}
