import 'package:flutter/material.dart';

import 'package:netflix/Common/utils.dart';
import 'package:netflix/Model/movie_detail_model.dart';
import 'package:netflix/Model/movie_model.dart';
import 'package:netflix/Model/popular_movies_model.dart';
import 'package:netflix/Model/top_rated_movies_model.dart';
import 'package:netflix/Model/trending_movie.dart';
import 'package:netflix/Model/upcoming_movie.model.dart';
import 'package:netflix/Screen/movie_detailed_screen.dart';
import 'package:netflix/Screen/search_screen.dart';
import 'package:netflix/Services/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({super.key});

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiServices apiServices = ApiServices();
  late Future<Movie?> movieData;
  late Future<UpcomingMovies?> upcomingMovies;
  late Future<TrendingMovies?> trendingMovies;
  late Future<PopularMovies?> popularMovies;
  late Future<TopRatedMovies?> topRatedMovies;
  late Future<MovieDetail?> movieDetail;
  @override
  void initState() {
    super.initState();
    movieData = ApiServices().fetchMovie();
    upcomingMovies = ApiServices().upcomingMovies();
    trendingMovies = ApiServices().trendingMovies();
    popularMovies = ApiServices().popularMovies();
    topRatedMovies = ApiServices().topRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 50,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  const Icon(
                    Icons.download_sharp,
                    size: 27,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.cast,
                    size: 27,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        700,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white38),
                    ),
                    child: const Text(
                      "TV Shows",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        300,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white38),
                    ),
                    child: const Text(
                      "Movies",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white38),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 530,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: FutureBuilder(
                        future: movieData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            final movies = snapshot.data!.results;
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: PageView.builder(
                                itemCount: movies.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetailedScreen(
                                              movieId: movie.id,
                                              title: movie.title,
                                              imageUrl:
                                                  "$imageUrl${movie.posterPath}",
                                              isMovie: true),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 530,
                                      width: 388,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "$imageUrl${movie.posterPath}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("problem to fetch data"),
                            );
                          }
                        }),
                  ),
                  //ngay day nay nhan oi :))) nay vay la ok roi ne

                  Positioned(
                    bottom: -40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  "My List",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            moviesTypes(
              future: trendingMovies,
              movieType: "Trending Movies on Netflix",
            ),
            moviesTypes(
              future: upcomingMovies,
              movieType: "Upcoming Movies",
              isReverse: true,
            ),
            moviesTypes(
              future: popularMovies,
              movieType: "Popular Movies",
            ),
            moviesTypes(
              future: topRatedMovies,
              movieType: "Top Rated Movies",
            ),
          ],
        ),
      ),
    );
  }

  Padding moviesTypes(
      {required Future future,
      required String movieType,
      bool isReverse = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieType,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final movies = snapshot.data!.results;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListView.builder(
                        reverse: isReverse,
                        itemCount: movies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailedScreen(
                                        movieId: movie.id,
                                        title: movie.displayTitle  ?? "Unknown Title",
                                        imageUrl:
                                            "$imageUrl${movie.posterPath}",
                                        isMovie: true),
                                  ),
                                );
                              },
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "$imageUrl${movie.posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("problem to fetch data"),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
