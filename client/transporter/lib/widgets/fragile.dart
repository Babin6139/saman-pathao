import 'package:flutter/material.dart';

class Fragile extends StatelessWidget {
  const Fragile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.amber,
          size: 12,
        ),
        SizedBox(width: 5),
        Text(
          "Fragile",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        )
      ]),
    );
  }
}
