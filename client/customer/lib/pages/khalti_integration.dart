import 'package:customer/pages/khalti_payment_page.dart';
import 'package:flutter/material.dart';

class KhaltiPaymentApp extends StatefulWidget {
  const KhaltiPaymentApp({Key? key}) : super(key: key);

  @override
  State<KhaltiPaymentApp> createState() => _KhaltiPaymentAppState();
}

class _KhaltiPaymentAppState extends State<KhaltiPaymentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xFF56328c),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF56328c),
          )),
      title: 'Khalti Payment',
      home: KhaltiPaymentPage(),
    );
  }
}
