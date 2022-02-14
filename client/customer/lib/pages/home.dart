import 'package:customer/utils/mycolor.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black12,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            width: size.width - 30,
            height: 100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(1, 1), blurRadius: 3.0, color: MyColor.color1)
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Welcome to Saman Pathao",
              style: TextStyle(fontSize: 18, color: MyColor.color1),
            ),
          ),
        )
      ]),
    );
  }
}
