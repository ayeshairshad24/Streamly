/// Student Note:
/// `Episodes` models an episode of a season.
/// I use this for episode lists and for showing metadata on the episode detail screen (air date, overview, etc.).
class Episodes {
  Episodes({
    String? airDate,
    num? episodeNumber,
    num? id,
    String? name,
    String? overview,
    String? productionCode,
    num? runtime,
    num? seasonNumber,
    num? showId,
    String? stillPath,
    num? voteAverage,
    num? voteCount,
  }) {
    _airDate = airDate;
    _episodeNumber = episodeNumber;
    _id = id;
    _name = name;
    _overview = overview;
    _productionCode = productionCode;
    _runtime = runtime;
    _seasonNumber = seasonNumber;
    _showId = showId;
    _stillPath = stillPath;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  Episodes.fromJson(dynamic json) {
    _airDate = json['air_date'];
    _episodeNumber = json['episode_number'];
    _id = json['id'];
    _name = json['name'];
    _overview = json['overview'];
    _productionCode = json['production_code'];
    _runtime = json['runtime'];
    _seasonNumber = json['season_number'];
    _showId = json['show_id'];
    _stillPath = json['still_path'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }
  String? _airDate;
  num? _episodeNumber;
  num? _id;
  String? _name;
  String? _overview;
  String? _productionCode;
  num? _runtime;
  num? _seasonNumber;
  num? _showId;
  String? _stillPath;
  num? _voteAverage;
  num? _voteCount;

  Episodes copyWith({
    String? airDate,
    num? episodeNumber,
    num? id,
    String? name,
    String? overview,
    String? productionCode,
    num? runtime,
    num? seasonNumber,
    num? showId,
    String? stillPath,
    num? voteAverage,
    num? voteCount,
  }) =>
      Episodes(
        airDate: airDate ?? _airDate,
        episodeNumber: episodeNumber ?? _episodeNumber,
        id: id ?? _id,
        name: name ?? _name,
        overview: overview ?? _overview,
        productionCode: productionCode ?? _productionCode,
        runtime: runtime ?? _runtime,
        seasonNumber: seasonNumber ?? _seasonNumber,
        showId: showId ?? _showId,
        stillPath: stillPath ?? _stillPath,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
      );
  String? get airDate => _airDate;
  num? get episodeNumber => _episodeNumber;
  num? get id => _id;
  String? get name => _name;
  String? get overview => _overview;
  String? get productionCode => _productionCode;
  num? get runtime => _runtime;
  num? get seasonNumber => _seasonNumber;
  num? get showId => _showId;
  String? get stillPath => _stillPath;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['air_date'] = _airDate;
    map['episode_number'] = _episodeNumber;
    map['id'] = _id;
    map['name'] = _name;
    map['overview'] = _overview;
    map['production_code'] = _productionCode;
    map['runtime'] = _runtime;
    map['season_number'] = _seasonNumber;
    map['show_id'] = _showId;
    map['still_path'] = _stillPath;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;

    return map;
  }
}
