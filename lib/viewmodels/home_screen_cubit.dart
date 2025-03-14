import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<double> {
  HomeScreenCubit() : super(0.0); // Initially set opacity to 0.0

  void startAnimation() {
    emit(1.0); // Change opacity to 1.0 for fade-in effect
  }
}
