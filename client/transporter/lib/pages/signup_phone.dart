import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:transporter/utils/route.dart';

class SignUpPhone extends StatelessWidget {
  const SignUpPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
            title: Text(
              "Saman Pathao",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Your Mobile Number"),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CountryCodePicker(
                  onChanged: print,
                  flagWidth: 15,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'NP',
                  favorite: ['+977', 'NP'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                Container(
                    width: size.width / 2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(40)),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signup);
                    },
                    child: Text("Next")))
          ],
        ),
      ),
    );
  }
}
