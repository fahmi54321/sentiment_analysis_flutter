import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sentiment_analysis/sentiment_analysis_state.dart';
import 'package:flutter_sentiment_analysis/widget/bg_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/button_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/desc_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/input_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/loader_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/predicted_sentiment.dart';
import 'package:flutter_sentiment_analysis/widget/title_sentiment.dart';
import 'package:provider/provider.dart';

class SentimentAnalysisPage extends StatefulWidget {
  const SentimentAnalysisPage({super.key});

  @override
  State<SentimentAnalysisPage> createState() => _SentimentAnalysisPageState();
}

class _SentimentAnalysisPageState extends State<SentimentAnalysisPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SentimentAnalysisState(vsync: this),
      child: Consumer(
        builder: (BuildContext context, SentimentAnalysisState state, _) {
          return Stack(
            children: [
              BgSentiment(),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(state.cardRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 520,
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(
                              state.cardRadius,
                            ),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TitleSentiment(),
                              const SizedBox(height: 12),
                              DescSentiment(),
                              const SizedBox(height: 18),
                              InputSentiment(controller: state.controller),
                              const SizedBox(height: 16),
                              ButtonSentiment(
                                onTapDown: (_) {
                                  state.setButtonPressed(true);
                                },
                                onTapUp: (_) {
                                  state.setButtonPressed(false);
                                },
                                onTapCancel: () {
                                  state.setButtonPressed(false);
                                },
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  state.analyzeText(state.controller.text);
                                },
                                isButtonPressed: state.isButtonPressed,
                              ),
                              const SizedBox(height: 20),
                              if (state.isLoading)
                                LoaderSentiment()
                              else
                                PredictedSentiment(
                                  negController: state.negController,
                                  posController: state.posController,
                                  neuController: state.neuController,
                                  probNegative: state.probNegative,
                                  probPositive: state.probPositive,
                                  probNeutral: state.probNeutral,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
