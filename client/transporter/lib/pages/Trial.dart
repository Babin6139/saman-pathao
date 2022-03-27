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
  int _activeStepIndex = 0;

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex == 0,
          title: Text("Vehicle Details"),
          content: Text("Hello"),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex == 1,
          title: Text("Licence Photo"),
          content: Text("Ji"),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey),
          child: Stepper(
            currentStep: _activeStepIndex,
            controlsBuilder: (context, details) {
              return Container(
                child: Row(children: [
                  TextButton(
                      onPressed: details.onStepCancel, child: Text("Back")),
                  TextButton(
                      onPressed: details.onStepContinue, child: Text("Next")),
                ]),
              );
            },
            onStepCancel: () {
              print("hello step cancel");
              if (_activeStepIndex == 0) {
                Navigator.pop(context);
              } else {
                setState(() {
                  _activeStepIndex -= 1;
                });
              }
            },
            onStepContinue: () {
              if (_activeStepIndex < (stepList().length - 1)) {
                setState(() {
                  _activeStepIndex += 1;
                });
              } else {
                print('Submited');
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _activeStepIndex = index;
              });
            },
            margin: EdgeInsets.all(5),
            steps: [...stepList()],
          ),
        ),
      )),
    );
  }
}
