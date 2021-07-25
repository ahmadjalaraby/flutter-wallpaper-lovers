import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/loading_animation.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class BuildPhoto extends StatelessWidget {
  final SearchQueryPhoto? detail;
  final String query;

  const BuildPhoto({
    Key? key,
    required this.detail,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Found ${detail!.total} results\nfor ',
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'RalewayTwo',
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '$query',
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'RalewayTwo',
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchScreen extends StatefulWidget {
  final String query;
  final bool isPhoto;
  const SearchScreen({Key? key, required this.query, required this.isPhoto})
      : super(key: key);

  @override
  _SearchScreenState createState() =>
      _SearchScreenState(this.query, this.isPhoto);
}

class _SearchScreenState extends State<SearchScreen> {
  final String query;
  bool isPhoto;

  int perPage = 30;
  int pageNumber = 1;
  int times = 0;
  int totalResults = 1;
  bool _isLoading = false;
  bool _isLoadingMain = true;
  bool _noResult = false;
  bool _isFinnished = false;
  late List<Photo> photos = [];
  late List<Collection> collections = [];
  late SearchQueryCollection searchQueryCollection;
  late SearchQueryPhoto searchQueryPhoto;
  ScrollController controller = new ScrollController();
  late ScrollController controllerTwo;

  Future<SearchQueryPhoto> _getDataPhoto() async {
    // perPage = 8;
    final data;
    if (photos == null || (photos.length == 0)) {
      data = await fetchPhotosQuery(http.Client(), query, perPage, pageNumber);
      //photos = data.map((e) => e).toList();
      setState(() {
        searchQueryPhoto = data;
        photos = data.results;
        print('First $pageNumber');
        ++pageNumber;
      });
      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchPhotosQuery(http.Client(), query, perPage, pageNumber);
      setState(() {
        searchQueryPhoto = data;
        print('Second $pageNumber');
        photos.addAll(data.results);
        ++pageNumber;
        if (times > totalResults) {
          _isFinnished = true;
        }
        /* Timer(Duration(milliseconds: 500), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        }); */
      });
      //print(photos.first.id);
      //photos.addAll(data.map((e) => e).toList());
    }
    _isLoadingMain = false;
    if (searchQueryPhoto.total == 0) {
      _noResult = true;
    }
    return searchQueryPhoto;
  }

  Future<SearchQueryCollection> _getDataCollection() async {
    // perPage = 8;
    final data;
    if (collections == null || (collections.length == 0)) {
      data = await fetchCollectionsQuery(
          http.Client(), query, perPage, pageNumber);
      print(data.total);
      //photos = data.map((e) => e).toList();
      setState(() {
        searchQueryCollection = data;
        collections = data.results;
        print(data.total);
        if (data.total < perPage) {
          //times +=
        }
        print('First $pageNumber');
        ++pageNumber;
      });
      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchCollectionsQuery(
          http.Client(), query, perPage, pageNumber);
      setState(() {
        searchQueryCollection = data;
        print('Second $pageNumber');
        collections.addAll(data.results);
        ++pageNumber;
        if (times > totalResults) {
          _isFinnished = true;
        }
        /* Timer(Duration(milliseconds: 500), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        }); */
      });
      //print(photos.first.id);
      //photos.addAll(data.map((e) => e).toList());
    }
    _isLoadingMain = false;
    if (searchQueryCollection.total == 0) {
      print(searchQueryCollection.total);
      _noResult = true;
    }
    return searchQueryCollection;
  }

  _SearchScreenState(this.query, this.isPhoto);

  @override
  void initState() {
    isPhoto ? _getDataPhoto() : _getDataCollection();
    controller = new ScrollController()..addListener(_scrollListener);
    controllerTwo = new ScrollController();
    super.initState();
    _isLoading = true;
    _isLoadingMain = true;
    _noResult = false;
    _isFinnished = false;
    // Timer(Duration(milliseconds: 200), () {
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    controllerTwo.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isLoading && _isFinnished == false) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          _isLoading = true;
          //++pageNumber;
          isPhoto ? _getDataPhoto() : _getDataCollection();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.blue, Colors.blueAccent],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Search',
          style: const TextStyle(
            fontSize: 22.0,
            fontFamily: 'MontserratSemi',
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _isLoadingMain
          ? Center(child: CircularProgressIndicator())
          : _noResult
              ? noItems()
              : isPhoto
                  ? buildPhoto(query)
                  : buildCollection(query),
    );
  }

  Widget noItems() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.find_in_page, size: 100, color: Colors.grey[300]),
            Container(height: 15),
            Text(
              "No Result",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 5),
            Center(
              child: Text(
                "Try more general keyword",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhoto(query) {
    return CustomScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Found ${searchQueryPhoto.total} results for ',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontFamily: 'RalewayTwo',
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                      ),
                      Expanded(
                        child: Text(
                          '$query',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'RalewayTwo',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
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
                              // snapshot.data!.results.elementAt(index).
                              tag: '${photos.elementAt(index).id}$index',
                              child: CachedNetworkImage(
                                imageUrl: photos.elementAt(index).urls.regular,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                placeholder: (context, url) => LoadingWidget3(),
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
                                tag: '${photos.elementAt(index).id}$index',
                                photo: photos.elementAt(index),
                                imageUrl: photos.elementAt(index).urls.regular,
                              ),
                            ),
                          );
                        },
                      );
                    }

                    if (_isFinnished) {
                      print(_isFinnished);
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
                      //_isLoading = true;
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
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCollection(query) {
    return CustomScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Found ${searchQueryCollection.total} results for ',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'RalewayTwo',
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                        Expanded(
                          child: Text(
                            '$query',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontFamily: 'RalewayTwo',
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      controller: controllerTwo,
                      shrinkWrap: true,
                      itemCount: collections.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < collections.length) {
                          return CollectionItem(
                            itemData: collections.elementAt(index),
                          );
                        }
                        if (_isFinnished) {
                          print(_isFinnished);
                          return Container(
                            child: Center(
                              child: Text(
                                'No more Collections',
                                style: const TextStyle(
                                  fontFamily: 'MontserratSemi',
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: new Opacity(
                              opacity: _isLoading ? 1.0 : 0.0,
                              child: Column(
                                children: [
                                  SizedBox(height: 10.0),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
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
                color: Colors.white54, offset: Offset(0, 2), blurRadius: 6.0),
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
                  top: 25,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Colors.black,
                            ),
                          ),
                        ),
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

  Future _isPhotoFavorite(String pid) async {
    List<Map> result = await kDatabase!.query(
      kTable,
      columns: ['pid'],
      where: 'pid = ?',
      whereArgs: [pid],
    );
    return result.isEmpty;
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
