class Tags {
  late String _title;

  Tags({required String title}) {
    this._title = title;
  }

  String get title => _title;
  set title(String title) => _title = title;

  Tags.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    return data;
  }
}
