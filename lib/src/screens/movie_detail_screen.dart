import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_detail_model.dart';
import 'package:flutter_movie/src/services/api_service.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  final String heroTag; // MainPage에서 전달된 고유한 Hero 태그

  const MovieDetailPage({
    super.key,
    required this.movieId,
    required this.heroTag,
  });

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
            return Stack(
              children: [
                // 배경 이미지로 backdropPath 사용
                Positioned.fill(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movieDetail.backdropPath}',
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.5), // 어두운 효과
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                // 영화 포스터 및 상세 정보
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 포스터 중앙 정렬
                        Center(
                          child: Hero(
                            tag: heroTag, // MainPage에서 전달된 고유 태그 사용
                            child: Container(
                              width: 200,
                              height: 300,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 15,
                                    offset: const Offset(5, 5),
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.png',
                                image:
                                    'https://image.tmdb.org/t/p/w500/${movieDetail.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 영화 제목
                        Text(
                          movieDetail.title,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // 영화 등급 (voteAverage)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 24,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${movieDetail.voteAverage} / 10',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // 영화 개요
                        Text(
                          movieDetail.overview,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Runtime: ${movieDetail.runtime} mins',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.center,
                          children: movieDetail.genres
                              .take(4)
                              .map((genre) => Chip(
                                    label: Text(
                                      genre,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Colors.blueAccent.withOpacity(0.7),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        // 영화 개봉일 및 상영 시간
                        Text(
                          'Release Date: ${movieDetail.releaseDate}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
