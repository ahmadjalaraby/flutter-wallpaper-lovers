import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widgets.dart';

class TopicScreen extends StatefulWidget {
  final Topic topic;

  const TopicScreen({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  _TopicScreenState createState() => _TopicScreenState(this.topic);
}

class _TopicScreenState extends State<TopicScreen> {
  final Topic topic;
  late ScrollController controller;
  late ScrollController controllerTwo;
  late bool _isLoading;
  var rand = Random();
  late bool _isFinnished = false;

  int perPage = 8;
  int times = 0;
  int pageNumber = 1;
  List<Photo> photos = [];

  _TopicScreenState(this.topic);

  Future<List<Photo>> _getData() async {
    final data;
    if (photos == null || (photos.length == 0)) {
      data = await fetchTopicsPhotos(
          http.Client(), topic.slug, perPage, pageNumber);
      //photos = data.map((e) => e).toList();
      if (mounted) {
        setState(() {
          photos = data;
          times += 1;
          ++pageNumber;
          print(times);
        });
      }

      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchTopicsPhotos(
          http.Client(), topic.slug, perPage, pageNumber);
      setState(() {
        ++pageNumber;
        times += 1;
        /* Timer(Duration(milliseconds: 500), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        }); */
        print(times);
        if (times > 30) {
          _isFinnished = true;
        }
        photos.addAll(data);
      });
      //print(photos.first.id);
      //photos.addAll(data.map((e) => e).toList());
    }
    return photos;
  }

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    controllerTwo = new ScrollController();
    super.initState();
    _isLoading = true;
    _isFinnished = false;
    _getData();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    controllerTwo.dispose();
    super.dispose();
  }

  void _scrollListener() {
    /* print(controller.position.pixels == controller.position.maxScrollExtent);
    print(_isLoading || !_isFinnished); */

    if (_isLoading && _isFinnished == false) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          _isLoading = true;
          ++pageNumber;
          _getData();
        });
      }
    } else if (_isFinnished) {
      setState(() {
        times = 0;
        _isFinnished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PhotoScreen(
                                  photo: topic.coverPhoto,
                                  tag: topic.coverPhoto.id,
                                  imageUrl: topic.coverPhoto.urls.regular,
                                ),
                              ),
                            ),
                            child: CachedNetworkImage(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                imageUrl: topic.coverPhoto.urls.regular,
                                fadeInCurve: Curves.easeOutCirc,
                                fadeInDuration:
                                    const Duration(milliseconds: 1800),
                                placeholder: (context, url) => LoadingWidget7(),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error))),
                          ),
                          Positioned(
                            width: MediaQuery.of(context).size.width,
                            top: 25,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: BorderIcon(
                                      height: 50,
                                      width: 50,
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.keyboard_backspace,
                                        color:
                                            DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                  /* BorderIcon(
                                    height: 50,
                                    padding: EdgeInsets.all(8.0),
                                    width: 50,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    ),
                                  ), */
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${topic.title}",
                                  style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "#${topic.slug}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                BorderIcon(
                                  child: Text(
                                    '${topic.totalPhotos} Photos',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  height: 65.0,
                                  width: 145.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "Description:",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: DynamicTheme.of(context)!.themeId == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 25.0),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: DynamicTheme.of(context)!.themeId == 2
                              ? Colors.grey[850]
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: DynamicTheme.of(context)!.themeId == 2
                                  ? Colors.grey.shade900
                                  : Colors.white38,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            topic.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17.0,
                              //color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "Topic Photos",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildTopicPhotos(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopicPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StaggeredGridView.countBuilder(
          controller: controllerTwo,
          crossAxisCount: 4,
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          itemCount: photos.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < photos.length) {
              return InkWell(
                child: Stack(
                  children: [
                    Hero(
                      tag: photos.elementAt(index).id,
                      child: CachedNetworkImage(
                        imageUrl: photos.elementAt(index).urls.regular,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[400]!,
                                    blurRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                        placeholder: (context, url) => LoadingWidget1(),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhotoScreen(
                        tag: photos.elementAt(index).id,
                        photo: photos.elementAt(index),
                        imageUrl: photos.elementAt(index).urls.regular,
                      ),
                    ),
                  );
                },
              );
            }

            if (_isFinnished) {
              return Container(
                child: Center(
                  child: Text(
                    'No more Photos',
                    style: const TextStyle(
                      fontFamily: 'MontserratSemi',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            } else {
              /* print(_isLoading);
              print(_isFinnished); */

              return Center(
                child: new Opacity(
                  opacity: _isLoading ? 1.0 : 0.0,
                  child: LoadingWidget3(),
                ),
              );
            }
          },
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 4 : 3),
          mainAxisSpacing: 11.0,
          crossAxisSpacing: 10.0,
          padding: EdgeInsets.all(15.0),
        ),
      ],
    );
  }
}

/* Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0, top: 6.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: CachedNetworkImage(
                          height: 220.0,
                          width: MediaQuery.of(context).size.width - 20,
                          fit: BoxFit.cover,
                          imageUrl: topic.coverPhoto.urls.regular,
                          fadeInCurve: Curves.easeOutCirc,
                          fadeInDuration: const Duration(milliseconds: 1800),
                          placeholder: (context, url) => LoadingWidget7(),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error))),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white38,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Text(
                            topic.title,
                            style: TextStyle(
                              fontFamily: 'RalewayTwo',
                              fontSize: 33.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ), */
