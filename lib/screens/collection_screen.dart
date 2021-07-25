import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class CollectionScreen extends StatefulWidget {
  final Collection collection;

  const CollectionScreen({
    Key? key,
    required this.collection,
  }) : super(key: key);

  @override
  _CollectionScreenState createState() =>
      _CollectionScreenState(this.collection);
}

class _CollectionScreenState extends State<CollectionScreen> {
  final Collection collection;
  late ScrollController controller;
  late ScrollController controllerTwo;
  late bool _isLoading;
  var rand = Random();
  late bool _isFinnished = false;

  int perPage = 0;

  int times = 0;
  int pageNumber = 1;
  List<Photo> photos = [];
  int changing = 31;

  _CollectionScreenState(this.collection);

  Future<List<Photo>> _getData() async {
    final data;
    perPage = 20;
    if (collection.totalPhotos <= 20) {
      perPage = collection.totalPhotos;
    }
    if (photos == null || (photos.length == 0)) {
      data = await fetchCollectionsPhotos(
          http.Client(), collection.id, perPage, pageNumber);
      //photos = data.map((e) => e).toList();

      if (mounted) {
        setState(() {
          photos = data;
          times += 1;
          //++pageNumber;
          print(times);
        });
      }
      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchCollectionsPhotos(
          http.Client(), collection.id, perPage, pageNumber);
      setState(() {
        //++pageNumber;
        times += 1;
        /* Timer(Duration(milliseconds: 500), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        }); */
        print('Number of times $times');
        /*  num b = (collection.totalPhotos%20.toDouble()).ceil();
        print('This is my B : $b');
        int a = collection.totalPhotos;
        print('Number of qo ${a.remainder(20)}'); */

        if (times > (collection.totalPhotos % 20.ceil())) {
          setState(() {
            _isFinnished = true;
          });
        }
        photos.addAll(data);
      });
      //print(photos.first.id);
      //photos.addAll(data.map((e) => e).toList());
    }
    return photos;
  }

  Future<void> _showSnackBar(String text) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.white.withOpacity(0.8),
      margin: EdgeInsets.all(30.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.5,
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Center(
        heightFactor: 0.9,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).brightness != Brightness.dark
                  ? Colors.black
                  : Colors.white,
              fontSize: 16),
        ),
      ),
    ));
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
                                  photo: collection.coverPhoto,
                                  tag: collection.coverPhoto.id,
                                  imageUrl: collection.coverPhoto.urls.regular,
                                ),
                              ),
                            ),
                            child: CachedNetworkImage(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                imageUrl: collection.coverPhoto.urls.regular,
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
                                        color: DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future:
                                          _isCollectionFavorite(collection.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.done) {
                                          if (snapshot.data == true) {
                                            return InkWell(
                                              onTap: () async {
                                                print(
                                                    'Favorite Button Clicked..');
                                                await kDatabase!
                                                    .insert(kTable, {
                                                  'pid': collection.id,
                                                  'title':
                                                      collection.title != null
                                                          ? collection.title
                                                          : 'Collection',
                                                  'urls_regural': collection
                                                      .coverPhoto.urls.regular,
                                                  'isphoto': 0
                                                }).then((value) {
                                                  setState(() {});
                                                  _showSnackBar(
                                                      'Collection Added to favorites');
                                                });
                                              },
                                              child: BorderIcon(
                                                height: 50,
                                                padding: EdgeInsets.all(8.0),
                                                width: 50,
                                                child: Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.white
                                                : Colors.black,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return InkWell(
                                              onTap: () async {
                                                print(
                                                    'Favorite Button Clicked..');
                                                await kDatabase!.delete(
                                                  kTable,
                                                  where: 'pid = ?',
                                                  whereArgs: [collection.id],
                                                ).then((value) {
                                                  setState(() {});
                                                  _showSnackBar(
                                                      'Removed from favorites');
                                                });
                                              },
                                              child: BorderIcon(
                                                height: 50,
                                                padding: EdgeInsets.all(8.0),
                                                width: 50,
                                                child: Icon(
                                                  Icons.favorite_outline,
                                                  color: DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.red
                                                : Colors.red,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return SizedBox.shrink();
                                      }),
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
                                collection.title != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                70,
                                        child: Text(
                                          "${collection.title}",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(height: 5.0),
                                collection.publishedAt != null
                                    ? Text(
                                        "#${collection.publishedAt}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  height: 8.0,
                                ),
                                BorderIcon(
                                  child: collection.totalPhotos != null
                                      ? Text(
                                          '${collection.totalPhotos} Photos',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : SizedBox.shrink(),
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
                          collection.description != null
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    "Description:",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      //SizedBox(height: 25.0),
                      SizedBox(height: 5.0),
                      collection.description != null
                          ? Container(
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(18.0),
                                color: DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.black.withOpacity(0.2)
                                                : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: DynamicTheme.of(context)!.themeId ==
                                                    2
                                                ? Colors.black12
                                                : Colors.white38,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  collection.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    //color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Collection Photos",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildCollectionPhotos(),
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

  Widget buildCollectionPhotos() {
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

  Future _isCollectionFavorite(String pid) async {
    List<Map> result = await kDatabase!.query(
      kTable,
      columns: ['pid'],
      where: 'pid = ?',
      whereArgs: [pid],
    );
    return result.isEmpty;
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
