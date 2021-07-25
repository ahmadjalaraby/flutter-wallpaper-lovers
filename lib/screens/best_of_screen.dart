import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widgets.dart';

class BestOfScreen extends StatefulWidget {
  final String title;

  const BestOfScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _BestOfScreenState createState() => _BestOfScreenState(this.title);
}

class _BestOfScreenState extends State<BestOfScreen>
    with AutomaticKeepAliveClientMixin {
  final String title;

  late ScrollController controller;
  late bool _isLoading;

  // this scaffold key here for testing purpose :-) gg monica
  late final scaffoldKey = GlobalKey<ScaffoldState>();
  var rand = Random();
  late bool _isFinnished;

  _BestOfScreenState(this.title);

  late int perPage = 5;
  int times = 0;
  late int pageNumber = rand.nextInt(80);
  List<Photo> photos = [];

  void _getData() async {
    final data;
    if (photos == null || (photos.length == 0)) {
      data = await fetchPhotos(http.Client(), perPage, pageNumber);
      //photos = data.map((e) => e).toList();
      setState(() {
        photos = data;
        times += 1;
        ++pageNumber;
      });
      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchPhotos(http.Client(), perPage, pageNumber);
      setState(() {

        ++pageNumber;
        times += 1;

        if (times > 1) {
          _isFinnished = true;
        }
        photos.addAll(data);
      });
      //print(photos.first.id);

      //photos.addAll(data.map((e) => e).toList());
    }
  }

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
    _isLoading = true;
    _isFinnished = false;
    _getData();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
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
          '$title',
          style: const TextStyle(
            fontSize: 22.0,
            fontFamily: 'MontserratSemi',
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 23.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              controller: controller,
              addAutomaticKeepAlives: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.55,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
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
                  return Center(
                    child: new Opacity(
                      opacity: _isLoading ? 1.0 : 0.0,
                      child: new SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                  );
                }
              },
              padding: EdgeInsets.all(15.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/*

body: Column(
        children: <Widget>[
          Expanded(
            child: StaggeredGridView.countBuilder(
              controller: controller,
              crossAxisCount: 4,
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
                  return Center(
                    child: new Opacity(
                      opacity: _isLoading ? 1.0 : 0.0,
                      child: new SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                  );
                }
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 4 : 3),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: EdgeInsets.all(15.0),
            ),
          ),
        ],
      ),

*/
