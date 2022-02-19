import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:transporter/utils/route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Column(
            children: <Widget>[
              Positioned(
                width: size.width,
                top: 50.0,
                child: Center(
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: size.width / 2 + 60,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.person),
                            hintText: "E-mail or username",
                            hintStyle: TextStyle()),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            hintStyle: TextStyle()),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue.shade400)),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )),
              const SizedBox(height: 20),
              const Text("Or",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SignInButton(Buttons.Google, onPressed: () {}),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "Do not have an account?"),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, MyRoutes.signup);
                          }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
