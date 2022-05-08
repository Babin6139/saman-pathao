import 'dart:convert';

import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserData userdata = context.watch<UserDataProvide>().userData;
    return Material(
      color: MyColor.backColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 45,
              margin: EdgeInsets.all(15.0),
              decoration: MyDecoration.cardDecoration,
              child: Center(child: Text("Edit details")),
            ),
            Expanded(
              child: Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: MyDecoration.cardDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(userdata.photo),
                          ),
                        ),
                        Divider(
                          color: MyColor.color1,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ListView(
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Colors.black)),
                                  title: Text(userdata.email),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "UserName",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ListTile(
                                  onTap: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  title: Text(userdata.userName),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(context));
                                  },
                                  title: Text("Update Password"),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    String userName = context.read<UserDataProvide>().userData.userName;
    String oldPassword = "";
    String newPassword = "";

    return AlertDialog(
      title: const Text('Update Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            obscureText: true,
            onChanged: (value) => oldPassword = value,
            decoration: InputDecoration(
                border: MyDecoration.inputBorder, hintText: "Old Password"),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) => newPassword = value,
            decoration: InputDecoration(
                border: MyDecoration.inputBorder, hintText: "New Password"),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () async {
            var url = "http://10.0.2.2:7000/users/client";
            var data = jsonEncode({
              'userName': userName,
              'oldPassword': oldPassword,
              "newPassword": newPassword
            });
            var response = await http.patch(Uri.parse(url),
                headers: {'Content-Type': 'application/json'}, body: data);
            var responseData = await jsonDecode(response.body);
            print(responseData["message"]);
            if (responseData["message"] == "Password updated") {
              Navigator.pop(context);
              const info = SnackBar(
                content: Text('Password updated'),
              );

              ScaffoldMessenger.of(context).showSnackBar(info);
            } else {
              const info = SnackBar(
                content: Text('Password did not match'),
              );

              ScaffoldMessenger.of(context).showSnackBar(info);
            }
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
