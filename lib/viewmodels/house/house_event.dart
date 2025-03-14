import 'package:equatable/equatable.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent(); // Added const constructor for consistency

  @override
  List<Object> get props => [];
}

class FetchHouseCharacters extends HouseEvent {
  final String houseName;

  const FetchHouseCharacters(this.houseName); // Added const for optimization

  @override
  List<Object> get props => [houseName];
}

class SearchHouseCharacters extends HouseEvent {
  final String query;
  final String houseName; // Includes house filter for search

  const SearchHouseCharacters(this.query, this.houseName); // Added const

  @override
  List<Object> get props => [query, houseName];
}
