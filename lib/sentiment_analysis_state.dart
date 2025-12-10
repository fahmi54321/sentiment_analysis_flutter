import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SentimentAnalysisState extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final TickerProviderStateMixin vsync;

  final double cardRadius = 24.0;

  bool isLoading = false;
  bool isButtonPressed = false;

  double probNegative = 0.0;
  double probPositive = 0.0;
  double probNeutral = 0.0;

  late AnimationController negController;
  late AnimationController posController;
  late AnimationController neuController;

  SentimentAnalysisState({required this.vsync}) {
    negController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
    posController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
    neuController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );

    negController.repeat(reverse: true);
    posController.repeat(reverse: true);
    neuController.repeat(reverse: true);
  }

  @override
  void dispose() {
    negController.dispose();
    posController.dispose();
    neuController.dispose();
    controller.dispose();
    super.dispose();
  }

  void setButtonPressed(bool pressed) {
    isButtonPressed = pressed;
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setProbabilities(double negative, double positive, double neutral) {
    probNegative = negative;
    probPositive = positive;
    probNeutral = neutral;
    notifyListeners();
  }

  void forwardController({
    required AnimationController controller,
    required double from,
  }) {
    controller.forward(from: from);
    notifyListeners();
  }

  void repeatController({required AnimationController controller}) {
    controller.repeat(reverse: true);
    notifyListeners();
  }

  Future<void> analyzeText(String inputText) async {
    if (inputText.trim().isEmpty) return;
    setLoading(true);
    setProbabilities(0.0, 0.0, 0.0);

    final uri = Uri.parse('http://10.0.2.2:5000/predict');

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": inputText}),
      );

      await Future.delayed(const Duration(milliseconds: 600));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final probs = data['probabilities'] as Map<String, dynamic>?;

        double neg = 0, pos = 0, neu = 0;
        if (probs != null) {
          neg = (probs['negative'] ?? 0).toDouble();
          pos = (probs['positive'] ?? 0).toDouble();
          neu = (probs['neutral'] ?? 0).toDouble();
        }

        setProbabilities(
          neg.clamp(0.0, 1.0),
          pos.clamp(0.0, 1.0),
          neu.clamp(0.0, 1.0),
        );

        if (probNegative > 0.6) {
          forwardController(controller: negController, from: 0.0);
        } else {
          repeatController(controller: negController);
        }
        if (probPositive > 0.6) {
          forwardController(controller: posController, from: 0.0);
        } else {
          repeatController(controller: posController);
        }
        if (probNeutral > 0.6) {
          forwardController(controller: neuController, from: 0.0);
        } else {
          repeatController(controller: neuController);
        }
      } else {
        debugPrint("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error connecting to server");
    } finally {
      setLoading(false);
    }
  }
}
