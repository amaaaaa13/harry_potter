import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/core/services/harry_potter_service.dart';
import 'house_event.dart';
import 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final HarryPotterService hpService;

  HouseBloc(this.hpService) : super(HouseInitial()) {
    on<FetchHouseCharacters>(_onFetchHouseCharacters);
    on<SearchHouseCharacters>(_onSearchHouseCharacters); // Add search handler
  }

  Future<void> _onFetchHouseCharacters(
      FetchHouseCharacters event, Emitter<HouseState> emit) async {
    emit(HouseLoading());
    final result = await hpService.getCharactersByHouse(event.houseName);
    result.fold(
      (failure) => emit(HouseError(failure.message)),
      (characters) => emit(HouseLoaded(characters)),
    );
  }

  Future<void> _onSearchHouseCharacters(
      SearchHouseCharacters event, Emitter<HouseState> emit) async {
    emit(HouseLoading()); // Show loading while filtering
    final result = await hpService.getCharactersByHouse(event.houseName);

    result.fold(
      (failure) => emit(HouseError(failure.message)),
      (characters) {
        final filteredCharacters = characters
            .where((character) => character.name
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();

        emit(HouseLoaded(filteredCharacters));
      },
    );
  }
}
