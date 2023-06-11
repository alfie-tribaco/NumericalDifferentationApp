import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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

    Parser parser = Parser();
    Expression expression = parser.parse(function);

    // Create a context to hold the variable values
    ContextModel context = ContextModel();
    context.bindVariable(Variable('x'), Number(point));
    setState(() {
      double forwardDifference =
          computeForwardDifference(expression, point, stepSize);
      double backwardDifference =
          computeBackwardDifference(expression, point, stepSize);
      double centralDifference =
          computeCentralDifference(expression, point, stepSize);

      print("FORWARD: " + forwardDifference.toString());

      result =
          'Forward difference: $forwardDifference\nBackward difference: $backwardDifference\nCentral difference: $centralDifference';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Please Input'),
            TextField(
              controller: functionController,
              onChanged: (e) {},
            ),
            TextField(
              controller: pointController,
              onChanged: (e) {},
            ),
            TextField(
              controller: stepSizeController,
            ),
            Text(
              result,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          computeDerivatives();
        },
        tooltip: 'Compute',
        child: const Icon(Icons.add),
      ),
    );
  }
}

double computeForwardDifference(Expression expression, double x, double h) {
  ContextModel context = ContextModel();
  context.bindVariable(Variable('x'), Number(x));

  double f = expression.evaluate(EvaluationType.REAL, context);

  context.bindVariable(Variable('x'), Number(x + h));
  double fPlusH = expression.evaluate(EvaluationType.REAL, context);

  double derivative = (fPlusH - f) / h;

  return derivative;
}

double computeBackwardDifference(Expression expression, double x, double h) {
  ContextModel context = ContextModel();
  context.bindVariable(Variable('x'), Number(x));

  double f = expression.evaluate(EvaluationType.REAL, context);

  context.bindVariable(Variable('x'), Number(x - h));
  double fMinusH = expression.evaluate(EvaluationType.REAL, context);

  double derivative = (f - fMinusH) / h;

  return derivative;
}

double computeCentralDifference(Expression expression, double x, double h) {
  ContextModel context = ContextModel();
  context.bindVariable(Variable('x'), Number(x - h));
  double fMinusH = expression.evaluate(EvaluationType.REAL, context);

  context.bindVariable(Variable('x'), Number(x + h));
  double fPlusH = expression.evaluate(EvaluationType.REAL, context);

  double derivative = (fPlusH - fMinusH) / (2 * h);

  return derivative;
}
