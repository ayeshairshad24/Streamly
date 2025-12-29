import 'package:dio/dio.dart';
import '/Models/episode_detail.dart';
import '/Models/movie_detail.dart';
import '/Models/popular_movies.dart';
import '/Models/search_result.dart';
import '/Models/tv_show.dart';
import '/Models/tv_show_detail.dart';
import '/Models/video_details.dart';
import '/Services/key.dart';

class APIService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKeyParam = 'api_key=$tmdbApiKey';

  /// Fetch popular movies
  Future<List<Results>> getPopularMovie() async {
    final url = '$baseUrl/movie/popular?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// Fetch top rated movies
  Future<List<Results>> getTopRatedMovie() async {
    final url = '$baseUrl/movie/top_rated?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// Fetch now playing movies
  Future<List<Results>> getNowPLayingMovie() async {
    final url = '$baseUrl/movie/now_playing?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// Fetch popular TV shows
  Future<List<TvShow>> getPopularShow() async {
    final url = '$baseUrl/tv/popular?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var shows = response.data['results'] as List;
    return shows.map((m) => TvShow.fromJson(m)).toList();
  }

  /// Fetch top rated TV shows
  Future<List<TvShow>> getTopRatedShow() async {
    final url = '$baseUrl/tv/top_rated?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var shows = response.data['results'] as List;
    return shows.map((m) => TvShow.fromJson(m)).toList();
  }

  /// Search movies & TV shows
  Future<List<SearchResult>> getSearchResult(String searchQuery) async {
    if (searchQuery.isEmpty) return [];

    try {
      final url = '$baseUrl/search/multi?$apiKeyParam&query=$searchQuery';
      final response = await _dio.get(url);
      var results = response.data['results'] as List;
      return results.map((m) => SearchResult.fromJson(m)).toList();
    } catch (_) {
      return [];
    }
  }

  /// Get movie details
  Future<MovieDetail> getMovieDetail(String movieId) async {
    final url = '$baseUrl/movie/$movieId?$apiKeyParam';
    final response = await _dio.get(url);
    return MovieDetail.fromJson(response.data);
  }

  /// Get genres (movie or TV)
  Future<List<Genres>> getMovieGenres(String id, String mediaType) async {
    final url = '$baseUrl/$mediaType/$id?$apiKeyParam';
    final response = await _dio.get(url);
    var genres = response.data['genres'] as List;
    return genres.map((m) => Genres.fromJson(m)).toList();
  }

  /// Similar movies
  Future<List<Results>> getSimilarMovie(String movieId) async {
    final url = '$baseUrl/movie/$movieId/similar?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// Recommended movies
  Future<List<Results>> getRecommendedMovie(String movieId) async {
    final url = '$baseUrl/movie/$movieId/recommendations?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// Get trailer (YouTube)
  Future<String> getTrailerLink(String id, String mediaType) async {
    final url = '$baseUrl/$mediaType/$id/videos?$apiKeyParam';
    final response = await _dio.get(url);
    var results = response.data['results'] as List;

    final videos =
        results.map((m) => VideoResults.fromJson(m)).toList();

    String trailerKey = 'dQw4w9WgXcQ'; // fallback
    for (final v in videos) {
      if (v.site == 'YouTube' && v.type == 'Trailer') {
        trailerKey = v.key.toString();
        break;
      }
    }

    return 'https://www.youtube.com/watch?v=$trailerKey';
  }

  /// TV show details
  Future<TvShowDetail> getTvShowDetail(String showId) async {
    final url = '$baseUrl/tv/$showId?$apiKeyParam';
    final response = await _dio.get(url);
    return TvShowDetail.fromJson(response.data);
  }

  /// Similar TV shows
  Future<List<TvShow>> getSimilarTvShows(String showId) async {
    final url = '$baseUrl/tv/$showId/similar?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var shows = response.data['results'] as List;
    return shows.map((m) => TvShow.fromJson(m)).toList();
  }

  /// Recommended TV shows
  Future<List<TvShow>> getRecommendedTvShows(String showId) async {
    final url = '$baseUrl/tv/$showId/recommendations?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var shows = response.data['results'] as List;
    return shows.map((m) => TvShow.fromJson(m)).toList();
  }

  /// Episodes for a season
  Future<List<Episodes>> getEpisodes(String showId, String seasonNum) async {
    final url =
        '$baseUrl/tv/$showId/season/$seasonNum?$apiKeyParam';
    final response = await _dio.get(url);
    var episodes = response.data['episodes'] as List;
    return episodes.map((m) => Episodes.fromJson(m)).toList();
  }

  /// Upcoming movies
  Future<List<Results>> getLatestMovie() async {
    final url = '$baseUrl/movie/upcoming?$apiKeyParam&page=1';
    final response = await _dio.get(url);
    var movies = response.data['results'] as List;
    return movies.map((m) => Results.fromJson(m)).toList();
  }

  /// On-air TV shows
  Future<List<TvShow>> getOnAirShows() async {
    final url = '$baseUrl/tv/on_the_air?$apiKeyParam';
    final response = await _dio.get(url);
    var shows = response.data['results'] as List;
    return shows.map((m) => TvShow.fromJson(m)).toList();
  }
}
