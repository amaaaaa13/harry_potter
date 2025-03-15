import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class HomeScreenEvent {}

class StartFadeInAnimation extends HomeScreenEvent {}

class StartAnimation extends HomeScreenEvent {}

// BLoC
class HomeScreenBloc extends Bloc<HomeScreenEvent, double> {
  HomeScreenBloc() : super(0.0) {
    on<StartFadeInAnimation>((event, emit) async {
      await Future.delayed(Duration(milliseconds: 300)); // Smooth delay
      emit(1.0); // Fades in UI
    });

    on<StartAnimation>((event, emit) {
      emit(1.0);
    });
  }
}
