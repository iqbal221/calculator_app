import 'dart:math';
import 'package:function_tree/function_tree.dart';

class CalculatorService {
  static String calculate(String expression) {
    try {
      /// Replace UI symbols
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      /// Scientific replacements
      expression = expression.replaceAll('π', pi.toString());
      expression = expression.replaceAll('x²', '^2');
      expression = expression.replaceAll('√', 'sqrt');

      final result = expression.interpret();

      /// Remove unnecessary decimals
      if (result % 1 == 0) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (_) {
      return "Error";
    }
  }
}
