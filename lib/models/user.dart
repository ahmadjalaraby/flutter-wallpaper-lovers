import 'package:wallpaper_app/models/models.dart';

class User {
  late String id;
  late String username;
  late String name;
  late String bio;
  late Links links;
  late ProfileImage profileImage;
  late int totalCollections;
  late int totalLikes;
  late int totalPhotos;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.bio,
    required this.links,
    required this.profileImage,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    bio = json['bio'];
    links = (json['links'] != null ? new Links.fromJson(json['links']) : null)!;
    profileImage = (json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null)!;
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['bio'] = this.bio;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage.toJson();
    }
    data['total_collections'] = this.totalCollections;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    return data;
  }
}

/* class User {
  late String _id;
  late String _username;
  late String _name;
  late String _profileImage;

  User({
    required String id,
    required String username,
    required String name,
    required String profileImage,
  }) {
    this._id = id;
    this._username = username;
    this._name = name;
    this._profileImage = profileImage;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get username => _username;
  set username(String username) => _username = username;
  String get name => _name;
  set name(String name) => _name = name;
  String get profileImage => _profileImage;
  set profileImage(String profileImage) => _profileImage = profileImage;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _username = json['username'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['username'] = this._username;
    data['name'] = this._name;
    return data;
  }
}
 */
