import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:calculator_app/presentation/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorGrid extends StatelessWidget {
  CalculatorGrid({super.key});

  final List<String> buttons = [
    "sin",
    "cos",
    "tan",
    "log",
    "⌫",
    "√",
    "x²",
    ".",
    "7",
    "8",
    "9",
    "÷",
    "4",
    "5",
    "6",
    "×",
    "1",
    "2",
    "3",
    "-",
    "0",
    "C",
    "=",
    "+",
  ];

  /// Determine if the button is an operator/scientific function
  bool isOperator(String text) {
    const operators = ["÷", "×", "-", "+"];
    return operators.contains(text);
  }

  /// Determine if the button is an operator/scientific function
  bool isScientificOperator(String text) {
    const operators = ["sin", "cos", "tan", "log", "⌫", "√", "x²"];
    return operators.contains(text);
  }

  bool isClearButton(String text) {
    const operators = ["C"];
    return operators.contains(text);
  }

  bool isEqualButton(String text) {
    const operators = ["="];
    return operators.contains(text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);

    return GridView.builder(
      itemCount: buttons.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
      ),

      itemBuilder: (context, index) {
        final buttonText = buttons[index];
        final operator = isOperator(buttonText);
        final scientificOperator = isScientificOperator(buttonText);
        final clear = isClearButton(buttonText);
        final equal = isEqualButton(buttonText);

        return CalculatorButton(
          text: buttons[index],
          scientificOperator: scientificOperator,
          operator: operator,
          clear: clear,
          equal: equal,
          onTap: () {
            provider.addInput(buttons[index]);
          },
        );
      },
    );
  }
}
