import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Model/search_model.dart';
import 'package:netflix/Model/trending_movie.dart';
import 'package:netflix/Screen/movie_detailed_screen.dart';
import 'package:netflix/Services/api_services.dart';

import '../Common/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<TrendingMovies?> trendingMovies;
  SearchMovies? searchMovies;
  late Future<SearchMovies?> searchMoviesFuture;
  void search(String query) async {
    apiServices.searchMovies(query).then((result) {
      setState(() {
        searchMovies = result;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    trendingMovies = apiServices.trendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchController,
              padding: const EdgeInsets.all(10),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              backgroundColor: Colors.grey.withOpacity(0.3),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  search(value); // gọi search khi có từ khóa
                } else {
                  setState(() {
                    searchMovies = null;
                  });
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            searchController.text.isEmpty
                ? FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Top Search",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: movie?.length,
                              itemBuilder: (context, index) {
                                final topMovie = movie?[index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailedScreen(
                                                      movieId:
                                                          topMovie?.id ?? 0,
                                                      title: topMovie?.title ??
                                                          "No Title",
                                                      imageUrl:
                                                          "$imageUrl${topMovie?.backdropPath}",
                                                      isMovie: true),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${topMovie?.backdropPath}",
                                                fit: BoxFit.contain,
                                                width: 150,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  topMovie?.title ?? "No Title",
                                                  // fix lỗi title null
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const Positioned(
                                    //   child: Icon(
                                    //     Icons.play_circle_outline,
                                    //     color: Colors.white,
                                    //     size: 27,
                                    //   ),
                                    // )
                                  ],
                                );
                                
                              },
                            ),
                          ],
                        );
                      }
                      return const Text("Something Went Wrong!");
                    },
                  )
                : searchMovies == null
                    ? const SizedBox()
                    : searchMovies == null
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchMovies?.results.length,
                            itemBuilder: (context, index) {
                              final search = searchMovies?.results[index];
                              return search?.backdropPath == null
                                  ? const SizedBox()
                                  : Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailedScreen(
                                                          movieId:
                                                              search?.id ?? 0,
                                                          title:
                                                              search?.title ??
                                                                  "No Title",
                                                          imageUrl:
                                                              "$imageUrl${search?.backdropPath}",
                                                          isMovie: true),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        "$imageUrl${search?.backdropPath}",
                                                    fit: BoxFit.contain,
                                                    width: 150,
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      search?.title ??
                                                          "No Title",
                                                      // fix lỗi title null
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // const Positioned(

                                        //   child: Icon(

                                        //     Icons.play_circle_outline,
                                        //     color: Colors.white,
                                        //     size: 27,
                                        //   ),
                                        // )
                                      ],
                                    );
                            },
                          ),
          ],
        ),
      ),
    );
  }
}
