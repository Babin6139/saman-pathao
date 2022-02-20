import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:transporter/utils/route.dart';

class SignUpPhone extends StatelessWidget {
  String? phoneNumber;
  final numberController = TextEditingController();
  var countryCode;
  void setPhoneNumber() {
    phoneNumber = '${countryCode.dialCode}-${numberController.text}';
  }

  void initialCode(code) {
    countryCode = CountryCode(dialCode: "+977");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF3E4346)),
            backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
            title: Text(
              "Saman Pathao",
              style: TextStyle(color: Colors.black),
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
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: CountryCodePicker(
                    onInit: initialCode,
                    onChanged: (code) => countryCode = code,
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
                ),
                Container(
                    width: size.width / 2,
                    child: TextFormField(
                      decoration:
                          InputDecoration(contentPadding: EdgeInsets.zero),
                      controller: numberController,
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
                  setPhoneNumber();
                  Navigator.pushNamed(context, MyRoutes.signup,
                      arguments: phoneNumber);
                },
                child: Text("Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
