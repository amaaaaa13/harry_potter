import 'package:flutter/material.dart';

Color getHouseColor(String house) {
  switch (house) {
    case 'Gryffindor':
      return Colors.redAccent;
    case 'Slytherin':
      return Colors.greenAccent;
    case 'Ravenclaw':
      return Colors.blueAccent;
    case 'Hufflepuff':
      return Colors.yellowAccent;
    default:
      return Colors.white;
  }
}
