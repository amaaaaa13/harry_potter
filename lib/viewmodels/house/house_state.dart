import 'package:equatable/equatable.dart';
import '../../models/character.dart';

abstract class HouseState extends Equatable {
  @override
  List<Object> get props => [];
}

class HouseInitial extends HouseState {}

class HouseLoading extends HouseState {}

class HouseLoaded extends HouseState {
  final List<Character> characters;

  HouseLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class HouseError extends HouseState {
  final String message;

  HouseError(this.message);

  @override
  List<Object> get props => [message];
}
