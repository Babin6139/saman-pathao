import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';

class TransporterProfileCard extends StatefulWidget {
  const TransporterProfileCard({Key? key}) : super(key: key);

  @override
  State<TransporterProfileCard> createState() => _TransporterProfileCardState();
}

class _TransporterProfileCardState extends State<TransporterProfileCard> {
  @override
  Widget build(BuildContext context) {
    var details = context.read<TransporterDataProvider>().transporterDetails;
    var photo = context.read<TransporterDataProvider>().transporterData.photo;
    var currency =
        context.read<TransporterDataProvider>().transporterData.inAppCurrency;
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
            backgroundImage: NetworkImage(photo),
          ),
          title: Row(children: [
            Text(
                "${details.firstName} ${details.middleName} ${details.lastName}"),
            SizedBox(
              width: 5,
            ),
            if (details.verified) ...[
              Icon(
                Icons.verified,
                size: 20,
                color: Colors.blue,
              )
            ]
          ]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(details.userName),
              Text(
                  "Rating: ${details.rating < 0 ? "Not Rated" : details.rating} (${details.ratedBy > 0 ? details.ratedBy : ""})"),
              Text("Deposit: ${currency}")
            ],
          ),
        ),
      ),
    );
  }
}
