import 'package:equatable/equatable.dart';
import '../../models/character.dart';

abstract class CharacterState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state before data is loaded
class CharacterInitial extends CharacterState {}

// Loading state when data is being fetched
class CharacterLoading extends CharacterState {}

// Loaded state with filtered characters and full data list
class CharacterLoaded extends CharacterState {
  final List<Character> characters; // Filtered list for display
  final List<Character> allCharacters; // Full list for filtering/search
  final String selectedHouse; // Tracks the currently selected house

  CharacterLoaded(
    this.characters, {
    required this.allCharacters,
    this.selectedHouse = 'All',
  });

  @override
  List<Object> get props => [characters, allCharacters, selectedHouse];
}

// Character Detail State
class CharacterDetailLoaded extends CharacterState {
  final Character character;

  CharacterDetailLoaded(this.character);

  @override
  List<Object> get props => [character];
}

// Error state to handle API or data issues
class CharacterError extends CharacterState {
  final String message;

  CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
