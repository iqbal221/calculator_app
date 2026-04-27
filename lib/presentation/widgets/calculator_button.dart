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

    // Operator buttons
    if (operator) {
      bgColor = AppColors.operatorButton;
      textColor = Colors.white;
      fontSize = 36;
      padding = const EdgeInsets.all(16);
    } else if (scientificOperator) {
      bgColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightButton
          : AppColors.darkButton;
      textColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightText
          : AppColors.darkText;
      fontSize = 22;
      padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
    } else if (clear) {
      bgColor = AppColors.clearButton;
      textColor = Colors.white;
      fontSize = 36;
      padding = const EdgeInsets.all(16);
    } else if (equal) {
      bgColor = AppColors.equalButton;
      textColor = Colors.white;

      fontSize = 36;
      padding = const EdgeInsets.all(16);
    } else {
      // Number buttons
      bgColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightButton
          : AppColors.darkButton;
      textColor = calculator.themeMode == ThemeMode.dark
          ? AppColors.lightText
          : AppColors.darkText;
      fontSize = 36;
      padding = const EdgeInsets.all(16);
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: padding,
        elevation: 3,
        // IMPORTANT
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
