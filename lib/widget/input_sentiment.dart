import 'package:flutter/material.dart';

class InputSentiment extends StatelessWidget {
  final TextEditingController controller;
  const InputSentiment({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.12),
        hintText: 'Enter some text...',
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      maxLines: null,
    );
  }
}
