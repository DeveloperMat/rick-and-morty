import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import '../global.dart';

class CharacterRepository {
  final Dio _dio = Dio();
  late List<dynamic> characterList;

  // Get all data per page (characters)
  Future<List<CharacterResult>> fetchData({int page = 1}) async {
    try {
      final response =
          await _dio.get('$apiUrl/character/', queryParameters: {'page': page});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        characterList = responseData['results'];
        final List<CharacterResult> characters = characterList
            .map((json) => CharacterResult.fromJson(json))
            .toList();

        return characters;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Get all data (characters)
  Future<List<CharacterResult>> fetchAllData() async {
    final List<CharacterResult> allCharacters = [];

    Future<void> fetchPage(int page) async {
      try {
        final response = await _dio
            .get('$apiUrl/character/', queryParameters: {'page': page});

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = response.data;
          final List<dynamic> characterList = responseData['results'];

          final List<CharacterResult> characters = characterList
              .map((json) => CharacterResult.fromJson(json))
              .toList();

          allCharacters.addAll(characters);
          if (responseData['info']['next'] != null) {
            await fetchPage(page + 1);
          }
        } else {
          throw Exception('Failed to load data');
        }
      } catch (error) {
        rethrow;
      }
    }

    await fetchPage(1);

    return allCharacters;
  }

  // Get data of character by ID
  Future<CharacterResult> fetchCharacterById(characterId) async {
    try {
      final response = await _dio.get('$apiUrl/character/$characterId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> characterData = response.data;
        final CharacterResult character =
            CharacterResult.fromJson(characterData);
        return character;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }
}
