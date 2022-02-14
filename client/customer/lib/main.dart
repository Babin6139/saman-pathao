import 'package:customer/pages/home_page.dart';
import 'package:customer/pages/login_page.dart';
import 'package:customer/pages/signup_page.dart';
import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.landingPage,
      routes: {
        MyRoutes.landingPage: (context) => HomePage(),
        MyRoutes.login: (context) => LoginPage(),
        MyRoutes.signup: (context) => SignUp(),
        MyRoutes.homepage: (context) => HomePage()
      },
    );
  }
}
