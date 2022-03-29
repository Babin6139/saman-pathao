import 'package:customer/models/user_data.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:customer/utils/routes.dart';
import 'package:customer/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvide>();
    return Container(
      color: MyColor.backColor,
      child: Column(
        children: [
          DetailCard(userData: userData.userData),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: MyDecoration.cardDecoration,
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.settingPage);
                      },
                      leading: Icon(Icons.settings),
                      title: Text("Setting"),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.people),
                      title: Text("About Us"),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.help),
                      title: Text("Help"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, MyRoutes.login);
                      },
                      leading: Icon(Icons.logout),
                      title: Text("Log Out"),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
