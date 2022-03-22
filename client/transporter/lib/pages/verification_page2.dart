import 'package:flutter/material.dart';

class VerificationPage2 extends StatefulWidget {
  const VerificationPage2({Key? key}) : super(key: key);

  @override
  State<VerificationPage2> createState() => _VerificationPage2State();
}

class _VerificationPage2State extends State<VerificationPage2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
