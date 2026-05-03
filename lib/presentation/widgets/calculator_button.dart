import 'package:calculator_app/core/constants/app_colors.dart';
import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool operator;
  final bool scientificOperator;
  final bool equal;
  final bool clear;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.operator,
    required this.scientificOperator,
    required this.equal,
    required this.clear,
  });

  @override
  Widget build(BuildContext context) {
    final calculator = context.watch<CalculatorProvider>();

    Color bgColor;
    Color textColor;
    double fontSize;
    EdgeInsets padding;

    /// 🔵 Scientific (smaller look)
    if (scientificOperator) {
      bgColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightButton
          : AppColors.darkButton;

      textColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightText
          : AppColors.darkText;

      fontSize = 20;
      padding = const EdgeInsets.all(8);
    }
    /// 🔴 Operator
    else if (operator) {
      bgColor = AppColors.operatorButton;
      textColor = Colors.white;
      fontSize = 32;
      padding = const EdgeInsets.all(12);
    }
    /// 🟢 Clear
    else if (clear) {
      bgColor = AppColors.clearButton;
      textColor = Colors.white;
      fontSize = 32;
      padding = const EdgeInsets.all(12);
    }
    /// 🟠 Equal
    else if (equal) {
      bgColor = AppColors.equalButton;
      textColor = Colors.white;
      fontSize = 32;
      padding = const EdgeInsets.all(12);
    }
    /// ⚪ Numbers
    else {
      bgColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightButton
          : AppColors.darkButton;

      textColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightText
          : AppColors.darkText;

      fontSize = 32;
      padding = const EdgeInsets.all(12);
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        padding: padding,
        elevation: 2,
      ),

      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
