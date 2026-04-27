import 'package:calculator_app/data/model/history_model.dart';
import 'package:calculator_app/data/service/calculator_service.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String input = ""; // internal (used for calculation)
  String displayInput = ""; // shown in UI
  String result = "0";

  List<HistoryModel> history = [];

  /// List of functions
  final List<String> functions = ["sin", "cos", "tan", "cot", "log", "ln"];

  void addInput(String value) {
    if (value == "=") {
      _autoCloseBracket();

      result = CalculatorService.calculate(input);

      history.add(HistoryModel(expression: displayInput, result: result));

      input = result;
      displayInput = result;
    }
    /// 🔥 FIXED BACKSPACE
    else if (value == "⌫") {
      if (displayInput.isEmpty) return;

      /// Handle function removal
      for (var func in functions) {
        if (displayInput.endsWith(func)) {
          input = input.substring(
            0,
            input.length - (func.length + 1),
          ); // remove func(
          displayInput = displayInput.substring(
            0,
            displayInput.length - func.length,
          );
          notifyListeners();
          return;
        }
      }

      /// Normal character remove
      input = input.substring(0, input.length - 1);
      displayInput = displayInput.substring(0, displayInput.length - 1);
    } else if (value == "C") {
      input = "";
      displayInput = "";
      result = "0";
    } else {
      /// ✅ Function input
      if (functions.contains(value)) {
        input += "$value(";
        displayInput += value;
      }
      /// ✅ Operator
      else if (_isOperator(value)) {
        _closeFunctionIfNeeded();

        input += value;
        displayInput += value;
      }
      /// ✅ Normal number / dot
      else {
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
