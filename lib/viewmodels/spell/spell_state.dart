import 'package:equatable/equatable.dart';
import '../../models/spell.dart';

abstract class SpellState extends Equatable {
  @override
  List<Object> get props => [];
}

class SpellInitial extends SpellState {}

class SpellLoading extends SpellState {}

class SpellLoaded extends SpellState {
  final List<Spell> spells;

  SpellLoaded(this.spells);

  @override
  List<Object> get props => [spells];
}

class SpellError extends SpellState {
  final String message;

  SpellError(this.message);

  @override
  List<Object> get props => [message];
}
