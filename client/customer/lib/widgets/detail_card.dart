import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer/models/user_data.dart';
import 'package:customer/utils/mycolor.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final UserData userData;
  const DetailCard({
    Key? key,
    required this.userData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(8.0),
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          width: size.width - 30,
          height: size.height / 5,
          decoration: BoxDecoration(
              boxShadow: MyColor.shadow1,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 76,
                height: 76,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    color: Colors.amber),
                child: CircleAvatar(
                  backgroundColor: MyColor.color1,
                  backgroundImage: NetworkImage(
                    userData.photo,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                            ColorizeAnimatedText(userData.userName.toString(),
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                colors: [Colors.orange, Colors.yellow])
                          ]),
                          Text("Unrated"),
                          // Expanded(
                          //   child: ListView.builder(
                          //       itemCount: userData.rating == -1
                          //           ? 0
                          //           : userData.rating,
                          //       itemBuilder: (context, index) {
                          //         return Icon(Icons.star);
                          //       }),
                          // )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(userData.email.toString()),
                          Text("Rs: ${userData.inAppCurrency}")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
