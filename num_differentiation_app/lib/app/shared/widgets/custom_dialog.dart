import 'package:flutter/material.dart';
import 'package:num_differentiation_app/app/constants/app_colors.dart';
import 'package:num_differentiation_app/app/constants/app_strings.dart';
import 'package:num_differentiation_app/app/util/util_screen.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  int currentStep = 1;
  List<String> steps = [
    'Step 1: Input Function',
    'Step 2: Perform Calculation',
    'Step 3: View Result',
  ];

  List<String> description = [
    "To get started, input a valid function that includes the variable 'x'. Ensure that if you want to multiply a constant and 'x', you explicitly specify the multiplication using the asterisk symbol ",
    "Enter the specific value of 'x' at which you want to calculate the differences. Make sure the value you provide is compatible with the function you entered in Step 1. For example, if your function involves a square root, the value of 'x' should be non-negative.",
    "Choose an appropriate step size, which represents the interval for calculating the differences. The step size determines the distance between neighboring points for differentiation. Consider the scale and nature of your function and select a step size that provides accurate results. Smaller step sizes generally yield more precise differences but also increase computational time."
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
        padding: const EdgeInsets.all(20.0),
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
                      .bodyLarge!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: UtilScreen().getHeight(context) * 0.04),
            Text(
              description[currentStep - 1],
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                    AppStrings().close,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: UtilScreen().getWidth(context) * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().appGreenTwo),
                  onPressed: () {
                    if (currentStep == 3) {
                      Navigator.pop(context);
                    } else {
                      nextStep();
                    }
                  },
                  child: Text(
                    AppStrings().next,
                    style: const TextStyle(color: Colors.white),
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
