import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class FavoritePhotos extends StatefulWidget {
  const FavoritePhotos({Key? key}) : super(key: key);

  @override
  _FavoritePhotosState createState() => _FavoritePhotosState();
}

class _FavoritePhotosState extends State<FavoritePhotos>
    with AutomaticKeepAliveClientMixin {
  late Set<String> photosUrl = {};
  late Set<Photo> photos = {};
  late ScrollController scrollController;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    scrollController = new ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
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
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    photos.clear();
    photosUrl.clear();
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
    //_query();
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: () => CircularProgressIndicator(),
      child: FutureBuilder(
        future: _query(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

         /*  if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: 60.0,
                height: 60.0,
                child: CircularProgressIndicator(),
              ),
            );
          } */

          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      StaggeredGridView.countBuilder(
                        controller: scrollController,
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        itemCount: photosUrl.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Stack(
                              children: [
                                Hero(
                                  tag: '${photosUrl.elementAt(index)}$index',
                                  child: CachedNetworkImage(
                                    imageUrl: photosUrl.elementAt(index),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    placeholder: (context, url) =>
                                        LoadingWidget1(),
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
                                    tag: '${photosUrl.elementAt(index)}$index',
                                    photo: photos.elementAt(index),
                                    imageUrl: photosUrl.elementAt(index),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(2, index.isEven ? 4 : 3),
                        mainAxisSpacing: 11.0,
                        crossAxisSpacing: 10.0,
                        padding: EdgeInsets.all(15.0),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  _query() async {
    // get a reference to the database
    // Database db = await DatabaseHelper.instance.database;
    // get all rows

    //isLoading = true;
    List<Map> result = await kDatabase!.query(kTable);
    var data;
    /* photosUrl.clear();
    photos.clear(); */

    result.forEach((row) async {
      if (row.values.elementAt(3) == 1) {
        //print('The name of photo: ${row.values.elementAt(1)}');
        if (!photosUrl.contains(row.values.elementAt(2))) {
          data = await fetchPhoto(http.Client(), row.values.elementAt(0));
          photosUrl.add(row.values.elementAt(2));
          photos.add(data);
        }
      }
    });

    // {_id: 1, name: Bob, age: 23}
    // {_id: 2, name: Mary, age: 32}
    // {_id: 3, name: Susan, age: 12}

    setState(() {
      isLoading = false;
    });

    return photos;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
