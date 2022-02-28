import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class countDownTimer extends StatelessWidget {
  final endTime;
  const countDownTimer({Key? key, required this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var convertedTime = DateTime.parse(endTime);
    int end = convertedTime.millisecondsSinceEpoch;
    return Container(
      child: CountdownTimer(
        endTime: end,
        widgetBuilder: (_, CurrentRemainingTime? time) {
          if (time?.days != null) {
            return Text(
              "${time?.days} days, ${time?.hours}:${time?.min} remaining",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
            );
          } else if (time?.hours != null) {
            return Text(
              "${time?.hours}:${time?.min} remaining",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
            );
          } else if (time?.min != null) {
            return Text(
              "${time?.min}:${time?.sec} remaining",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
            );
          } else if (time?.sec != null) {
            return Text(
              "${time?.sec} sec remaining",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
            );
          }
          return Text(
            "Bidding Time Expired",
            style: TextStyle(color: Colors.red.shade700, fontSize: 10),
          );
        },
      ),
    );
  }
}
