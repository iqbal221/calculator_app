import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:calculator_app/presentation/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    "π",
    "n!",
    "³√",
    "%",
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

  bool isOperator(String text) => ["÷", "×", "-", "+"].contains(text);

  bool isScientificOperator(String text) => [
    "sin",
    "cos",
    "tan",
    "log",
    "⌫",
    "√",
    "x²",
    ".",
    "π",
    "n!",
    "³√",
    "%",
  ].contains(text);

  bool isClearButton(String text) => text == "C";
  bool isEqualButton(String text) => text == "=";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,

        children: buttons.map((text) {
          final isScientific = isScientificOperator(text);

          return StaggeredGridTile.count(
            crossAxisCellCount: 1,

            // 👇 smaller scientific buttons
            mainAxisCellCount: isScientific ? 0.7 : .98,

            child: CalculatorButton(
              text: text,
              scientificOperator: isScientific,
              operator: isOperator(text),
              clear: isClearButton(text),
              equal: isEqualButton(text),
              onTap: () => provider.addInput(text),
            ),
          );
        }).toList(),
      ),
    );
  }
}
