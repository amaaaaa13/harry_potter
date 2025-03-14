class ApiConstants {
  static const String baseUrl = 'https://hp-api.onrender.com/api';

  // Endpoints
  static const String characters = '$baseUrl/characters';
  static const String students = '$baseUrl/characters/students';
  static const String staff = '$baseUrl/characters/staff';
  static const String spells = '$baseUrl/spells';
  static String charactersByHouse(String houseName) =>
      '$baseUrl/characters/house/$houseName';
  static String characterById(String id) => '$baseUrl/character/$id';
}
