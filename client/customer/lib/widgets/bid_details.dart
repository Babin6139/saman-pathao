import 'package:customer/models/bids.dart';
import 'package:customer/utils/mydecoration.dart';
import 'package:flutter/material.dart';

class BidDetails extends StatelessWidget {
  final Bids bidDetail;
  const BidDetails({
    Key? key,
    required this.bidDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: MyDecoration.cardDecoration,
      height: 120,
      child: ListView(children: []),
    );
    ;
  }
}
