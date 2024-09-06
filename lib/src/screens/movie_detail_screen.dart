import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_detail_model.dart';
import 'package:flutter_movie/src/services/api_service.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder(
        future: MovieApiService.getMovieDetails(movieId),
        builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading movie details'));
          } else if (snapshot.hasData) {
            final movieDetail = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500/${movieDetail.posterPath}',
                    height: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movieDetail.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Release Date: ${movieDetail.releaseDate}'),
                  const SizedBox(height: 8),
                  Text('Runtime: ${movieDetail.runtime} mins'),
                  const SizedBox(height: 8),
                  Text(movieDetail.overview),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
