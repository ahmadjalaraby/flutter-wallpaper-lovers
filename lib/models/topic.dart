import 'package:wallpaper_app/models/models.dart';

class Topic {
  late String id;
  late String slug;
  late String title;
  late String description;
  late bool featured;
  late int totalPhotos;
  late Links links;
  late String status;
  List<User> owners = [];
  late Photo coverPhoto;

  Topic(
      {required this.id,
      required this.slug,
      required this.title,
      required this.description,
      required this.featured,
      required this.totalPhotos,
      required this.links,
      required this.status,
      required this.owners,
      required this.coverPhoto});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    links = (json['links'] != null ? new Links.fromJson(json['links']) : null)!;
    status = json['status'];
    if (json['owners'] != null) {
      //owners = new List<User>();
      json['owners'].forEach((v) {
        owners.add(new User.fromJson(v));
      });
    }
    coverPhoto = (json['cover_photo'] != null
        ? new Photo.fromJson(json['cover_photo'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['featured'] = this.featured;
    data['total_photos'] = this.totalPhotos;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    data['status'] = this.status;
    if (this.owners != null) {
      data['owners'] = this.owners.map((v) => v.toJson()).toList();
    }
    if (this.coverPhoto != null) {
      data['cover_photo'] = this.coverPhoto.toJson();
    }
    return data;
  }
}
