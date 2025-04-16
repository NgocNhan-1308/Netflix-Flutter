

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix/Common/utils.dart';
import 'package:netflix/Model/tmdb_trending.dart';
import 'package:netflix/Screen/movie_detailed_screen.dart';
import 'package:netflix/Services/api_services.dart';

class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  final ApiServices apiServices = ApiServices();
  late Future<TmdbTrending?> tmbdTrendingAPI;
  @override
  void initState() {
    tmbdTrendingAPI = apiServices.tmdbTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getShortName(String name) {
      if (name.length > 3) {
        return name.substring(0, 3) + "...";
      } else {
        return name;
      }
    }

    String formatDate(String apiDate) {
      DateTime parseDate = DateTime.parse(apiDate);
      return DateFormat("MMMM").format(parseDate); // Format the date to "MMM"
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Hot News",
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: tmbdTrendingAPI,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!.results;
            return ListView.builder(
              itemCount: movies.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final movie = movies[index];
                String firstAirDate = movie.firstAirDate?.day.toString() ?? "";
                String releaseDay = movie.releaseDate?.day.toString() ?? "";
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailedScreen(
                              movieId: movie.id,
                              title: movie.title ?? 'Unknown Title',
                              imageUrl: "$imageUrl${movie.posterPath}",
                              isMovie: true),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                movie.releaseDate == null
                                    ? firstAirDate
                                    : releaseDay,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                movie.releaseDate == null
                                    ? getShortName(formatDate(
                                        movie.firstAirDate?.toString() ?? ""))
                                    : getShortName(formatDate(
                                        movie.releaseDate?.toString() ?? "")),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        "$imageUrl${movie.backdropPath}"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Coming on ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.5),
                                      )),
                                  Text(
                                    movie.releaseDate == null
                                        ? firstAirDate
                                        : releaseDay,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    movie.releaseDate == null
                                        ? getShortName(formatDate(
                                            movie.firstAirDate?.toString() ??
                                                ""))
                                        : getShortName(formatDate(
                                            movie.releaseDate?.toString() ??
                                                "")),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.notifications_off_outlined,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                movie.overview,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("problem to fetch data"),
            );
          }
        },
      ),
    );
  }
}
