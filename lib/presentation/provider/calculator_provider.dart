import 'package:calculator_app/data/model/history_model.dart';
import 'package:calculator_app/data/service/calculator_service.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String input = ""; // internal (used for calculation)
  String displayInput = ""; // shown in UI
  String result = "0";
  bool showHistoryView = false;

  List<HistoryModel> history = [];

  /// List of functions
  final List<String> functions = ["sin", "cos", "tan", "cot", "log", "ln"];

  void addInput(String value) {
    if (value == "=") {
      _autoCloseBracket();

      result = CalculatorService.calculate(input);

      history.add(HistoryModel(expression: displayInput, result: result));

      /// ✅ Switch UI mode
      showHistoryView = true;
    } else if (value == "C") {
      input = "";
      displayInput = "";
      result = "0";

      /// ✅ Reset UI
      showHistoryView = false;
    } else if (value == "⌫") {
      if (displayInput.isEmpty) return;

      displayInput = displayInput.substring(0, displayInput.length - 1);
      input = input.substring(0, input.length - 1);

      /// ✅ Back to input mode
      showHistoryView = false;
    } else {
      /// ✅ New input → reset mode
      showHistoryView = false;

      if (functions.contains(value)) {
        input += "$value(";
        displayInput += value;
      } else if (_isOperator(value)) {
        _closeFunctionIfNeeded();
        input += value;
        displayInput += value;
      } else {
        input += value;
        displayInput += value;
      }
    }

    notifyListeners();
  }

  bool _isOperator(String value) {
    return ["+", "-", "×", "÷"].contains(value);
  }

  /// 🔥 Close function safely
  void _closeFunctionIfNeeded() {
    int open = '('.allMatches(input).length;
    int close = ')'.allMatches(input).length;

    if (open > close) {
      input += ')';
    }
  }

  /// 🔥 Auto close all brackets
  void _autoCloseBracket() {
    int open = '('.allMatches(input).length;
    int close = ')'.allMatches(input).length;

    while (open > close) {
      input += ')';
      close++;
    }
  }

  /// Theme Mode
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }
}
