import 'package:calculator_app/core/constants/app_colors.dart';
import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:calculator_app/presentation/widgets/calculator_grid.dart';
import 'package:calculator_app/presentation/widgets/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = context.watch<CalculatorProvider>();

    return Scaffold(
      backgroundColor: calculator.themeMode == ThemeMode.dark
          ? AppColors.lightBackground
          : AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: calculator.themeMode == ThemeMode.dark
            ? AppColors.lightBackground
            : AppColors.darkBackground,
        actions: [
          IconButton(
            icon: Icon(
              color: AppColors.operatorButton,
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

      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(flex: 2, child: DisplayScreen(value: calculator.input)),
          const SizedBox(height: 2),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),

              child: CalculatorGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
