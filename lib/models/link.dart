class Links {
  late String self;
  late String html;
  late String download;
  late String photos;
  late String likes;
  late String portfolio;

  Links({
    required this.self,
    required this.html,
    required this.download,
    required this.photos,
    required this.likes,
    required this.portfolio,
  });

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    download = json['download'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['download'] = this.html;
    data['photos'] = this.photos;
    data['likes'] = this.likes;
    data['portfolio'] = this.portfolio;
    return data;
  }
}
