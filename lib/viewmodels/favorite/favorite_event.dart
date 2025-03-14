part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

/// 📌 Load favorites from storage
class LoadFavorites extends FavoriteEvent {}

/// 📌 Toggle a spell as favorite/unfavorite
class ToggleFavoriteSpell extends FavoriteEvent {
  final Spell spell;

  const ToggleFavoriteSpell(this.spell);

  @override
  List<Object?> get props => [spell];
}

/// 📌 Toggle a character as favorite/unfavorite
class ToggleFavoriteCharacter extends FavoriteEvent {
  final Character character;

  const ToggleFavoriteCharacter(this.character);

  @override
  List<Object?> get props => [character];
}
