import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../models/character.dart';
import '../../models/spell.dart';
import '../constants/api_constants.dart';
import '../errors/failure.dart';
import '../network/dio_client.dart';

class HarryPotterService {
  final Dio dio = DioClient.dio; // Use singleton Dio instance

  // Fetch all characters
  Future<Either<Failure, List<Character>>> getCharacters() async {
    return _fetchList(
        ApiConstants.characters, (json) => Character.fromJson(json));
  }

  // Fetch character by ID
  Future<Either<Failure, Character>> getCharacterById(String id) async {
    return _fetchSingle(
        ApiConstants.characterById(id), (json) => Character.fromJson(json));
  }

  // Fetch all students
  Future<Either<Failure, List<Character>>> getStudents() async {
    return _fetchList(
        ApiConstants.students, (json) => Character.fromJson(json));
  }

  // Fetch all staff
  Future<Either<Failure, List<Character>>> getStaff() async {
    return _fetchList(ApiConstants.staff, (json) => Character.fromJson(json));
  }

  // Fetch characters by house
  Future<Either<Failure, List<Character>>> getCharactersByHouse(
      String houseName) async {
    return _fetchList(ApiConstants.charactersByHouse(houseName),
        (json) => Character.fromJson(json));
  }

  // Fetch all spells
  Future<Either<Failure, List<Spell>>> getSpells() async {
    return _fetchList(ApiConstants.spells, (json) => Spell.fromJson(json));
  }

  // Generic method for fetching lists
  Future<Either<Failure, List<T>>> _fetchList<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List<T> items =
            (response.data as List).map((json) => fromJson(json)).toList();
        return Right(items);
      }
      return Left(ServerFailure("Error ${response.statusCode}"));
    } catch (e) {
      return Left(_handleDioError(e));
    }
  }

  // Generic method for fetching a single object
  Future<Either<Failure, T>> _fetchSingle<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Right(fromJson(response.data));
      }
      return Left(ServerFailure("Error ${response.statusCode}"));
    } catch (e) {
      return Left(_handleDioError(e));
    }
  }

  // Improved Error Handling
  Failure _handleDioError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkFailure("Connection Timeout");
        case DioExceptionType.badResponse:
          return ServerFailure("Server Error: ${e.response?.statusCode}");
        case DioExceptionType.cancel:
          return NetworkFailure("Request Cancelled");
        default:
          return UnknownFailure("Something went wrong: ${e.message}");
      }
    }
    return UnknownFailure("Unexpected Error: ${e.toString()}");
  }
}
