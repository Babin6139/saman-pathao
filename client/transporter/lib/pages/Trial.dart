import 'package:flutter/material.dart';

import './../widgets/coutdown_timer.dart';

class Trial extends StatefulWidget {
  final args;
  const Trial({Key? key, this.args}) : super(key: key);

  @override
  _TrialState createState() => _TrialState(args);
}

class _TrialState extends State<Trial> {
  final endTime;
  _TrialState(this.endTime);
  @override
  Widget build(BuildContext context) {
    var end = DateTime.parse(endTime);
    return SafeArea(
      child: Scaffold(
        body: countDownTimer(endTime: end),
      ),
    );
  }
}
