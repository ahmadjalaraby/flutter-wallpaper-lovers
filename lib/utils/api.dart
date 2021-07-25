import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_app/models/models.dart';


Database? kDatabase;
const kTable = 'favorites';


Future<List<Photo>> fetchPhotosRandom(
    http.Client client, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/photos?client_id=${Config().accessKey}&per_page=10&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

Future<List<Photo>> fetchPhotos(
    http.Client client, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/photos/?client_id=${Config().accessKey}&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

Future<SearchQueryPhoto> fetchPhotosQuery(
    http.Client client, String query, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/search/photos?client_id=${Config().accessKey}&query=$query&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotoQuery, response.body);
}

SearchQueryPhoto parsePhotoQuery(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //print(parsed);
  return SearchQueryPhoto.fromJson(parsed);
}

Future<SearchQueryCollection> fetchCollectionsQuery(
    http.Client client, String query, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/search/collections?client_id=${Config().accessKey}&query=$query&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCollectionQuery, response.body);
}

SearchQueryCollection parseCollectionQuery(String responseBody) {
  final parsed = jsonDecode(responseBody);
  print(parsed);
  return  SearchQueryCollection.fromJson(parsed);
}


Future<List<Photo>> fetchTopicsPhotos(
    http.Client client, String slug, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/topics/$slug/photos?client_id=${Config().accessKey}&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseTopicsPhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parseTopicsPhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //print(parsed);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchCollectionsPhotos(
    http.Client client, String id, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/collections/$id/photos?client_id=${Config().accessKey}&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCollectionsPhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parseCollectionsPhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //print(parsed);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //print(parsed);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}


Future<Collection> fetchCollection(http.Client client, String id) async {
  //print(id);
  final response = await client.get(
    Uri.parse(
        'https://api.unsplash.com/collections/$id/?client_id=${Config().accessKey}'),
  );
  //print(response.headers);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCollection, response.body);
}

// A function that converts a response body into a List<Photo>.
Collection parseCollection(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //print(parsed);
  //wait(2);
  return Collection.fromJson(parsed);
}


Future<Photo> fetchPhoto(http.Client client, String id) async {
  //print(id);
  final response = await client.get(
    Uri.parse(
        'https://api.unsplash.com/photos/$id/?client_id=${Config().accessKey}'),
  );
  //print(response.headers);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhoto, response.body);
}

// A function that converts a response body into a List<Photo>.
Photo parsePhoto(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //print(parsed);
 // wait(2);
  return Photo.fromJson(parsed);
}

Future<List<Topic>> fetchTopics(
    http.Client client, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/topics/?client_id=${Config().accessKey}&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseTopics, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Topic> parseTopics(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //print(parsed);
  return parsed.map<Topic>((json) => Topic.fromJson(json)).toList();
}

Future<List<Collection>> fetchCollections(
    http.Client client, int perPage, int pageNumber) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/collections/?client_id=${Config().accessKey}&per_page=$perPage&page=$pageNumber'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCollections, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Collection> parseCollections(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //print(parsed);
  return parsed.map<Collection>((json) => Collection.fromJson(json)).toList();
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}
