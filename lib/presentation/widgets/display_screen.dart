import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayScreen extends StatelessWidget {
  final String value;

  const DisplayScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final calculatorTheme = context.read<CalculatorProvider>();

    return Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(20),
      child: Text(
        value.isEmpty ? "0" : value,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: calculatorTheme.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
