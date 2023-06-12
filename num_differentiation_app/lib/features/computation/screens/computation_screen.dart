import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:num_differentiation_app/app/constants/app_colors.dart';
import 'package:num_differentiation_app/app/constants/app_strings.dart';
import 'package:num_differentiation_app/app/shared/widgets/custom_dialog.dart';
import 'package:num_differentiation_app/app/util/util_screen.dart';
import 'package:num_differentiation_app/features/computation/models/difference_calculator.dart';

class ComputationScreen extends StatefulWidget {
  const ComputationScreen({super.key});

  @override
  State<ComputationScreen> createState() => _ComputationScreenState();
}

class _ComputationScreenState extends State<ComputationScreen> {
  TextEditingController functionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController stepSizeController = TextEditingController();
  String result = '';
  double forwardDifference = 0;
  double backwardDifference = 0;
  double centralDifference = 0;
  int decimalPlaces = 2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void restartComputation() {
    setState(() {
      forwardDifference = 0;
      backwardDifference = 0;
      centralDifference = 0;
      functionController.clear();
      pointController.clear();
      stepSizeController.clear();
    });
  }

  void computeDerivatives() {
    String function = functionController.text;
    double? point = double.tryParse(pointController.text);
    double? stepSize = double.tryParse(stepSizeController.text);

    if (function.isEmpty || point == null || stepSize == null) {
      setState(() {
        result = 'Invalid input';
      });
      return;
    }
    try {
      setState(() {
        Parser parser = Parser();

        Expression expression = parser.parse(function);

        // Create a context to hold the variable values
        ContextModel context = ContextModel();
        context.bindVariable(Variable('x'), Number(point));

        forwardDifference = DifferenceCalculator()
            .computeForwardDifference(expression, point, stepSize);

        backwardDifference = DifferenceCalculator()
            .computeBackwardDifference(expression, point, stepSize);
        centralDifference = DifferenceCalculator()
            .computeCentralDifference(expression, point, stepSize);

        result =
            'Forward difference: $forwardDifference\nBackward difference: $backwardDifference\nCentral difference: $centralDifference';
      });
    } on FormatException {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppStrings().dialogTitleFunction),
              content: Text(AppStrings().dialogDescriptionFunction),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings().ok))
              ],
            );
          });
    } on RangeError {
      Fluttertoast.showToast(
          msg: "Double check the function value, make sure it's correct",
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: UtilScreen().getWidth(context) * 0.08,
                      ),
                      SvgPicture.asset(
                        'assets/icon_logo.svg',
                        width: UtilScreen().getWidth(context) * 0.1,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const MyDialog();
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/question_icon.svg',
                          width: UtilScreen().getWidth(context) * 0.1,
                        ),
                      ),
                      SizedBox(
                        width: UtilScreen().getWidth(context) * 0.08,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: UtilScreen().getHeight(context) * 0.03,
                ),
                GestureDetector(
                  onTap: () => restartComputation(),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: UtilScreen().getWidth(context) * 0.08),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.refresh,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Function",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    maxLength: 100,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field cannot be empty';
                      }
                      if (!value.contains('x')) {
                        return 'Field must contain x variable';
                      }
                      return null;
                    },
                    controller: functionController,
                    decoration: InputDecoration(
                      counter: const SizedBox.shrink(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          )),
                      hintText: 'Enter text',
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: UtilScreen().getHeight(context) * 0.02,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Value of X",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value for the x point';
                      }
                      double? point = double.tryParse(value);
                      if (point == null) {
                        return 'Invalid x point. Please enter a valid numeric value.';
                      }
                      return null; // Return null if the value is valid
                    },
                    controller: pointController,
                    decoration: InputDecoration(
                      counter: const SizedBox.shrink(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          )),
                      hintText: 'Enter text',
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: UtilScreen().getHeight(context) * 0.02,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Step Size (Interval)",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value for the step size';
                      }
                      double? stepSize = double.tryParse(value);
                      if (stepSize == null) {
                        return 'Invalid step size. Please enter a valid numeric value.';
                      }
                      return null; // Return null if the value is valid
                    },
                    controller: stepSizeController,
                    decoration: InputDecoration(
                      counter: const SizedBox.shrink(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          )),
                      hintText: 'Enter text',
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: UtilScreen().getWidth(context),
                  height: UtilScreen().getHeight(context) * 0.40,
                  decoration: BoxDecoration(
                      color: AppColors().appGreenTwo,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(44),
                          topRight: Radius.circular(44))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: UtilScreen().getHeight(context) * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: UtilScreen().getWidth(context),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Forward",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 18),
                            ),
                            Text(
                              forwardDifference.toStringAsFixed(decimalPlaces),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 18,
                                    color: AppColors().appDarkTwo,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: UtilScreen().getHeight(context) * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: UtilScreen().getWidth(context),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Centered",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 18),
                            ),
                            Text(
                              centralDifference.toStringAsFixed(decimalPlaces),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: UtilScreen().getHeight(context) * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: UtilScreen().getWidth(context),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Backward",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 18),
                            ),
                            Text(
                              backwardDifference.toStringAsFixed(decimalPlaces),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onHorizontalDragUpdate: (DragUpdateDetails details) {
                          setState(() {
                            if (details.delta.dx > 0) {
                              if (decimalPlaces == 8) {
                                return;
                              } else {
                                decimalPlaces++;
                              }
                              // Increment the number when swiping right
                            } else if (details.delta.dx < 0) {
                              if (decimalPlaces == 0) {
                                return;
                              } else {
                                decimalPlaces--;
                              }
                              // Decrement the number when swiping left
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 60,
                          width: UtilScreen().getWidth(context),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(10))),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors().appDarkTwo),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  computeDerivatives();
                                }
                              },
                              child: Text(
                                "COMPUTE",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: UtilScreen().getHeight(context) * 0.02,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
