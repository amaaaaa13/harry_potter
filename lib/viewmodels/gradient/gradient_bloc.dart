import 'dart:async';
import 'package:flutter/material.dart';

class GradientBloc {
  final _gradientController = StreamController<
      List<Color>>.broadcast(); // Broadcast for multiple listeners
  final List<List<Color>> _gradientColors = [];

  GradientBloc(String house) {
    _setGradientColors(house);
    _startColorChange();
  }

  // Getter for the gradient colors
  List<List<Color>> get gradientColors => _gradientColors;

  // Stream that emits the current gradient
  Stream<List<Color>> get gradientStream => _gradientController.stream;

  // Setting gradients based on house
  void _setGradientColors(String house) {
    final houseGradients = {
      "Gryffindor": [
        [Colors.red.shade900, Colors.amber.shade700],
        [Colors.red.shade700, Colors.amber.shade600],
        [Colors.deepOrange.shade600, Colors.yellow.shade600],
      ],
      "Slytherin": [
        [Colors.green.shade900, Colors.grey.shade600],
        [Colors.green.shade800, Colors.grey.shade500],
        [Colors.teal.shade700, Colors.green.shade600],
      ],
      "Ravenclaw": [
        [Colors.blue.shade900, Colors.blueGrey.shade600],
        [Colors.indigo.shade800, Colors.blue.shade500],
        [Colors.blueGrey.shade700, Colors.white70],
      ],
      "Hufflepuff": [
        [Colors.yellow.shade800, Colors.brown.shade700],
        [Colors.amber.shade700, Colors.brown.shade600],
        [Colors.orange.shade600, Colors.yellow.shade500],
      ]
    };

    // Clear old gradients when setting new ones for a house
    _gradientColors.clear();
    _gradientColors.addAll(houseGradients[house] ??
        [
          [Colors.black87, Colors.grey.shade800],
          [Colors.black54, Colors.grey.shade600],
          [Colors.black45, Colors.grey.shade400],
        ]);
  }

  // Start periodic gradient change every 2.5 seconds
  void _startColorChange() {
    int colorIndex = 0;
    Timer.periodic(Duration(milliseconds: 2500), (timer) {
      if (_gradientController.isClosed) return;
      colorIndex = (colorIndex + 1) % _gradientColors.length;
      _gradientController.add(_gradientColors[colorIndex]);
    });
  }

  // Dispose resources
  void dispose() {
    _gradientController.close(); // Close the StreamController when done
  }
}
