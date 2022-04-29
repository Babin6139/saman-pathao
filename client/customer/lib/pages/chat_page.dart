import 'package:customer/utils/routes.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(15),
      color: Colors.lightBlue,
      child: Column(children: [
        Container(
            width: size.width,
            child: Center(
                child: Text("Chat",
                    style: TextStyle(fontWeight: FontWeight.bold)))),
        Expanded(
          child: Container(
              child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.chat,
                      arguments: "Ram Thapa");
                },
                title: Text("Ram Thapa"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.chat,
                      arguments: "Shyam Singh");
                },
                title: Text("Shyam Singh"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.chat,
                      arguments: "Gyan Thapa");
                },
                title: Text("Gyan Thapa"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.chat,
                      arguments: "Hari Thapa");
                },
                title: Text("Hari Thapa"),
              )
            ],
          )),
        )
      ]),
    );
  }
}
