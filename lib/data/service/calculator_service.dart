import 'dart:math';
import 'package:function_tree/function_tree.dart';

class CalculatorService {
  static String calculate(String expression) {
    try {
      /// Replace basic operators
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      /// Constants
      expression = expression.replaceAll('π', pi.toString());

      /// Power
      expression = expression.replaceAll('x²', '^2');

      /// Fix sqrt
      expression = expression.replaceAllMapped(
        RegExp(r'√(\d+(\.\d+)?)'),
        (match) => 'sqrt(${match.group(1)})',
      );

      /// Fix sin, cos, tan, log (add parentheses)
      expression = expression.replaceAllMapped(
        RegExp(r'(sin|cos|tan|log)(\d+(\.\d+)?)'),
        (match) => '${match.group(1)}(${match.group(2)})',
      );

      final result = expression.interpret();

      if (result % 1 == 0) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (e) {
      return "Error";
    }
  }
}
