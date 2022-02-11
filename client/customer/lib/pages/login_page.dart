import 'package:customer/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Stack(clipBehavior: Clip.none, children: [
        Center(
          child: Container(
            height: 300.0,
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
                    "Log In",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Email"), hintText: "Enter your email"),
                  ),
                  TextFormField(
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
                      onTap: () {},
                      splashColor: Colors.purple,
                      child: Container(
                        width: 50,
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
                                Navigator.pushNamed(context, MyRoutes.signup);
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
    );
  }
}
