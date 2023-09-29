import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/model/episodes_model.dart';
import '../global.dart';

class EpisodesRepository {
  final Dio _dio = Dio();
  late List<dynamic> episodesList;

  // Get all data per page (episodes)
  Future<List<EpisodesData>> fetchData({int page = 1}) async {
    try {
      final response =
          await _dio.get('$apiUrl/episode/', queryParameters: {'page': page});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        episodesList = responseData['results'];
        final List<EpisodesData> episodes =
            episodesList.map((json) => EpisodesData.fromJson(json)).toList();

        return episodes;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Get data of episodes by ID
  Future<EpisodesData> fetchEpisodeById(episodeID) async {
    try {
      final response = await _dio.get('$apiUrl/episode/$episodeID');

      if (response.statusCode == 200) {
        final Map<String, dynamic> episodeData = response.data;
        final EpisodesData episode = EpisodesData.fromJson(episodeData);
        return episode;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }
}
