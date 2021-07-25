import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widgets.dart';

class FavoriteCollections extends StatefulWidget {
  const FavoriteCollections({Key? key}) : super(key: key);

  @override
  _FavoriteCollectionsState createState() => _FavoriteCollectionsState();
}

class _FavoriteCollectionsState extends State<FavoriteCollections>
    with AutomaticKeepAliveClientMixin {
  late List<String> collectionsUrl = [];
  late List<Collection> collections = [];
  late ScrollController scrollController;
  late ScrollController controllerTwo;
  int times = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    scrollController = new ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
    controllerTwo = new ScrollController();
    times = 0;

    super.initState();
    isLoading = true;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
    scrollController.dispose();
    controllerTwo.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    collections.clear();
    collectionsUrl.clear();
    times = 0;
    _query();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: FutureBuilder<List<Collection>>(
        future: _query(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          /* if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: 60.0,
                height: 60.0,
                child: CircularProgressIndicator(),
              ),
            );
          } */

          return snapshot.hasData
              ? /* CustomScrollView(
                  controller: scrollController,
                  //physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: ListView.builder(
                                  controller: controllerTwo,
                                  shrinkWrap: true,
                                  itemCount: collections.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CollectionItem(
                                      itemData: collections.elementAt(index),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ) */
              SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        controller: controllerTwo,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CollectionItem(
                            itemData: snapshot.data!.elementAt(index),
                          );

                          //return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No Favortie Collections Found.',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Raleway'),
                  ),
                );
        },
      ),
    );
  }

  Future<List<Collection>> _query() async {
    // get a reference to the database
    // Database db = await DatabaseHelper.instance.database;
    // get all rows

    //isLoading = true;
    List<Map> result = await kDatabase!.query(kTable);
    var data;
    /* photosUrl.clear();
    photos.clear(); */
    int index = 0;
    int d = result.length;
    //print(d);
    if (times == 0) {
      result.forEach((row) async {
        if (index < d) {
          if (row.values.elementAt(3) == 0 &&
              !collectionsUrl.contains(row.values.elementAt(2))) {
            //print('The name of photo: ${row.values.elementAt(1)}');

            data =
                await fetchCollection(http.Client(), row.values.elementAt(0));
            //await Future.delayed(Duration(microseconds: 800));
            collectionsUrl.add(row.values.elementAt(2));
            collections.add(data);
            collectionsUrl.toSet().toList();
            collections.toSet().toList();
          }
        }
        index++;
      });
    }
    times = 1;

    //print('Length of Collections : ${collections.length}');

    // {_id: 1, name: Bob, age: 23}
    // {_id: 2, name: Mary, age: 32}
    // {_id: 3, name: Susan, age: 12}

    if (mounted) {
      setState(() {});
    }

    return collections;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CollectionItem extends StatefulWidget {
  final Collection itemData;
  const CollectionItem({Key? key, required this.itemData}) : super(key: key);

  @override
  _CollectionItemState createState() => _CollectionItemState(this.itemData);
}

class _CollectionItemState extends State<CollectionItem> {
  final Collection itemData;
  _CollectionItemState(this.itemData);

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
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CollectionScreen(
                  collection: itemData,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          //color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: DynamicTheme.of(context)!.themeId == 2
                                      ? Colors.grey.shade900.withOpacity(.2)
                                    : Colors.white54,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: 250.0,
                      imageUrl: itemData.coverPhoto.urls.small,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[400]!,
                                  blurRadius: 5,
                                  offset: Offset(0, 2))
                            ],
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                      placeholder: (context, url) => LoadingWidget2(),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: 25.0,
                  left: 25.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder(
                            future: _isCollectionFavorite(itemData.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.data == true) {
                                  return InkWell(
                                    onTap: () async {
                                      print('Favorite Button Clicked..');
                                      await kDatabase!.insert(kTable, {
                                        'pid': itemData.id,
                                        'title': itemData.title != null
                                            ? itemData.title
                                            : 'Collection',
                                        'urls_regural':
                                            itemData.coverPhoto.urls.regular,
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
                                        Icons.favorite_border_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () async {
                                      print('Favorite Button Clicked..');
                                      await kDatabase!.delete(
                                        kTable,
                                        where: 'pid = ?',
                                        whereArgs: [itemData.id],
                                      ).then((value) {
                                        setState(() {});
                                        _showSnackBar('Removed from favorites');
                                      });
                                    },
                                    child: BorderIcon(
                                      height: 50,
                                      padding: EdgeInsets.all(8.0),
                                      width: 50,
                                      child: Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
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
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${itemData.title}",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${itemData.publishedAt}",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
              child: Text(
                "Total Photos ${itemData.totalPhotos}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
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
