import 'models.dart';

class SearchQueryCollection {
  late int total;
  late int totalPages;
 List<Collection> results = [];

  SearchQueryCollection({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  SearchQueryCollection.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(new Collection.fromJson(v));
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
