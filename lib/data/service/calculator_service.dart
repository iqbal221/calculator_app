import 'dart:math';
import 'package:function_tree/function_tree.dart';

class CalculatorService {
  static String calculate(String expression) {
    try {
      expression = expression.replaceAll(' ', '');

      /// Replace UI operators
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      /// Replace π with actual value
      expression = expression.replaceAll('π', pi.toString());

      /// Power
      expression = expression.replaceAll('x²', '^2');

      /// Square root
      expression = expression.replaceAllMapped(
        RegExp(r'√(\d+(\.\d+)?)'),
        (match) => sqrt(double.parse(match.group(1)!)).toString(),
      );

      /// Handle sin, cos, tan (MANUAL calculation)
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
              result = tan(rad);
              break;
            default:
              result = 0;
          }

          /// 🔥 FIX PRECISION
          if (result.abs() < 1e-10) result = 0;

          /// 🔥 HANDLE tan(90), tan(270)
          if (func == 'tan' && (value % 180 == 90)) {
            return "Error"; // or "∞"
          }

          return result.toString();
        },
      );

      /// Handle log (base 10)
      expression = expression.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (
        match,
      ) {
        final value = double.parse(match.group(1)!);

        if (value <= 0) return "Error";

        final result = log(value) / ln10; // log10(x)

        return result.toString();
      });

      /// Evaluate remaining expression
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
}
