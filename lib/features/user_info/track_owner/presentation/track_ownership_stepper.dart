import 'package:flutter/material.dart';

class TrackOwnershipStepper extends StatefulWidget {
  @override
  _TrackOwnershipStepperState createState() => _TrackOwnershipStepperState();
}

class _TrackOwnershipStepperState extends State<TrackOwnershipStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestione Tracciato'),
        ),
        body: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep >= 2) return;
            setState(() {
              _currentStep += 1;
            });
          },
          onStepCancel: () {
            if (_currentStep <= 0) return;
            setState(() {
              _currentStep -= 1;
            });
          },
          steps: [
            Step(
              title: const Text('Do you own a track?'),
              content: Text('Please confirm if you own a track.'),
            ),
            Step(
              title: const Text('Select your tracks'),
              content: Text('Please select the tracks you own.'),
            ),
            Step(
              title: const Text('Modify your tracks'),
              content: Text('Here is how you can modify your tracks.'),
            ),
          ],
        ),
      ),
    );
  }
}
