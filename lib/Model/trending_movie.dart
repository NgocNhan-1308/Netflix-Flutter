// To parse this JSON data, do
//
//     final trendingMovies = trendingMoviesFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

TrendingMovies trendingMoviesFromJson(String str) => TrendingMovies.fromJson(json.decode(str));

String trendingMoviesToJson(TrendingMovies data) => json.encode(data.toJson());

class TrendingMovies {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TrendingMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingMovies.fromJson(Map<String, dynamic> json) => TrendingMovies(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  String? backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  bool adult;
  OriginalLanguage? originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    required this.adult,
    this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: mediaTypeValues.map[json["media_type"]],
        adult: json["adult"] ?? false,
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 0,
        releaseDate: json["release_date"] != null && json["release_date"] != ""
            ? DateTime.tryParse(json["release_date"])
            : null,
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "adult": adult,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate?.toIso8601String(),
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
});

enum OriginalLanguage { EN, FR, ID, LV }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "fr": OriginalLanguage.FR,
  "id": OriginalLanguage.ID,
  "lv": OriginalLanguage.LV,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}