import 'package:calculator_app/data/model/history_model.dart';
import 'package:calculator_app/data/service/calculator_service.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String input = "";
  String result = "0";

  List<HistoryModel> history = [];

  void addInput(String value) {
    if (value == "=") {
      result = CalculatorService.calculate(input);

      history.add(HistoryModel(expression: input, result: result));

      input = result;
    } else if (value == "C") {
      input = "";
      result = "0";
    } else {
      input += value;
    }

    notifyListeners();
  }

  /// Theme Mode
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }

    notifyListeners();
  }
}
