import 'package:flutter/material.dart';

import 'package:flutter_sentiment_analysis/widget/emoji_card.dart';

class PredictedSentiment extends StatelessWidget {
  final AnimationController negController;
  final AnimationController posController;
  final AnimationController neuController;
  final double probNegative;
  final double probPositive;
  final double probNeutral;
  const PredictedSentiment({
    super.key,
    required this.negController,
    required this.posController,
    required this.neuController,
    required this.probNegative,
    required this.probPositive,
    required this.probNeutral,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: EmojiCard(
                emoji: '😞',
                label: 'Negative',
                value: probNegative,
                controller: negController,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EmojiCard(
                emoji: '😊',
                label: 'Positive',
                value: probPositive,
                controller: posController,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EmojiCard(
                emoji: '😐',
                label: 'Neutral',
                value: probNeutral,
                controller: neuController,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
