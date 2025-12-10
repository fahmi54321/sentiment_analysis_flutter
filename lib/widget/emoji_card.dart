import 'package:flutter/material.dart';

class EmojiCard extends StatelessWidget {
  final String emoji;
  final String label;
  final double value;
  final AnimationController controller;
  final Color color;
  const EmojiCard({
    super.key,
    required this.emoji,
    required this.label,
    required this.value,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final basePulse = 0.02 + controller.value * 0.03;
        final strength = (value > 0.6) ? (0.15 + (value - 0.6) * 0.6) : 0.0;
        final scale = 1.0 + basePulse + strength;
        final glow = (value > 0.6) ? (6.0 + (value - 0.6) * 20.0) : 0.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
              boxShadow: glow > 0
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.18),
                        blurRadius: glow,
                        spreadRadius: glow / 6,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${(value * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 8,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
