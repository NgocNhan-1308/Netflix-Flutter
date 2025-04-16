// To parse this JSON data, do
//
//     final tmdbTrending = tmdbTrendingFromJson(jsonString);

import 'dart:convert';

TmdbTrending tmdbTrendingFromJson(String str) => TmdbTrending.fromJson(json.decode(str));

String tmdbTrendingToJson(TmdbTrending data) => json.encode(data.toJson());

class TmdbTrending {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TmdbTrending({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbTrending.fromJson(Map<String, dynamic> json) => TmdbTrending(
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
  String backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  bool adult;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  bool? video;
  double voteAverage;
  int voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<OriginCountry>? originCountry;

  Result({
    required this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"] ?? '',
        posterPath: json["poster_path"] ?? '',
        mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
        adult: json["adult"] ?? false,
        originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.EN,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: (json["popularity"] ?? 0).toDouble(),
        releaseDate: json["release_date"] != null && json["release_date"] != ""
            ? DateTime.tryParse(json["release_date"])
            : null,
        video: json["video"],
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
        name: json["name"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"] != null && json["first_air_date"] != ""
            ? DateTime.tryParse(json["first_air_date"])
            : null,
        originCountry: json["origin_country"] == null
            ? []
            : List<OriginCountry>.from(json["origin_country"].map(
                (x) => originCountryValues.map[x] ?? OriginCountry.US,
              )),
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
        "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate != null
            ? "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}"
            : null,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => originCountryValues.reverse[x])),
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV,
});

enum OriginCountry { JP, US, KR }

final originCountryValues = EnumValues({
  "JP": OriginCountry.JP,
  "US": OriginCountry.US,
  "KR": OriginCountry.KR, // thêm nếu cần
});

enum OriginalLanguage { CN, EN, JA }

final originalLanguageValues = EnumValues({
  "cn": OriginalLanguage.CN,
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA,
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
