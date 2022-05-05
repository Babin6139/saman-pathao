import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/material.dart';

class IndvChat extends StatelessWidget {
  const IndvChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Material(
        child: SafeArea(
            child: Container(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Container(
          width: double.infinity,
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(border: MyDecoration.inputBorder),
          ),
        )
      ],
    ))));
  }
}
