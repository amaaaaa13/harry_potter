import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/core/services/harry_potter_service.dart';
import 'package:harry_potter/models/character.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final HarryPotterService hpService;

  List<Character> allCharacters = []; // Store all characters for filtering

  CharacterBloc(this.hpService) : super(CharacterInitial()) {
    on<FetchAllCharacters>(_onFetchAllCharacters);
    on<FetchCharacterDetails>(
        _onFetchCharacterDetails); // Handle fetch character details
    on<FetchStudents>(_onFetchStudents);
    on<FetchStaff>(_onFetchStaff);
    on<FilterCharactersByHouse>(_onFilterCharactersByHouse);
    on<SearchCharacter>(_onSearchCharacter);
    on<SelectHouse>(_onSelectHouse);
  }

  Future<void> _onFetchAllCharacters(
      FetchAllCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    final result = await hpService.getCharacters();
    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) {
        allCharacters = characters;
        emit(CharacterLoaded(characters,
            allCharacters: characters, selectedHouse: 'All'));
      },
    );
  }

  Future<void> _onFetchCharacterDetails(
      FetchCharacterDetails event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    final result = await hpService
        .getCharacterById(event.characterId); // Fetch character by ID
    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (character) {
        emit(CharacterDetailLoaded(character));
      },
    );
  }

  Future<void> _onFetchStudents(
      FetchStudents event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    final result = await hpService.getStudents();
    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) {
        allCharacters = characters;
        emit(CharacterLoaded(characters,
            allCharacters: characters, selectedHouse: 'All'));
      },
    );
  }

  Future<void> _onFetchStaff(
      FetchStaff event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    final result = await hpService.getStaff();
    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) {
        allCharacters = characters;
        emit(CharacterLoaded(characters,
            allCharacters: characters, selectedHouse: 'All'));
      },
    );
  }

  Future<void> _onFilterCharactersByHouse(
      FilterCharactersByHouse event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      List<Character> filteredCharacters;

      switch (event.houseName) {
        case 'All':
          filteredCharacters = currentState.allCharacters;
          break;
        case 'Unknown':
          filteredCharacters = currentState.allCharacters
              .where((char) => char.house.trim().isEmpty)
              .toList();
          break;
        default:
          filteredCharacters = currentState.allCharacters
              .where((char) =>
                  char.house.toLowerCase() == event.houseName.toLowerCase())
              .toList();
      }

      emit(CharacterLoaded(
        filteredCharacters,
        allCharacters: currentState.allCharacters,
        selectedHouse: event.houseName,
      ));
    }
  }

  Future<void> _onSearchCharacter(
      SearchCharacter event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final filteredCharacters = currentState.allCharacters
          .where((char) =>
              char.name.toLowerCase().contains(event.query.toLowerCase()) &&
              (currentState.selectedHouse == 'All' ||
                  (currentState.selectedHouse == 'Unknown' &&
                      char.house.trim().isEmpty) ||
                  char.house.toLowerCase() ==
                      currentState.selectedHouse.toLowerCase()))
          .toList();

      emit(CharacterLoaded(
        filteredCharacters,
        allCharacters: currentState.allCharacters,
        selectedHouse: currentState.selectedHouse,
      ));
    }
  }

  Future<void> _onSelectHouse(
      SelectHouse event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final selectedHouse = event.house;

      if (selectedHouse == 'All') {
        emit(CharacterLoaded(
          currentState.allCharacters,
          allCharacters: currentState.allCharacters,
          selectedHouse: 'All',
        ));
      } else if (selectedHouse == 'Unknown') {
        final filteredCharacters = currentState.allCharacters
            .where((char) => char.house.trim().isEmpty)
            .toList();

        emit(CharacterLoaded(
          filteredCharacters,
          allCharacters: currentState.allCharacters,
          selectedHouse: 'Unknown',
        ));
      } else {
        final filteredCharacters = currentState.allCharacters
            .where((char) =>
                char.house.toLowerCase() == selectedHouse.toLowerCase())
            .toList();

        emit(CharacterLoaded(
          filteredCharacters,
          allCharacters: currentState.allCharacters,
          selectedHouse: selectedHouse,
        ));
      }
    }
  }
}
