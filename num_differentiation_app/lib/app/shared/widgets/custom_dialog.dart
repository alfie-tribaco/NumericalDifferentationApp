import 'package:flutter/material.dart';
import 'package:num_differentiation_app/app/constants/app_colors.dart';
import 'package:num_differentiation_app/app/util/util_screen.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  int currentStep = 1;
  List<String> steps = [
    'Step 1: Input Function',
    'Step 2: Perform Calculation',
    'Step 3: View Result',
  ];

  void nextStep() {
    setState(() {
      if (currentStep < steps.length) {
        currentStep++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  steps[currentStep - 1],
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: UtilScreen().getHeight(context) * 0.04),
            Text(
              'Step ${currentStep.toString()} content',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColors().appGreenThree,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: UtilScreen().getHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    // Perform an action when the button is pressed
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: UtilScreen().getWidth(context) * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().appGreenTwo),
                  onPressed: () {
                    // Perform an action when the button is pressed
                    nextStep();
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
