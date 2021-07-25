import 'dart:async';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          child: SafeArea(
            child: TabBar(
              controller: tabController,
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'RalewayTwo',
                  color: DynamicTheme.of(context)!.themeId == 2
                      ? Colors.grey[200]
                      : Colors.black,
                  fontWeight: FontWeight.w500),
              tabs: <Widget>[
                Tab(
                  child: Text('Favorite Photos'),
                ),
                Tab(
                  child: Text(
                    'Favorite Collections',
                  ),
                )
              ],
              labelColor: DynamicTheme.of(context)!.themeId == 2
                  ? Colors.white
                  : Colors.black,
              indicatorColor: DynamicTheme.of(context)!.themeId == 2
                  ? Colors.grey[200]
                  : Colors.black,
              unselectedLabelColor: DynamicTheme.of(context)!.themeId == 2
                  ? Colors.grey[600]
                  : Colors.grey,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                /* PopularItems(), 
                NewItems()   */
                FavoritePhotos(),
                FavoriteCollections(),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment(0, 1.0),
          //   child: Container(
          //     color: Colors.deepPurpleAccent,
          //     child: facebookBannerAd,
          //   ),
          // ),
        ],
      ),
    );
  }
}
