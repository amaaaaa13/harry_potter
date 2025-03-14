import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/spell.dart';
import '../../models/character.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState.initial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoriteSpell>(_onToggleFavoriteSpell);
    on<ToggleFavoriteCharacter>(_onToggleFavoriteCharacter);

    add(LoadFavorites()); // ✅ Dispatch event to load favorites
  }

  /// ✅ Event handler to load favorites safely
  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoriteState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    // Load Characters
    final characterJson = prefs.getStringList('favoriteCharacters') ?? [];
    final characters = characterJson.map((char) => Character.fromJson(jsonDecode(char))).toList();

    // Load Spells
    final spellJson = prefs.getStringList('favoriteSpells') ?? [];
    final spells = spellJson.map((spell) => Spell.fromJson(jsonDecode(spell))).toList();

    emit(FavoriteState(favoriteCharacters: characters, favoriteSpells: spells)); // ✅ No more warning
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final characterJson = state.favoriteCharacters.map((char) => jsonEncode(char.toJson())).toList();
    final spellJson = state.favoriteSpells.map((spell) => jsonEncode(spell.toJson())).toList();

    prefs.setStringList('favoriteCharacters', characterJson);
    prefs.setStringList('favoriteSpells', spellJson);
  }

  void _onToggleFavoriteSpell(ToggleFavoriteSpell event, Emitter<FavoriteState> emit) {
    final updatedSpells = List<Spell>.from(state.favoriteSpells);

    if (updatedSpells.any((spell) => spell.name == event.spell.name)) {
      updatedSpells.removeWhere((spell) => spell.name == event.spell.name);
    } else {
      updatedSpells.add(event.spell);
    }

    emit(state.copyWith(favoriteSpells: updatedSpells));
    _saveFavorites();
  }

  void _onToggleFavoriteCharacter(ToggleFavoriteCharacter event, Emitter<FavoriteState> emit) {
    final updatedCharacters = List<Character>.from(state.favoriteCharacters);

    if (updatedCharacters.any((character) => character.id == event.character.id)) {
      updatedCharacters.removeWhere((character) => character.id == event.character.id);
    } else {
      updatedCharacters.add(event.character);
    }

    emit(state.copyWith(favoriteCharacters: updatedCharacters));
    _saveFavorites();
  }
}
