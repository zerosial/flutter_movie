import 'package:flutter_movie/src/models/movie_model.dart';

class MovieDetailModel extends MovieModel {
  final int budget;
  final List<String> genres;
  final String homepage;
  final int runtime;

  MovieDetailModel({
    required super.title,
    required super.posterPath,
    required super.backdropPath,
    required super.overview,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.id,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.runtime,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      id: json['id'] ?? 0,
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      homepage: json['homepage'] ?? '',
      runtime: json['runtime'] ?? 0,
    );
  }
}
