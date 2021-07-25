import 'models.dart';

class SearchQueryPhoto {
  late int total;
  late int totalPages;
  late List<Photo> results = [];

  SearchQueryPhoto({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  SearchQueryPhoto.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
