import 'package:flutter/material.dart';

class DescSentiment extends StatelessWidget {
  const DescSentiment({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter tweet or sentence and press Analyze',
      style: TextStyle(color: Colors.white70),
    );
  }
}
