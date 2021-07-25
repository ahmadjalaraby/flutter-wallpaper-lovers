class Urls {
  late String _raw;
  late String _full;
  late String _regular;
  late String _small;
  late String _thumb;

  Urls({
    required String raw,
    required String full,
    required String regular,
    required String small,
    required String thumb,
  }) {
    this._raw = raw;
    this._full = full;
    this._regular = regular;
    this._small = small;
    this._thumb = thumb;
  }

  String get raw => _raw;
  set raw(String raw) => _raw = raw;
  String get full => _full;
  set full(String full) => _full = full;
  String get regular => _regular;
  set regular(String regular) => _regular = regular;
  String get small => _small;
  set small(String small) => _small = small;
  String get thumb => _thumb;
  set thumb(String thumb) => _thumb = thumb;

  Urls.fromJson(Map<String, dynamic> json) {
    _raw = json['raw'];
    _full = json['full'];
    _regular = json['regular'];
    _small = json['small'];
    _thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this._raw;
    data['full'] = this._full;
    data['regular'] = this._regular;
    data['small'] = this._small;
    data['thumb'] = this._thumb;
    return data;
  }
}
