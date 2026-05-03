import 'package:calculator_app/data/model/history_model.dart';
import 'package:calculator_app/data/service/calculator_service.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String input = "";
  String displayInput = "";
  String result = "0";
  bool showHistoryView = false;

  List<HistoryModel> history = [];

  /// Functions
  final List<String> functions = ["sin", "cos", "tan", "cot", "log", "ln"];

  void addInput(String value) {
    /// =========================
    /// EQUAL
    /// =========================
    if (value == "=") {
      _autoCloseBracket();

      result = CalculatorService.calculate(input);

      history.add(HistoryModel(expression: displayInput, result: result));

      showHistoryView = true;
    }
    /// =========================
    /// CLEAR
    /// =========================
    else if (value == "C") {
      input = "";
      displayInput = "";
      result = "0";
      showHistoryView = false;
    }
    /// =========================
    /// BACKSPACE (SMART)
    /// =========================
    else if (value == "⌫") {
      if (displayInput.isEmpty) return;

      /// 🔥 Handle special tokens properly
      if (displayInput.endsWith("π")) {
        input = input.substring(0, input.length - 12); // remove 3.1415926535
        displayInput = displayInput.substring(0, displayInput.length - 1);
      }
      // else if (displayInput.endsWith("³√")) {
      //   input = input.substring(0, input.length - 2);
      //   displayInput = displayInput.substring(0, displayInput.length - 2);
      // }
      else if (displayInput.endsWith("³√(")) {
        input = input.substring(0, input.length - 3);
        displayInput = displayInput.substring(0, displayInput.length - 3);
      } else if (displayInput.endsWith("n!")) {
        input = input.substring(0, input.length - 1);
        displayInput = displayInput.substring(0, displayInput.length - 2);
      } else {
        input = input.substring(0, input.length - 1);
        displayInput = displayInput.substring(0, displayInput.length - 1);
      }

      showHistoryView = false;
    }
    /// =========================
    /// NORMAL INPUT
    /// =========================
    else {
      showHistoryView = false;

      /// 🔥 SPECIAL BUTTONS

      /// π
      if (value == "π") {
        input += "π";
        displayInput += "π";
      }
      /// %
      else if (value == "%") {
        input += "%";
        displayInput += "%";
      }
      /// factorial
      else if (value == "n!") {
        input += "!";
        displayInput += "!";
      }
      /// cube root
      else if (value == "³√") {
        input += "³√";
        displayInput += "³√";
      }
      /// FUNCTIONS
      else if (functions.contains(value)) {
        input += "$value(";
        displayInput += value;
      }
      /// OPERATORS
      else if (_isOperator(value)) {
        _closeFunctionIfNeeded();
        input += value;
        displayInput += value;
      }
      /// NORMAL NUMBERS
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

  /// Close function safely
  void _closeFunctionIfNeeded() {
    int open = '('.allMatches(input).length;
    int close = ')'.allMatches(input).length;

    if (open > close) {
      input += ')';
    }
  }

  /// Auto close all brackets
  void _autoCloseBracket() {
    int open = '('.allMatches(input).length;
    int close = ')'.allMatches(input).length;

    while (open > close) {
      input += ')';
      close++;
    }
  }

  /// Theme
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }
}
