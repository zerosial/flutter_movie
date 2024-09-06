import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_model.dart';
import 'package:flutter_movie/src/screens/movie_detail_screen.dart';
import 'package:flutter_movie/src/services/api_service.dart';
import 'package:flutter_movie/src/settings/settings_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([
          MovieApiService.getPopularMovies(),
          MovieApiService.getNowPlayingMovies(),
          MovieApiService.getComingSoonMovies(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading movies'));
          } else if (snapshot.hasData) {
            final popularMovies = snapshot.data![0] as List<MovieModel>;
            final nowPlayingMovies = snapshot.data![1] as List<MovieModel>;
            final comingSoonMovies = snapshot.data![2] as List<MovieModel>;

            return ListView(
              children: [
                _buildMovieSection(
                    context, 'Popular Movies', popularMovies, 'popular'),
                _buildMovieSection(context, 'Now Playing Movies',
                    nowPlayingMovies, 'now_playing'),
                _buildMovieSection(context, 'Coming Soon Movies',
                    comingSoonMovies, 'coming_soon'),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMovieSection(BuildContext context, String sectionTitle,
      List<MovieModel> movies, String sectionTag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        movieId: movie.id,
                        heroTag: '$sectionTag-movie-${movie.id}', // 고유 태그
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: '$sectionTag-movie-${movie.id}', // 고유 태그 설정
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/images/placeholder.png', // 이미지 로딩 전 보여줄 플레이스홀더
                    image:
                        'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
