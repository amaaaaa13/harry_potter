import 'package:equatable/equatable.dart';

class Spell extends Equatable {
  final String name;
  final String description;

  const Spell({
    required this.name,
    required this.description,
  });

  /// ✅ **Factory constructor to create a Spell from JSON**
  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
    );
  }

  /// ✅ **Convert Spell to JSON for storage**
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  /// ✅ **Create a new Spell instance with modified values**
  Spell copyWith({String? name, String? description}) {
    return Spell(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props =>
      [name, description]; // ✅ Ensures proper list comparison
}
