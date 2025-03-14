import 'package:equatable/equatable.dart';

abstract class SpellEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSpells extends SpellEvent {}
