import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'gradient_event.dart';
import 'gradient_state.dart';

class GradientBloc extends Bloc<GradientEvent, GradientState> {
  List<List<Color>> _gradientColors = [];
  int _colorIndex = 0;
  Timer? _timer;

  GradientBloc() : super(GradientInitial()) {
    on<StartGradientAnimation>(_onStartGradientAnimation);
    on<CycleGradient>(_onCycleGradient);
  }

  void _onStartGradientAnimation(
      StartGradientAnimation event, Emitter<GradientState> emit) {
    _setGradientColors(event.house);
    _startColorChange(emit);
  }

  void _onCycleGradient(CycleGradient event, Emitter<GradientState> emit) {
    _cycleGradient(emit);
  }

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

    _gradientColors = houseGradients[house] ??
        [
          [Colors.black87, Colors.grey.shade800],
          [Colors.black54, Colors.grey.shade600],
          [Colors.black45, Colors.grey.shade400],
        ];
  }

  void _startColorChange(Emitter<GradientState> emit) {
    emit(GradientUpdated(_gradientColors[0]));
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 2500), (timer) {
      add(CycleGradient());
    });
  }

  void _cycleGradient(Emitter<GradientState> emit) {
    _colorIndex = (_colorIndex + 1) % _gradientColors.length;
    emit(GradientUpdated(_gradientColors[_colorIndex]));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
