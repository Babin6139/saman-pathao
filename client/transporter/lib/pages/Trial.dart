import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import './../widgets/coutdown_timer.dart';

class Trial extends StatefulWidget {
  const Trial({
    Key? key,
  }) : super(key: key);

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  String tempImage = '';
  String? fbImageLink;
  bool photo = false;
  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      tempImage = image.path;
      print(tempImage);
      setState(() {
        photo = true;
        // transporter.photo = image.path;
      });
    }

    Future uploadImage() async {
      if (photo) {
        FirebaseStorage storage = FirebaseStorage.instance;
        var image = storage.ref();
        var imageRef = image.child('/image/${tempImage.split("/").last}');
        UploadTask upload = imageRef.putFile(File(tempImage));
        var res = await upload;
        var url = await res.ref.getDownloadURL();
        setState(() {
          fbImageLink = url;
        });
      }
      print("Hello from outside upload $fbImageLink");
    }

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: Text("Upload Picture to firebase"),
          ),
          TextButton(onPressed: uploadImage, child: Text("Upload"))
        ],
      )),
    );
  }
}
