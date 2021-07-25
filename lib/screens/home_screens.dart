import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/config.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/utils/utils.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.8,
    keepPage: true,
  );
  PageController _pageControllerTwo = PageController(
    initialPage: 0,
    viewportFraction: .8,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
      keepPage: true,
    );
    _pageControllerTwo = PageController(
      initialPage: 0,
      viewportFraction: .8,
      keepPage: true,
    );
  }

  var config = Config();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Center(
                      child: Text(
                        config.appName,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BestOfWidget(
                      txt: 'Best of Week', photo: Config.bestOfWeekPhoto),
                  const SizedBox(height: 4.0),
                  BestOfWidget(
                      txt: 'Best of Month', photo: Config.bestOfMonthPhoto),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Trending',
                      style: const TextStyle(
                        fontSize: 26.0,
                        letterSpacing: 1.1,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BestOfScreen(title: 'Trending'),
                        ),
                      ),
                      child: Text(
                        'More',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),

                    // const SizedBox(height: 5.0),
                  ],
                ),
              ),
              Container(
                // width: double.infinity,
                child: FutureBuilder<List<Photo>>(
                  future: fetchPhotos(http.Client(), 10, 1),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return snapshot.hasData
                        ? PhotoCarousel(
                            pageController: _pageController,
                            photos: snapshot.data!)
                        : Center(child: LoadingWidget3());
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Popular',
                      style: const TextStyle(
                        fontSize: 26.0,
                        letterSpacing: 1.1,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BestOfScreen(title: 'Popular'),
                        ),
                      ),
                      child: Text(
                        'More',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),

                    // const SizedBox(height: 5.0),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15.0, left: 10.0),
                // width: double.infinity,
                child: FutureBuilder<List<Photo>>(
                  future: fetchPhotos(http.Client(), 10, 20),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return snapshot.hasData
                        ? PhotoCarousel(
                            pageController: _pageControllerTwo,
                            photos: snapshot.data!)
                        : Center(child: LoadingWidget3());
                  },
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Container(
                    margin: EdgeInsets.all(5.0),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * .93,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => print('best of month clicked...'),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              imageUrl: Config.bestOfMonthPhoto,
                              fadeInCurve: Curves.easeInQuart,
                              fadeInDuration:
                                  const Duration(milliseconds: 1800),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              placeholder: (context, url) => LoadingWidget2(),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black45.withOpacity(.3),
                                  Colors.black45.withOpacity(.3),
                                ],
                                stops: [0.0, 1],
                                begin: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Bext of The Month',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

*/
