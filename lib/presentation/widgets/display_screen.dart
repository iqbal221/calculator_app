import 'package:calculator_app/presentation/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 🔥 AFTER "=" → show calculation on top
          if (provider.showHistoryView)
            Text(
              provider.displayInput,
              style: const TextStyle(fontSize: 24, color: Colors.grey),
            ),

          const SizedBox(height: 5),

          /// 🔥 Main display
          Expanded(
            child: SizedBox(
              height: 110, // 🔥 constrain height
              child: AutoSizeText(
                provider.showHistoryView
                    ? provider.result
                    : (provider.displayInput.isEmpty
                          ? "0"
                          : provider.displayInput),
                maxLines: 2,
                minFontSize: 30,
                stepGranularity: 2,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: provider.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
