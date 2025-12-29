/// Student Note:
/// `MovieDetail` models the detailed response from TMDB's /movie/{id} endpoint.
/// I use this to populate the detail screen: title, overview, runtime, genres,
/// production info and images.
///
/// Important fields: `title`, `overview`, `posterPath`, `backdropPath`,
/// `runtime`, `genres`, `releaseDate`, `voteAverage`.
///
/// Everything is nullable because the TMDB API sometimes omits fields;
/// the UI must provide sensible fallbacks (e.g., "Unknown runtime").
class MovieDetail {
  MovieDetail({
    bool? adult,
    String? backdropPath,
    num? budget,
    List<Genres>? genres,
    String? homepage,
    num? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    num? popularity,
    String? posterPath,
    String? releaseDate,
    num? revenue,
    num? runtime,
    String? status,
    String? tagline,
    String? title,
    num? voteAverage,
    num? voteCount,
  }) {
    _adult = adult;
    _backdropPath = backdropPath;
    _budget = budget;
    _genres = genres;
    _homepage = homepage;
    _id = id;
    _imdbId = imdbId;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _revenue = revenue;
    _runtime = runtime;
    _status = status;
    _tagline = tagline;
    _title = title;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  /// Student Note:
  /// Parse JSON into a `MovieDetail`.
  /// Arrays are converted to typed lists when present.
  MovieDetail.fromJson(dynamic json) {
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _budget = json['budget'];
    if (json['genres'] != null) {
      _genres = [];
      json['genres'].forEach((v) {
        _genres?.add(Genres.fromJson(v));
      });
    }
    _homepage = json['homepage'];
    _id = json['id'];
    _imdbId = json['imdb_id'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _popularity = json['popularity'];
    _posterPath = json['poster_path'];
    _releaseDate = json['release_date'];
    _revenue = json['revenue'];
    _runtime = json['runtime'];
    _status = json['status'];
    _tagline = json['tagline'];
    _title = json['title'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }
  bool? _adult;
  String? _backdropPath;
  num? _budget;
  List<Genres>? _genres;
  String? _homepage;
  num? _id;
  String? _imdbId;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  num? _popularity;
  String? _posterPath;
  String? _releaseDate;
  num? _revenue;
  num? _runtime;
  String? _status;
  String? _tagline;
  String? _title;
  num? _voteAverage;
  num? _voteCount;
  MovieDetail copyWith({
    bool? adult,
    String? backdropPath,
    num? budget,
    List<Genres>? genres,
    String? homepage,
    num? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    num? popularity,
    String? posterPath,
    String? releaseDate,
    num? revenue,
    num? runtime,
    String? status,
    String? tagline,
    String? title,
    num? voteAverage,
    num? voteCount,
  }) =>
      MovieDetail(
        adult: adult ?? _adult,
        backdropPath: backdropPath ?? _backdropPath,
        budget: budget ?? _budget,
        genres: genres ?? _genres,
        homepage: homepage ?? _homepage,
        id: id ?? _id,
        imdbId: imdbId ?? _imdbId,
        originalLanguage: originalLanguage ?? _originalLanguage,
        originalTitle: originalTitle ?? _originalTitle,
        overview: overview ?? _overview,
        popularity: popularity ?? _popularity,
        posterPath: posterPath ?? _posterPath,
        releaseDate: releaseDate ?? _releaseDate,
        revenue: revenue ?? _revenue,
        runtime: runtime ?? _runtime,
        status: status ?? _status,
        tagline: tagline ?? _tagline,
        title: title ?? _title,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
      );
  bool? get adult => _adult;
  String? get backdropPath => _backdropPath;
  num? get budget => _budget;
  List<Genres>? get genres => _genres;
  String? get homepage => _homepage;
  num? get id => _id;
  String? get imdbId => _imdbId;
  String? get originalLanguage => _originalLanguage;
  String? get originalTitle => _originalTitle;
  String? get overview => _overview;
  num? get popularity => _popularity;
  String? get posterPath => _posterPath;
  String? get releaseDate => _releaseDate;
  num? get revenue => _revenue;
  num? get runtime => _runtime;
  String? get status => _status;
  String? get tagline => _tagline;
  String? get title => _title;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = _adult;
    map['backdrop_path'] = _backdropPath;
    map['budget'] = _budget;
    if (_genres != null) {
      map['genres'] = _genres?.map((v) => v.toJson()).toList();
    }
    map['homepage'] = _homepage;
    map['id'] = _id;
    map['imdb_id'] = _imdbId;
    map['original_language'] = _originalLanguage;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['popularity'] = _popularity;
    map['poster_path'] = _posterPath;
    map['release_date'] = _releaseDate;
    map['revenue'] = _revenue;
    map['runtime'] = _runtime;
    map['status'] = _status;
    map['tagline'] = _tagline;
    map['title'] = _title;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }
}

/// id : 12
/// name : "Adventure"

/// Student Note:
/// `Genres` stores a genre id and name.
class Genres {
  Genres({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Genres.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  Genres copyWith({
    num? id,
    String? name,
  }) =>
      Genres(
        id: id ?? _id,
        name: name ?? _name,
      );
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
