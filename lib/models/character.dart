import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String species;
  final String gender;
  final String house;
  final String? dateOfBirth;
  final String? yearOfBirth;
  final bool wizard;
  final String ancestry;
  final String eyeColour;
  final String hairColour;
  final Wand? wand;
  final String patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String actor;
  final bool alive;
  final String image;

  const Character({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    this.wand, // ✅ Wand can be null
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alive,
    required this.image,
  });

  /// ✅ **Factory constructor to create a Character from JSON**
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      house: json['house']?.trim() ?? '',
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth']?.toString(),
      wizard: json['wizard'] ?? false,
      ancestry: json['ancestry'] ?? 'Unknown',
      eyeColour: json['eyeColour'] ?? 'Unknown',
      hairColour: json['hairColour'] ?? 'Unknown',
      wand: json['wand'] != null && json['wand'] is Map<String, dynamic>
          ? Wand.fromJson(json['wand'])
          : null, // ✅ Fixed Wand parsing
      patronus: json['patronus'] ?? 'None',
      hogwartsStudent: json['hogwartsStudent'] ?? false,
      hogwartsStaff: json['hogwartsStaff'] ?? false,
      actor: json['actor'] ?? 'Unknown',
      alive: json['alive'] ?? true,
      image: json['image'] ?? '',
    );
  }

  /// ✅ **Convert Character to JSON for storage**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'gender': gender,
      'house': house,
      'dateOfBirth': dateOfBirth,
      'yearOfBirth': yearOfBirth,
      'wizard': wizard,
      'ancestry': ancestry,
      'eyeColour': eyeColour,
      'hairColour': hairColour,
      'wand': wand?.toJson(), // ✅ Convert Wand to JSON if not null
      'patronus': patronus,
      'hogwartsStudent': hogwartsStudent,
      'hogwartsStaff': hogwartsStaff,
      'actor': actor,
      'alive': alive,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        species,
        gender,
        house,
        dateOfBirth,
        yearOfBirth,
        wizard,
        ancestry,
        eyeColour,
        hairColour,
        wand,
        patronus,
        hogwartsStudent,
        hogwartsStaff,
        actor,
        alive,
        image,
      ];
}

class Wand extends Equatable {
  final String wood;
  final String core;
  final double? length;

  const Wand({
    required this.wood,
    required this.core,
    this.length,
  });

  /// ✅ **Factory constructor to create a Wand from JSON**
  factory Wand.fromJson(Map<String, dynamic> json) {
    return Wand(
      wood: json['wood'] ?? 'Unknown',
      core: json['core'] ?? 'Unknown',
      length: json['length'] != null
          ? (json['length'] as num).toDouble()
          : null, // ✅ Fixed Wand length handling
    );
  }

  /// ✅ **Convert Wand to JSON for storage**
  Map<String, dynamic> toJson() {
    return {
      'wood': wood,
      'core': core,
      'length': length,
    };
  }

  @override
  List<Object?> get props => [wood, core, length];
}
