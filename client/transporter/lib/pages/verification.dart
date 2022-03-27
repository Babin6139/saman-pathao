import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:transporter/models/transporter_vehicle.dart';

import 'package:transporter/providers/transporterDataProvider.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  int _activeStepIndex = 0;
  VehicleDetails details = VehicleDetails(vehicleDimension: [0, 0, 0]);
  //licence
  String tempImage1 = '';
  bool photo1 = false;
  //bluebook
  String tempImage2 = '';
  bool photo2 = false;
  //vehicle
  String tempImage3 = '';
  bool photo3 = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var username =
        context.read<TransporterDataProvider>().transporterData.userName;
    Future pickImageFromGallery(index) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      switch (index) {
        case 1:
          tempImage1 = image.path;
          setState(() {
            photo1 = true;
          });
          break;
        case 2:
          tempImage2 = image.path;
          setState(() {
            photo2 = true;
          });
          break;
        case 3:
          tempImage3 = image.path;
          setState(() {
            photo3 = true;
          });
          break;
        default:
          break;
      }
    }

    Future pickImageFromCamera(index) async {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      switch (index) {
        case 1:
          tempImage1 = image.path;
          setState(() {
            photo1 = true;
          });
          break;
        case 2:
          tempImage2 = image.path;
          setState(() {
            photo2 = true;
          });
          break;
        case 3:
          tempImage3 = image.path;
          setState(() {
            photo3 = true;
          });
          break;
        default:
          break;
      }
    }

    uploadDetails() async {
      details.userName =
          context.read<TransporterDataProvider>().transporterData.userName;
      FirebaseStorage storageInstance = FirebaseStorage.instance;
      final imagePathInFirebase1 = storageInstance.ref().child(
          'transporters/images/$username/licence/${tempImage1.split('/').last}');
      final imagePathInFirebase2 = storageInstance.ref().child(
          'transporters/images/$username/bluebook/${tempImage1.split('/').last}');
      final imagePathInFirebase3 = storageInstance.ref().child(
          'transporters/images/$username/vehicle_photo/${tempImage1.split('/').last}');

      UploadTask uploadImage1 = imagePathInFirebase1.putFile(File(tempImage1));
      UploadTask uploadImage2 = imagePathInFirebase2.putFile(File(tempImage2));
      UploadTask uploadImage3 = imagePathInFirebase3.putFile(File(tempImage3));

      var getResponse1 = await uploadImage1;
      var getImageLink1 = await getResponse1.ref.getDownloadURL();
      var getResponse2 = await uploadImage2;
      var getImageLink2 = await getResponse2.ref.getDownloadURL();
      var getResponse3 = await uploadImage3;
      var getImageLink3 = await getResponse3.ref.getDownloadURL();
      setState(() {
        details.licencePhoto = getImageLink1;
        details.blueBookPhoto = getImageLink2;
        details.vehiclePhoto = getImageLink3;
      });
      var verificationDetails = jsonEncode(details.toMap());
      var url = "http://10.0.2.2:7000/users/transporter";
      var response = await http.patch(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: verificationDetails);
      if (await jsonDecode(response.body)["message"] == "User updated") {
        Navigator.pop(context);
        final snackBar = SnackBar(
          content: Text("Submitted for review"),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Could Not Complete'),
                content: Text(
                    'There was some error while submitting details. Please try again later.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK')),
                ],
              );
            });
      }
    }

    List<Step> stepList() => [
          Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex == 0,
            title: Text("Vehicle Details"),
            content: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Please Enter Details below"),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "* License Number cannot be empty";
                        }
                        return null;
                      }),
                      onChanged: (value) {
                        setState(() {
                          details.licenseNo = value;
                        });
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        prefixIcon: Icon(
                          Icons.assignment,
                        ),
                        hintText: "License Number",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "* Vehicle Number cannot be empty";
                        }
                        return null;
                      }),
                      onChanged: (value) {
                        setState(() {
                          details.vehicleNo = value;
                        });
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        prefixIcon: Icon(
                          Icons.directions_car,
                        ),
                        hintText: "Vehicle Number",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "* Weight capacity cannot be empty";
                        }
                        return null;
                      }),
                      onChanged: (value) {
                        setState(() {
                          details.vehicleCapacity = double.parse(value);
                        });
                      },
                      textAlign: TextAlign.left,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        prefixIcon: Icon(
                          Icons.monitor_weight_outlined,
                        ),
                        hintText: "Maximum Weight",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Vehicle Dimension"),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 5,
                      runSpacing: 15,
                      children: [
                        Container(
                          width: 120,
                          child: TextFormField(
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return "* Length cannot be empty";
                              }
                              return null;
                            }),
                            onChanged: (value) {
                              setState(() {
                                details.vehicleDimension[0] =
                                    double.parse(value);
                              });
                            },
                            textAlign: TextAlign.left,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              prefixIcon: Icon(Icons.arrow_forward_rounded),
                              hintText: "Length",
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: TextFormField(
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return "* Breadth cannot be empty";
                              }
                              return null;
                            }),
                            onChanged: (value) {
                              setState(() {
                                details.vehicleDimension[1] =
                                    double.parse(value);
                              });
                            },
                            textAlign: TextAlign.left,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              prefixIcon: Icon(
                                Icons.line_weight,
                              ),
                              hintText: "Breadth",
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: TextFormField(
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return "* Height cannot be empty";
                              }
                              return null;
                            }),
                            onChanged: (value) {
                              setState(() {
                                details.vehicleDimension[2] =
                                    double.parse(value);
                              });
                            },
                            textAlign: TextAlign.left,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              prefixIcon: Icon(Icons.height),
                              hintText: "Height",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )),
          ),
          Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex == 1,
            title: Text("Licence Photo"),
            content: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text("Select Your Licence"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromGallery(1);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromCamera(1);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (photo1) ...[
                      Container(
                        child: Image(image: FileImage(File(tempImage1))),
                      )
                    ],
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex == 2,
            title: Text("Bluebook Photo"),
            content: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text("Select Your Blue book Photo"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromGallery(2);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromCamera(2);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (photo2) ...[
                      Container(
                        child: Image(image: FileImage(File(tempImage2))),
                      )
                    ],
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            state:
                _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex == 3,
            title: Text("Vehicle Photo"),
            content: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text("Select Your Blue book Photo"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromGallery(3);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            pickImageFromCamera(3);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (photo3) ...[
                      Container(
                        child: Image(image: FileImage(File(tempImage3))),
                      )
                    ],
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
            title: Text("Verification"),
          ),
          backgroundColor: Color(0xFFDBE4FF),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Stepper(
                elevation: 1,
                currentStep: _activeStepIndex,
                controlsBuilder: (context, details) {
                  return Container(
                    child: Row(children: [
                      TextButton(
                          onPressed: details.onStepCancel, child: Text("Back")),
                      TextButton(
                          onPressed: details.onStepContinue,
                          child:
                              Text(_activeStepIndex == 3 ? "Submit" : "Next")),
                    ]),
                  );
                },
                onStepCancel: () {
                  if (_activeStepIndex == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _activeStepIndex -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  switch (_activeStepIndex) {
                    case 0:
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          _activeStepIndex += 1;
                        });
                      }
                      break;
                    case 1:
                      if (!photo1) {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Please Select a picture'),
                                content: Text('No Picture Selected'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else {
                        setState(() {
                          _activeStepIndex += 1;
                        });
                      }
                      break;
                    case 2:
                      if (!photo2) {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Please Select a picture'),
                                content: Text('No Picture Selected'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else {
                        setState(() {
                          _activeStepIndex += 1;
                        });
                      }
                      break;
                    case 3:
                      if (!photo3) {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Please Select a picture'),
                                content: Text('No Picture Selected'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else {
                        if (photo1 &&
                            photo2 &&
                            photo3 &&
                            formkey.currentState!.validate()) {
                          uploadDetails();
                        }
                      }
                      break;
                    default:
                      break;
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _activeStepIndex = index;
                  });
                },
                steps: [...stepList()],
              ),
            ),
          )),
    );
  }
}
