import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';

class Config {
  final String hashTag = '#WallpaperLovers';
  final String appName = 'Wallpaper Lovers';
  final String packageName = 'mrahmad.wallpaper_lovers';
  final String appNersion = '1.0.0';
  //final String appIcon;
  //final String splashIcon;
  final String accessKey = 'Here Your Access Key ';
  final String secretKey = 'Here Your Secrect Key ';
  final List<String> bottomItems = ['Home', 'Explore', 'Search', 'Favorite', 'Settings'];
  final List<Tags> tags = [
    Tags(title: 'Technology'),
    Tags(title: 'Summer on Film'),
    Tags(title: 'Wallpapers'),
    Tags(title: 'Experimental'),
    Tags(title: 'Nature'),
    Tags(title: 'People'),
    Tags(title: 'Architecture'),
    Tags(title: 'Current Events'),
    /* 'Business & Work',
    'Fashion',
    'Film',
    'Health & Wellness',
    'Interiors',
    'Street Photography',
    'Travel',
    'Textures & Patterns',
    'Animals',
    'Food & Drink',
    'History',
    'Arts & Culture', */
  ];
  var rand = Random();
  int getRandom() {
    int n = rand.nextInt(19);
    return n;
  }

  List<Tags> randomTopic = [];

  void randomTopics() {
    int numOfTopics = getRandom();
    for (var i = 0; i < numOfTopics; i++) {
      int element = getRandom();
      randomTopic[i] = tags[element];
    }
  }

  List<String> bestOfWeek = [
    'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=889&q=80',
    'https://images.unsplash.com/photo-1506869640319-fe1a24fd76dc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
    'https://images.unsplash.com/photo-1548705085-101177834f47?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=889&q=80',
  ];

  List<String> bestOfMonth = [
    'https://images.unsplash.com/photo-1548705085-101177834f47?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=889&q=80',
    'https://images.unsplash.com/photo-1519309621146-2a47d1f7103a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=753&q=80',
    'https://images.unsplash.com/photo-1510018407610-ec28c7890e6d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=834&q=80',
  ];

  String getBestOfWeek() {
    int n = rand.nextInt(2);
    return bestOfWeek[n];
  }

  String getBestOfWeekTwo() {
    int n = rand.nextInt(2);
    return bestOfMonth[n];
  }

  Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  static final String bestOfWeekPhoto = Config().getBestOfWeek();
  static final String bestOfMonthPhoto = Config().getBestOfWeekTwo();
}
