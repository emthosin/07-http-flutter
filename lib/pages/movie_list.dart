//MI2F_14_M. Thosin Yuhaililul Hilmi_2031710032

import 'package:flutter/material.dart';
import 'package:http_request/service/http_service.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  bool _isLoading = true;

  Future initialize() async {
    movies = [];
    movies = (await service.getPopularMovies())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "Popular Movies | 2031710032 - M. Thosin Yuhaililul Hilmi"),
        ),
        backgroundColor: Color.fromARGB(255, 53, 69, 77),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: (moviesCount == null) ? 0 : moviesCount,
                itemBuilder: (context, int position) {
                  return Card(
                    color: Color.fromARGB(255, 80, 94, 102),
                    elevation: 2.0,
                    child: ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500/" +
                                movies[position].posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          movies[position].title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        subtitle: Text(
                          'Rating = ' + movies[position].voteAverage.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (_) => MovieDetail(movies[position]));
                          Navigator.push(context, route);
                        }),
                  );
                },
              ));
  }
}
