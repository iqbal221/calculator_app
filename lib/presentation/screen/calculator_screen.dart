import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:calculator_app/presentation/widgets/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scientific Calculator"),

        actions: [
          IconButton(
            icon: Icon(
              calculator.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              calculator.toggleTheme();
            },
          ),
        ],
      ),

      body: Column(children: [DisplayScreen(value: calculator.input)]),
    );
  }
}
