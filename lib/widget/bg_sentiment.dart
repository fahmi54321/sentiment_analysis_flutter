import 'package:flutter/material.dart';

class BgSentiment extends StatelessWidget {
  const BgSentiment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
