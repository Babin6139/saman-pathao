import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transporter/pages/verification_page1.dart';
import 'package:transporter/providers/changePageProvider.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          title: Text("Verification"),
        ),
        backgroundColor: Color(0xFFDBE4FF),
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.only(left: 120, right: 120),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: context.watch<ChangePageProvider>().page,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  label: "1"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  label: "2"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  label: "3"),
            ],
          ),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (value) =>
              context.read<ChangePageProvider>().changeData(value),
          controller: context.watch<ChangePageProvider>().controller,
          children: [
            SingleChildScrollView(child: VerificationPage1()),
            SingleChildScrollView(child: Text("Second Page")),
            SingleChildScrollView(child: Text("Third Page")),
          ],
        ),
      ),
    );
  }
}
