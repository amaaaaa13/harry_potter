import 'package:equatable/equatable.dart';

abstract class GradientEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartGradientAnimation extends GradientEvent {
  final String house;

  StartGradientAnimation(this.house);

  @override
  List<Object> get props => [house];
}

class CycleGradient extends GradientEvent {}
