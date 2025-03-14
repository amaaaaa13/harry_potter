part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final List<Spell> favoriteSpells;
  final List<Character> favoriteCharacters;

  const FavoriteState({
    required this.favoriteSpells,
    required this.favoriteCharacters,
  });

  /// 📌 Initial state with empty favorites
  factory FavoriteState.initial() => const FavoriteState(
        favoriteSpells: [],
        favoriteCharacters: [],
      );

  /// 📌 Copy method to update state without modifying the original
  FavoriteState copyWith({
    List<Spell>? favoriteSpells,
    List<Character>? favoriteCharacters,
  }) {
    return FavoriteState(
      favoriteSpells: favoriteSpells ?? this.favoriteSpells,
      favoriteCharacters: favoriteCharacters ?? this.favoriteCharacters,
    );
  }

  @override
  List<Object?> get props => [favoriteSpells, favoriteCharacters];
}
