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

      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: DisplayScreen()),

            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),

                child: CalculatorGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
