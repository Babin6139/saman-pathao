import 'package:flutter/material.dart';
import 'package:transporter/pages/home_page.dart';
import 'package:transporter/pages/login_page.dart';
import 'package:transporter/pages/signup_page.dart';
import 'package:transporter/pages/signup_phone.dart';
import 'package:transporter/utils/route.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.landingPage,
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.landingPage: (context) => LoginPage(),
        MyRoutes.login: (context) => LoginPage(),
        MyRoutes.homepage: ((context) => Homepage()),
        MyRoutes.signupPhone: (context) => SignUpPhone(),
        MyRoutes.signup: (context) => SignUp(),
      },
    );
  }
}
