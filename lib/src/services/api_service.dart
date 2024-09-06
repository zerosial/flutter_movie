import 'dart:convert';
import 'package:flutter_movie/src/models/movie_detail_model.dart';
import 'package:flutter_movie/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  // 1. 가장 인기 있는 영화 가져오기
  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Exception('Failed to load popular movies');
  }

  // 2. 현재 상영 중인 영화 가져오기
  static Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Exception('Failed to load now playing movies');
  }

  // 3. 곧 개봉할 영화 가져오기
  static Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Exception('Failed to load coming soon movies');
  }

  // 4. 영화 세부 정보 가져오기
  static Future<MovieDetailModel> getMovieDetails(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movieDetail = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movieDetail);
    }
    throw Exception('Failed to load movie details');
  }
}
