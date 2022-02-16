import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: MyColor.backColor,
      child: Container(
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
              child: Text(
                "Saman Pathao",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MyColor.color1),
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
                            label: Text("Email / Username",
                                style: TextStyle(color: MyColor.color1)),
                            hintText: "Enter your email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            label: Text("Password",
                                style: TextStyle(color: MyColor.color1)),
                            hintText: "Enter your password"),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColor.color1,
                        child: InkWell(
                          onTap: () async {
                            await Navigator.pushNamed(
                                context, MyRoutes.homepage);
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
            Positioned(
              top: size.height / 2 - 220,
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
    );
  }
}
