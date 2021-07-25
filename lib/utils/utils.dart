import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/models.dart';

class Utils {
  var rand = Random();
  var config = Config();
  var perPage = 3;
  int pageNumber = 1;
  //final int d = Random().nextInt(20000);

  set setPerPage(i) => perPage = i;
  int get getPerPage => perPage;
  int get getPageNumber => pageNumber++;
  set setPageNumber(i) => pageNumber = i;

  late List data;
  //Utils util = Utils();
  List<Photo> myListImage = [];

  List<Color> colors = [
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
  ];

// 'https://api.unsplash.com/photos/?client_id=${Config().accessKey}&per_page=${Utils().perPage}&page=${Utils().randomPage(5)}'

}

/* 
fetchTrendingWallpapers(http.Client client) async {
  final response = await client.get(
    Uri.parse(
        'https://api.unsplash.com/photos/?client_id=${Config().accessKey}&per_page=${Utils().perPage}&page=${Utils().getPageNumber}'),
  );
  print(
      'https://api.unsplash.com/photos/?client_id=${Config().accessKey}&per_page=${Utils().perPage}&page=${Utils().getPageNumber}');
  final data = json.decode(response.body);
  parsePhotos(data);
  // Use the compute function to run parsePhotos in a separate isolate.
}

List<Photo> getPhotos() {
  fetchTrendingWallpapers(http.Client());
  print(myListImage[1].url);
  return myListImage;
}

List<Photo> parsePhotos(List data) {
  List<Photo> photos = [];
  List<String> tags = [];
  User user;
  for (var i = 0; i < data.length; i++) {
    tags.add(data.elementAt(i)["tags" "title"]);

    user = User(
      id: data.elementAt(i)["user" "id"],
      username: data.elementAt(i)["user" "username"],
      name: data.elementAt(i)["user" "name"],
      profileImage: data.elementAt(i)["urls" "regular"],
    );
    Photo photo = Photo(
      id: data.elementAt(i)["id"],
      createdAt: data.elementAt(i)["created_at"],
      updatedAt: data.elementAt(i)["updated_at"],
      width: data.elementAt(i)["width"],
      height: data.elementAt(i)["height"],
      color: data.elementAt(i)["color"],
      description: data.elementAt(i)["description"],
      likes: data.elementAt(i)["likes"],
      downloads: data.elementAt(i)["downloads"],
      tags: tags,
      user: user,
      url: data.elementAt(i)["urls" "regular"],
    );
    photos.add(photo);
    //data.elementAt(i)["user" "id"];
  }
  //print(parsed.map<Photo>((json) => Photo.fromJson(json)).toList());
  myListImage = photos;
  return photos;
} */
