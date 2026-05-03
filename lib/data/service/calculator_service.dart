import 'dart:math';
import 'package:function_tree/function_tree.dart';

class CalculatorService {
  static String calculate(String expression) {
    try {
      expression = expression.replaceAll(' ', '');

      /// UI operators
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      /// π
      expression = expression.replaceAll('π', pi.toString());

      /// x²
      expression = expression.replaceAll('x²', '^2');

      /// % → divide by 100
      expression = expression.replaceAllMapped(RegExp(r'(\d+(\.\d+)?)%'), (
        match,
      ) {
        double value = double.parse(match.group(1)!);
        return (value / 100).toString();
      });

      // /// 🔥 ³√ (cube root)
      // expression = expression.replaceAllMapped(RegExp(r'³√(\d+(\.\d+)?)'), (
      //   match,
      // ) {
      //   double value = double.parse(match.group(1)!);
      //   return pow(value, 1 / 3).toDouble().toString();
      // });

      // Cube root handling
      /// ✅ Handle ³√(expression)
      /// ✅ Handle ³√number (no brackets)
      expression = expression.replaceAllMapped(RegExp(r'³√(\d+(\.\d+)?)'), (
        match,
      ) {
        double value = double.parse(match.group(1)!);

        double result;

        if (value >= 0) {
          result = pow(value, 1 / 3).toDouble();
        } else {
          result = -pow(value.abs(), 1 / 3).toDouble();
        }

        if ((result - result.round()).abs() < 1e-10) {
          result = result.roundToDouble();
        }

        return result.toString();
      });

      /// √ (square root)
      expression = expression.replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (
        match,
      ) {
        double value = double.parse(match.group(1)!);
        return sqrt(value).toString();
      });

      print("Before eval: $expression");

      /// 🔥 Factorial (n!)
      expression = expression.replaceAllMapped(RegExp(r'(\d+)!'), (match) {
        int value = int.parse(match.group(1)!);
        return _factorial(value).toString();
      });

      /// sin, cos, tan (degree)
      expression = expression.replaceAllMapped(
        RegExp(r'(sin|cos|tan)\(([^)]+)\)'),
        (match) {
          final func = match.group(1)!;
          final value = double.parse(match.group(2)!);

          final rad = value * pi / 180;

          double result;

          switch (func) {
            case 'sin':
              result = sin(rad);
              break;
            case 'cos':
              result = cos(rad);
              break;
            case 'tan':
              if (value % 180 == 90) return "Error";
              result = tan(rad);
              break;
            default:
              result = 0;
          }

          if (result.abs() < 1e-10) result = 0;

          return result.toString();
        },
      );

      /// log base 10
      expression = expression.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (
        match,
      ) {
        final value = double.parse(match.group(1)!);
        if (value <= 0) return "Error";
        return (log(value) / ln10).toString();
      });

      /// ln
      expression = expression.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), (
        match,
      ) {
        final value = double.parse(match.group(1)!);
        if (value <= 0) return "Error";
        return log(value).toString();
      });

      /// 🔥 FINAL EVALUATION
      final result = expression.interpret();

      /// Format result
      if (result % 1 == 0) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  /// 🔥 Factorial function
  static int _factorial(int n) {
    if (n < 0) return 0;
    if (n == 0 || n == 1) return 1;

    int result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }
}
