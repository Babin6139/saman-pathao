import 'package:flutter/material.dart';
import 'package:transporter/pages/Trial.dart';

import 'package:transporter/pages/home_page.dart';
import 'package:transporter/pages/khalti_integration.dart';
import 'package:transporter/pages/login_page.dart';
import 'package:transporter/pages/order_page.dart';
import 'package:transporter/pages/signup_page.dart';
import 'package:transporter/pages/signup_phone.dart';
import 'package:transporter/pages/transporter_details.dart';
import 'package:transporter/pages/verification.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signupPhone':
        return MaterialPageRoute(builder: (_) => SignUpPhone());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp(args));
      case '/homepage':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/biddedOrder':
        return MaterialPageRoute(builder: (_) => OrderPage(args: args));
      case '/details':
        return MaterialPageRoute(builder: (_) => TransporterDetails());
      case '/verification':
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case '/trial':
        return MaterialPageRoute(builder: (_) => Trial());
      case '/wallet_load':
        return MaterialPageRoute(builder: (_) => KhaltiPaymentApp());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('No Such Route available')),
      );
    });
  }
}
