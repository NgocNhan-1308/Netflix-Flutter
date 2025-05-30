// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

MovieDetail movieDetailFromJson(String str) => MovieDetail.fromJson(json.decode(str));

String movieDetailToJson(MovieDetail data) => json.encode(data.toJson());

class MovieDetail {
    bool adult;
    String? backdropPath;
    BelongsToCollection? belongsToCollection;
    int budget;
    List<Genre> genres;
    String? homepage;
    int id;
    String? imdbId;
    List<String> originCountry;
    String originalLanguage;
    String originalTitle;
    String? overview;
    double popularity;
    String? posterPath;
    List<ProductionCompany> productionCompanies;
    List<ProductionCountry> productionCountries;
    DateTime releaseDate;
    int revenue;
    int runtime;
    List<SpokenLanguage> spokenLanguages;
    String status;
    String? tagline;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    MovieDetail({
        required this.adult,
        this.backdropPath,
        this.belongsToCollection,
        required this.budget,
        required this.genres,
        this.homepage,
        required this.id,
        this.imdbId,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalTitle,
        this.overview,
        required this.popularity,
        this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.releaseDate,
        required this.revenue,
        required this.runtime,
        required this.spokenLanguages,
        required this.status,
        this.tagline,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] != null
            ? BelongsToCollection.fromJson(json["belongs_to_collection"])
            : null,
        budget: json["budget"] ?? 0,
        genres: (json["genres"] as List<dynamic>?)
            ?.map((x) => Genre.fromJson(x))
            .toList() ?? [],
        homepage: json["homepage"],
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"],
        originCountry: (json["origin_country"] as List<dynamic>?)
            ?.map((x) => x.toString())
            .toList() ?? [],
        originalLanguage: json["original_language"] ?? "",
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"],
        popularity: (json["popularity"] ?? 0.0).toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: (json["production_companies"] as List<dynamic>?)
            ?.map((x) => ProductionCompany.fromJson(x))
            .toList() ?? [],
        productionCountries: (json["production_countries"] as List<dynamic>?)
            ?.map((x) => ProductionCountry.fromJson(x))
            .toList() ?? [],
        releaseDate: json["release_date"] != null
            ? DateTime.parse(json["release_date"])
            : DateTime(2000, 1, 1),
        revenue: json["revenue"] ?? 0,
        runtime: json["runtime"] ?? 0,
        spokenLanguages: (json["spoken_languages"] as List<dynamic>?)
            ?.map((x) => SpokenLanguage.fromJson(x))
            .toList() ?? [],
        status: json["status"] ?? "",
        tagline: json["tagline"],
        title: json["title"] ?? "",
        video: json["video"] ?? false,
        voteAverage: (json["vote_average"] ?? 0.0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection?.toJson(),
        "budget": budget,
        "genres": genres.map((x) => x.toJson()).toList(),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "origin_country": originCountry,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies.map((x) => x.toJson()).toList(),
        "production_countries": productionCountries.map((x) => x.toJson()).toList(),
        "release_date": releaseDate.toIso8601String(),
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spokenLanguages.map((x) => x.toJson()).toList(),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}


class BelongsToCollection {
    int id;
    String name;
    String posterPath;
    String backdropPath;

    BelongsToCollection({
        required this.id,
        required this.name,
        required this.posterPath,
        required this.backdropPath,
    });

    factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
    };
}

class Genre {
    int id;
    String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ProductionCompany {
    int id;
    String? logoPath;
    String name;
    String originCountry;

    ProductionCompany({
        required this.id,
        required this.logoPath,
        required this.name,
        required this.originCountry,
    });

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountry {
    String iso31661;
    String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage {
    String englishName;
    String iso6391;
    String name;

    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
