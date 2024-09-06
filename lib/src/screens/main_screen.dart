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
                _buildMovieSection(context, 'Popular Movies', popularMovies),
                _buildMovieSection(
                    context, 'Now Playing Movies', nowPlayingMovies),
                _buildMovieSection(
                    context, 'Coming Soon Movies', comingSoonMovies),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMovieSection(
      BuildContext context, String sectionTitle, List<MovieModel> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sectionTitle,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  // 영화 클릭 시 세부 정보 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(movieId: movie.id),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w200/${movie.posterPath}', // 영화 포스터 이미지
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Text(movie.title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
