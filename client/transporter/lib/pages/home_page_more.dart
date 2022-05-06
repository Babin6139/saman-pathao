import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:transporter/models/transporter_details.dart';
import 'package:transporter/providers/changePageProvider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';
import 'package:transporter/widgets/transporeter_profile_card.dart';

class HomepageMore extends StatefulWidget {
  const HomepageMore({Key? key}) : super(key: key);

  @override
  State<HomepageMore> createState() => _HomepageMoreState();
}

class _HomepageMoreState extends State<HomepageMore> {
  TransporterDetail? detail;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  logout() async {}
  loadData() async {
    String userName =
        context.read<TransporterDataProvider>().transporterData.userName;
    var response = await http.get(
        Uri.parse(
            "http://192.168.254.2:7000/users/transporter/details?userName=$userName"),
        headers: {'Content-Type': 'application/json'});
    var responseData = await jsonDecode(response.body);
    var transporteDetail = responseData["userDetails"];
    detail = TransporterDetail.fromMap(transporteDetail);
    context
        .read<TransporterDataProvider>()
        .setDetails(TransporterDetail.fromMap(transporteDetail));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return detail == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: size.height,
            child: Column(
              children: [
                //Profile top widget with user name below
                TransporterProfileCard(),
                //logout, edit verify
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/details");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10),
                              Text("Profile")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<ChangePageProvider>().resetIndex();
                            Navigator.pushNamed(context, "/verification");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.assignment_ind_outlined),
                              SizedBox(width: 10),
                              Text("Verify")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/vehicleDetails");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.directions_car_outlined),
                              SizedBox(width: 10),
                              Text("Vehicle Details")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/wallet_load");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.account_balance_wallet),
                              SizedBox(width: 10),
                              Text("Load Collateral")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/trial");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 10),
                              Text("About us")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            logout();
                            Navigator.pushNamed(context, "/");
                          },
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Logout")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
