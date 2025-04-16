// ignore_for_file: avoid_print

import 'package:netflix/Common/utils.dart';
import 'package:netflix/Model/movie_detail_model.dart';
import 'package:netflix/Model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/Model/movie_recommendation_model.dart';
import 'package:netflix/Model/popular_movies_model.dart';
import 'package:netflix/Model/search_model.dart';
import 'package:netflix/Model/tmdb_trending.dart';
import 'package:netflix/Model/top_rated_movies_model.dart';
import 'package:netflix/Model/trending_movie.dart';
import 'package:netflix/Model/upcoming_movie.model.dart';

var key = "?api_key=$apiKey";

class ApiServices {
  // xem phim
  Future<Movie?> fetchMovie() async {
    try {
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // up phim
  Future<UpcomingMovies?> upcomingMovies() async {
    try {
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return upcomingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  //  xu huong phim
  Future<TrendingMovies?> trendingMovies() async {
    try {
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return trendingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  //ban xep hang
  Future<TopRatedMovies?> topRatedMovies() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return topRatedMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  //xem thuong xuyen
  Future<PopularMovies?> popularMovies() async {
    try {
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return popularMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // chi tiet phim
  Future<MovieDetail?> movieDetail(int movieId) async {
    try {
      final endPoint = "movie/$movieId";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieDetailFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // de xuat phim
  Future<MovieRecommendations?> movieRecommendation(int movieId) async {
    try {
      final endPoint = "movie/$movieId/recommendations";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieRecommendationsFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // tim kiem phim
  Future<SearchMovies?> searchMovies(String query) async {
    try {
      final endPoint = "search/movie?query=${Uri.encodeComponent(query)}";
      final apiUrl = "$baseUrl$endPoint";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGY2M2JlYzg5NjZmZDJmODJiMjU1ODMyZDYwOTFhMyIsIm5iZiI6MTY4MzcwOTI3NS41MjQsInN1YiI6IjY0NWI1ZDViM2ZlMTYwMDBlMzI5OGMzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yHwEUfO4qGSjHuTk0zNGQQRxpY0N-jJVqGosmJjoFwY", // bỏ dấu nháy đơn
          "accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return searchMoviesFromJson(response.body);
      } else {
        print("Failed to load movie. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  // hot trend
    Future<TmdbTrending?> tmdbTrending() async {
    try {
      const endPoint = "trending/all/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return tmdbTrendingFromJson(response.body);
      } else {
        throw Exception("Failed to load movie");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
