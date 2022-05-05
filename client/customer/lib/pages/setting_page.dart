import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
                                    trailing: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.blue),
                                    )),
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
                                    trailing: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.blue),
                                    )),
                                Divider(
                                  color: Colors.black,
                                ),
                                ListTile(
                                  onTap: () {},
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
}
