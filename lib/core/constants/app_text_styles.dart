import 'package:flutter/material.dart';

class AppTextStyles {
  /// Display Text (Calculator Screen)
  static const TextStyle displayText = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  /// Button Text
  static const TextStyle buttonText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  /// Operator Button Text
  static const TextStyle operatorText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  /// History Text
  static const TextStyle historyExpression = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle historyResult = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
