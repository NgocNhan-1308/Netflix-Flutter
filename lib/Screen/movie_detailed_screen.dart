import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Common/utils.dart';
import 'package:netflix/Model/movie_detail_model.dart';
import 'package:netflix/Model/movie_recommendation_model.dart';
import 'package:netflix/Services/api_services.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailedScreen({super.key, required this.movieId, required String title, required String imageUrl, required bool isMovie});
  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetail?> movieDetail;
  late Future<MovieRecommendations?> movieRecommendations;

  @override
  void initState() {
    fetchMovieData();
    super.initState();
  }

  fetchMovieData() {
    movieDetail = apiServices.movieDetail(widget.movieId);
    movieRecommendations = apiServices.movieRecommendation(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String formatRuntime(int runtime) {
      int hours = runtime ~/ 60;
      int minutes = runtime % 60;
      return "${hours}h ${minutes}m";
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data!;
              String generesText =
                  movie.genres.map((genre) => genre.name).join(", ");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "$imageUrl${movie.posterPath}"),
                            //nay lam toi day ne nhan oi :))
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 50,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.black45,
                              child: Icon(
                                Icons.cast,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Positioned(
                          top: 100,
                          bottom: 100,
                          right: 100,
                          left: 100,
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 50,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "assets/netflix.png",
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              formatRuntime(movie.runtime),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "HD",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white60),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                            Text(
                              "Play",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.download,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    generesText,
                    style: const TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movie.overview ?? "No overview available",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(children: [
                        Icon(
                          Icons.add,
                          size: 45,
                          color: Colors.white,
                        ),
                        Text(
                          "My List",
                          style: TextStyle(color: Colors.white, height: 0.3),
                        )
                      ]),
                      Column(children: [
                        Icon(
                          Icons.thumb_up,
                          size: 45,
                          color: Colors.white,
                        ),
                        Text(
                          "Rate",
                          style: TextStyle(color: Colors.white, height: 0.3),
                        )
                      ]),
                      Column(children: [
                        Icon(
                          Icons.share,
                          size: 45,
                          color: Colors.white,
                        ),
                        Text(
                          "My List",
                          style: TextStyle(color: Colors.white, height: 0.3),
                        )
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: movieRecommendations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data;
                        return movie!.results.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "More Like This",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: movie.results.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MovieDetailedScreen(
                                                              movieId: movie
                                                                      .results[
                                                                  index]
                                                                  .id,
                                                              title: movie
                                                                      .results[
                                                                  index]
                                                                  .title,
                                                              imageUrl:
                                                                  "$imageUrl${movie.results[index].posterPath}",
                                                              isMovie: true)));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${movie.results[index].posterPath}",
                                                height: 200,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      }
                      return const Text("Something Went Wrong!");
                    },
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
