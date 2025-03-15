import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GradientState extends Equatable {
  @override
  List<Object> get props => [];
}

class GradientInitial extends GradientState {}

class GradientUpdated extends GradientState {
  final List<Color> gradientColors;

  GradientUpdated(this.gradientColors);

  @override
  List<Object> get props => [gradientColors];
}
