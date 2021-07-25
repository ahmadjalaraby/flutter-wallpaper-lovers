import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController textController = TextEditingController();

  _ExploreScreenState();

  PageController _pageController =
      PageController(viewportFraction: 0.877, keepPage: true, initialPage: 0);

  late ScrollController controller;
  late ScrollController controllerTwo;
  late bool _isLoading;
  var rand = Random();
  late bool _isFinnished;

  String query = '';
  bool isSwitched1 = true;
  bool finishLoading = true;
  bool _isLoadingScroll = false;
  int perPage = 10;
  int pageNumber = 1;
  bool _isStart = true;
  bool _isPhoto = true;
  bool _isCollection = false;
  bool _isResult = true;
  List<String> listOfFilterChoice = ['Photos', 'Collections'];
  List<String> selectedListData = [
    'Photos',
  ];
  late String selectedCountList;
  late List<Photo> photos = [];
  late List<Collection> collections = [];
  late SearchQueryCollection searchQueryCollection;
  late List<SearchQueryPhoto> searchQueryPhoto = [];
  int times = 0;

  List<Topic> topics = [];

  void _getData() async {
    // perPage = 8;
    final data;
    if (photos == null || (photos.length == 0)) {
      data = await fetchPhotosRandom(http.Client(), pageNumber);
      //photos = data.map((e) => e).toList();
      setState(() {
        photos = data;
        times += 1;
        ++pageNumber;
        print(times);
      });
      //print(data);
      //print(photos.first.id);
    } else {
      data = await fetchPhotosRandom(http.Client(), pageNumber);
      setState(() {
        ++pageNumber;
        times += 1;
        /* Timer(Duration(milliseconds: 500), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        }); */
        print(times);
        if (times > 20) {
          _isFinnished = true;
        }
        photos.addAll(data);
      });
      //print(photos.first.id);
      //photos.addAll(data.map((e) => e).toList());
    }
  }

  Future<List<Topic>> _getDataTopic() async {
    final data1;
    var rand = Random();
    if (topics == null || (topics.length == 0)) {
      data1 = await fetchTopics(http.Client(), 9, (rand.nextInt(5) + 1));
      setState(() {
        topics = data1;
      });
    }
    return topics;
  }

  Future<List<Collection>> _getDataCollection() async {
    final data2;
    var rand = Random();
    if (collections == null || (collections.length == 0)) {
      data2 = await fetchCollections(http.Client(), 8, (rand.nextInt(5) + 1));
      setState(() {
        collections = data2;
      });
    }
    return collections;
  }

  @override
  void initState() {
    super.initState();
    controllerTwo = new ScrollController();
    controller = new ScrollController()..addListener(_scrollListener);
    _isLoading = true;
    _isFinnished = false;
    /* Future.delayed(Duration.zero, () async {
    }); */
    if (mounted) {
      setState(() {});
    }
    _getData();
    _getDataTopic();
    _getDataCollection();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    controllerTwo.dispose();
    super.dispose();
  }

  void _scrollListener() {
    /* print('${controller.position.pixels} ' +
        ' ${controller.position.maxScrollExtent}');
    print(_isLoading && _isFinnished == false); */
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
        _isLoading = false;
        _isFinnished = true;
      });
    }

    /* if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        _isLoading = true;
        ++pageNumber;
        _getData();
      });
    }else if(_isFinnished){
      setState(() {
        times = 0;
        _isLoading = false;
        _isFinnished = true;
      });
    } */
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  //alignment: AlignmentDirectional.center,
                  children: [
                    const SizedBox(height: 3.0),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(12.0),
                              padding: EdgeInsets.only(left: 15.0, top: 20.0),
                              child: Text(
                                'Explore\nThe World',
                                style: const TextStyle(
                                  fontSize: 33.0,
                                  fontFamily: 'RalewayExtra',
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                              child: AnimSearchBar(
                                autoFocus: true,
                                color: DynamicTheme.of(context)!.themeId == 2
                                    ? Colors.grey[700]
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width) - 45,
                                helpText: 'Search..',

                                style: TextStyle(
                                  color: DynamicTheme.of(context)!.themeId == 2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                rtl: false,
                                textController: textController,
                                suffixIcon: Icon(Icons.filter_list_outlined),
                                //closeSearchOnSuffixTap: true,
                                onSuffixTap: () {
                                  setState(() {
                                    //print();
                                    // FocusScopeNode currentFocus =
                                    //     FocusScope.of(context);
                                    _openFilterDialog();
                                    //textController.clear();
                                    //AnimSearchBar().unfocusKeyboard();
                                  });
                                },
                                onPressed: () {
                                  setState(() {
                                    print(textController.text);
                                    query = textController.text;
                                  });

                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (query != '' && query != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SearchScreen(
                                                query: query,
                                                isPhoto: _isPhoto,
                                              )),
                                    );
                                  }
                                },
                              ),
                            ),

                            /*  Padding(
                        padding: EdgeInsets.only(right: 20.0, top: 40.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            color: Colors.grey[100],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.gpp_maybe_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ), */
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: FutureBuilder<List<Topic>>(
                        future: _getDataTopic(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return snapshot.hasData
                              ? BuildTopics(
                                  topics: snapshot.data!,
                                )
                              : Center(
                                  child: LoadingWidget6(),
                                );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 12.0, top: 15.0, bottom: 1.0),
                          child: Text(
                            'Trending Collections',
                            style: const TextStyle(
                              fontSize: 26.0,
                              letterSpacing: 1.1,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    buildTrendingCollections(),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0, top: 15.0, bottom: 1.0),
                          child: Text(
                            'Browse Photos',
                            style: const TextStyle(
                              fontSize: 26.0,
                              letterSpacing: 1.1,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0),
                    buildRandomPhotos(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRandomPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
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
                      tag: '${photos.elementAt(index).id}$index',
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
                        tag: '${photos.elementAt(index).id}$index',
                        photo: photos.elementAt(index),
                        imageUrl: photos.elementAt(index).urls.full,
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

  Widget buildTrendingCollections() {
    return Row(
      children: <Widget>[
        FutureBuilder<List<Collection>>(
          future: _getDataCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? Flexible(
                    child: Column(
                      children: [
                        Container(
                          height: 218.4,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 16.0, left: 10.0),
                          child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: collections.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CollectionScreen(
                                                collection: collections
                                                    .elementAt(index)))),
                                    child: Container(
                                      margin: EdgeInsets.only(right: 28.8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Hero(
                                          tag: collections.elementAt(index).id,
                                          child: CachedNetworkImage(
                                            height: 218.6,
                                            width: 333.6,
                                            fit: BoxFit.cover,
                                            imageUrl: collections
                                                .elementAt(index)
                                                .coverPhoto
                                                .urls
                                                .regular,
                                            fadeInCurve: Curves.easeOutCirc,
                                            fadeInDuration: const Duration(
                                                milliseconds: 1800),
                                            placeholder: (context, url) =>
                                                LoadingWidget7(),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Icon(Icons.error)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.0,
                                    left: 20.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 30.2, sigmaY: 55.2),
                                        child: Container(
                                          height: 42.0,
                                          padding: EdgeInsets.only(
                                            left: 16.8,
                                            right: 14.5,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                collections
                                                    .elementAt(index)
                                                    .title,
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontFamily: 'Raleway',
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    ),
                                  ),
                                  collections.elementAt(index).featured
                                      ? Positioned(
                                          top: 15.0,
                                          right: 40.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 55.2, sigmaY: 55.2),
                                              child: Container(
                                                height: 42.0,
                                                padding: EdgeInsets.only(
                                                  left: 16.8,
                                                  right: 14.5,
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Featured',
                                                      style: TextStyle(
                                                        fontSize: 16.5,
                                                        fontFamily: 'Raleway',
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 28.8, top: 28.8),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: collections.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Color(0xFF8a8a8a),
                              dotColor: Color(0xFFababa),
                              dotHeight: 4.8,
                              dotWidth: 6.0,
                              spacing: 4.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: LoadingWidget7());
          },
        ),
      ],
    );
  }

  void _openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: listOfFilterChoice,
      selectedListData: selectedListData,
      height: 175,
      closeIconColor:
          DynamicTheme.of(context)!.themeId == 2 ? Colors.white : Colors.black,
      backgroundColor: DynamicTheme.of(context)!.themeId == 2
          ? Colors.grey.shade800
          : Colors.white,
      hideheader: false,
      applyButtonTextStyle: TextStyle(
          color: DynamicTheme.of(context)!.themeId == 2
              ? Colors.white
              : Colors.black),
      //useRootNavigator: true,
      enableOnlySingleSelection: true,
      hideSearchField: true,
      hideCloseIcon: false,
      wrapAlignment: WrapAlignment.center,
      headlineText: "Select Type of Search",
      headerTextStyle: TextStyle(
        color: DynamicTheme.of(context)!.themeId == 2
            ? Colors.white
            : Colors.black,
      ),
      choiceChipLabel: (item) {
        return item;
      },
      validateSelectedItem: (list, val) {
        return list!.contains(val);
      },
      onItemSearch: (list, text) {
        if (list!.any(
            (element) => element.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((element) =>
                  element.toLowerCase().contains(text.toLowerCase()))
              .toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            list.length == 0
                ? selectedCountList = 'Photos'.toLowerCase()
                : selectedCountList =
                    List.from(list).first.toString().toLowerCase();
            list.length == 0
                ? selectedListData.first = 'Photos'
                : selectedListData = List.from(list);

            //selectedListData[0] = selectedCountList;
            print(selectedCountList);
            print('Collection $_isCollection');
            print('Photo $_isPhoto');

            /*  inputController.text != null && inputController.text.length != 0
                ? query = inputController.text
                : query = '';
               */
            //List.from(list).first;
            //selectedCountList = List.from(list).first.toString();
            //inputController.clearComposing();
            if (selectedCountList == 'photos') {
              _isPhoto = true;
              _isCollection = false;
            } else {
              _isPhoto = false;
              _isCollection = true;
            }
          });

/* 
          if (query == inputController.text) {
            _isLoading = true;
          } else {
            _isLoading = false;
          } */
          print(query);
        }
        Navigator.pop(context);
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/* 
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search Photos and Collections...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        if (data.contains(query)) {
          
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: const Icon(Icons.collections_outlined),
            onPressed: () => print('Collection button Clicked..'),
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: data.map((txt) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => print('$txt Clicked..'),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.only(left: 15.0),
                        height: 20,
                        width: double.infinity,
                        child: Text(
                          '$txt',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
 */

/*
AnimSearchBar(
                        width: (MediaQuery.of(context).size.width) - 20 * 1.5,
                        helpText: 'Search..',
                        rtl: true,
                        textController: textController,
                        closeSearchOnSuffixTap: true,
                        onSuffixTap: () {
                          setState(() {
                            //print();
                            textController.clear();
                            //AnimSearchBar().unfocusKeyboard();
                          });
                        },
                        onPressed: () {
                          setState(() {
                            print(textController.text);
                            query = textController.text;
                          });
                        },
                      ),

*/
