import 'dart:math';

import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/models/user.dart';

class Photo {
  late String _id;
  late String _createdAt;
  late String _updatedAt;
  late int _width;
  late int _height;
  late String _color;
  late int _downloads;
  late int _likes;
  late String _description;
  late String _altDescription;

  List<Tags> _tags = [];
  late Urls _urls;
  late Links _links;
  late User _user;

  Photo({
    required String id,
    required String createdAt,
    required String updatedAt,
    required int width,
    required int height,
    required String color,
    required int downloads,
    required int likes,
    required String description,
    required String altDescription,
    List<Tags>? tags,
    required Urls urls,
    required Links links,
    required User user,
  }) {
    this._id = id;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._width = width;
    this._height = height;
    this._color = color;
    this._downloads = downloads;
    this._likes = likes;
    this._description = description;
    this._altDescription = altDescription;
    this._tags = tags!;
    this._urls = urls;
    this._links = links;
    this._user = user;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get width => _width;
  set width(int width) => _width = width;
  int get height => _height;
  set height(int height) => _height = height;
  String get color => _color;
  set color(String color) => _color = color;
  int get downloads => _downloads;
  set downloads(int downloads) => _downloads = downloads;
  int get likes => _likes;
  set likes(int likes) => _likes = likes;
  String get description => _description;
  set description(String description) => _description = description;
  String get altDescription => _altDescription;
  set altDescription(String altDescription) => _altDescription = altDescription;
  List<Tags> get tags => _tags;
  set tags(List<Tags> tags) => _tags = tags;
  Urls get urls => _urls;
  set urls(Urls urls) => _urls = urls;
  Links get links => _links;
  set links(Links links) => _links = links;
  User get user => _user;
  set user(User user) => _user = user;

  Photo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _width = json['width'];
    _height = json['height'];
    _color = json['color'];
    _downloads = json['downloads'];
    _likes = json['likes'];
    _description = json['description'];
    _altDescription = json['alt_description'];

    if (json['tags'] != null) {
      // _tags = new List.<Tags>();
      json['tags'].forEach((v) {
        _tags.add(new Tags.fromJson(v));
      });
    }
    _urls = new Urls.fromJson(json['urls']);
    _links = new Links.fromJson(json['links']);
    _user = new User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['width'] = this._width;
    data['height'] = this._height;
    data['color'] = this._color;
    data['downloads'] = this._downloads;
    data['likes'] = this._likes;
    data['description'] = this._description;
    data['alt_description'] = this._altDescription;
    if (this._tags != null) {
      data['tags'] = this._tags.map((v) => v.toJson()).toList();
    }
    if (this._urls != null) {
      data['urls'] = this._urls.toJson();
    }
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }

  /* 
  .fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      color: json['color'] as String,
      description: json['description'] as String,
      user: json['user'] as User,
      downloads: json['downloads'] as int,
      tags: json['tags' 'title'] as List<String>,
      likes: json['likes'] as int,
      url: json['urls' 'regular'] as String,
    );
  } */
}
