// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

class HouseFilterCubit extends Cubit<String?> {
  HouseFilterCubit() : super(null); // Initial state is null

  // Method to change the selected house
  void selectHouse(String house) {
    emit(house); // Update state to the selected house
  }
}
