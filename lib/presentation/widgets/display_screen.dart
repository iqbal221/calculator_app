import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final String value;

  const DisplayScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(20),
      child: Text(
        value.isEmpty ? "0" : value,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
