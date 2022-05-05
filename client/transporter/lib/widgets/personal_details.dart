import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transporter/providers/transporterDataProvider.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({Key? key}) : super(key: key);

  @override
  _PersonalDetailState createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  @override
  Widget build(BuildContext context) {
    final userPhoto =
        context.read<TransporterDataProvider>().transporterData.photo;
    final userName =
        context.read<TransporterDataProvider>().transporterData.userName;
    // Users userDetails= Users.fromMap(unmappedUserDetails);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userPhoto),
          ),
          title: Text("Customer Details"),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Username: $userName")]),
        ),
      ),
    );
  }
}
