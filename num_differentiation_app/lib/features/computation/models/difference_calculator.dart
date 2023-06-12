import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';

class DifferenceCalculator {
  double computeForwardDifference(Expression expression, double x, double h) {
    try {
      ContextModel context = ContextModel();
      context.bindVariable(Variable('x'), Number(x));

      double f = expression.evaluate(EvaluationType.REAL, context);

      context.bindVariable(Variable('x'), Number(x + h));
      double fPlusH = expression.evaluate(EvaluationType.REAL, context);

      double derivative = (fPlusH - f) / h;

      return derivative;
    } on StateError {
      Fluttertoast.showToast(
          msg: "Please make sure the expression is valid",
          backgroundColor: Colors.red);
      return 0;
    }
  }

  double computeBackwardDifference(Expression expression, double x, double h) {
    try {
      ContextModel context = ContextModel();
      context.bindVariable(Variable('x'), Number(x));

      double f = expression.evaluate(EvaluationType.REAL, context);

      context.bindVariable(Variable('x'), Number(x - h));
      double fMinusH = expression.evaluate(EvaluationType.REAL, context);

      double derivative = (f - fMinusH) / h;

      return derivative;
    } on StateError {
      Fluttertoast.showToast(
          msg: "Please make sure the expression is valid",
          backgroundColor: Colors.red);
      return 0;
    }
  }

  double computeCentralDifference(Expression expression, double x, double h) {
    try {
      ContextModel context = ContextModel();
      context.bindVariable(Variable('x'), Number(x - h));
      double fMinusH = expression.evaluate(EvaluationType.REAL, context);

      context.bindVariable(Variable('x'), Number(x + h));
      double fPlusH = expression.evaluate(EvaluationType.REAL, context);

      double derivative = (fPlusH - fMinusH) / (2 * h);

      return derivative;
    } on StateError {
      Fluttertoast.showToast(
          msg: "Please make sure the expression is valid",
          backgroundColor: Colors.red);
      return 0;
    }
  }
}
