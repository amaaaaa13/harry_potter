import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/core/services/harry_potter_service.dart';
import 'spell_event.dart';
import 'spell_state.dart';

class SpellBloc extends Bloc<SpellEvent, SpellState> {
  final HarryPotterService hpService;

  SpellBloc(this.hpService) : super(SpellInitial()) {
    on<FetchSpells>(_onFetchSpells);
  }

  Future<void> _onFetchSpells(
      FetchSpells event, Emitter<SpellState> emit) async {
    emit(SpellLoading());
    final result = await hpService.getSpells();
    result.fold(
      (failure) => emit(SpellError(failure.message)),
      (spells) => emit(SpellLoaded(spells)),
    );
  }
}
