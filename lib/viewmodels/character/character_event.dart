import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

// Fetch Data Events
class FetchAllCharacters extends CharacterEvent {
  const FetchAllCharacters();
}

class FetchStudents extends CharacterEvent {
  const FetchStudents();
}

class FetchStaff extends CharacterEvent {
  const FetchStaff();
}

// Fetch Single Character by ID
class FetchCharacterDetails extends CharacterEvent {
  final String characterId;

  const FetchCharacterDetails(this.characterId);

  @override
  List<Object> get props => [characterId];
}

// Filtering Events
class FilterCharactersByHouse extends CharacterEvent {
  final String houseName;

  const FilterCharactersByHouse(this.houseName);

  @override
  List<Object> get props => [houseName];
}

// Search Event
class SearchCharacter extends CharacterEvent {
  final String query;

  const SearchCharacter(this.query);

  @override
  List<Object> get props => [query];
}

// House Selection Event (For Better BLoC Logic)
class SelectHouse extends CharacterEvent {
  final String house;

  const SelectHouse(this.house);

  @override
  List<Object> get props => [house];
}
