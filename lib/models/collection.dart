import 'package:wallpaper_app/models/models.dart';

class Collection {
  late String id;
  late String title;
  late String description;
  late String publishedAt;
  late String updatedAt;
  late bool featured;
  late int totalPhotos;
  List<Tags> tags = [];
  late Links links;
  late User user;
  late Photo coverPhoto;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
    required this.totalPhotos,
    required this.tags,
    required this.links,
    required this.user,
    required this.coverPhoto,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    updatedAt = json['updated_at'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    if (json['tags'] != null) {
      //tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    links = (json['links'] != null ? new Links.fromJson(json['links']) : null)!;
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
    coverPhoto = (json['cover_photo'] != null
        ? new Photo.fromJson(json['cover_photo'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['published_at'] = this.publishedAt;
    data['updated_at'] = this.updatedAt;
    data['featured'] = this.featured;
    data['total_photos'] = this.totalPhotos;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.coverPhoto != null) {
      data['cover_photo'] = this.coverPhoto.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Collection(id: $id, title: $title, description: $description, publishedAt: $publishedAt, updatedAt: $updatedAt, featured: $featured, totalPhotos: $totalPhotos, tags: $tags, links: $links, user: $user, coverPhoto: $coverPhoto)';
  }
}
