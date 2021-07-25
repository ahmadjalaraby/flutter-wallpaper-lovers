import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/widgets/widgets.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class PhotoScreen extends StatefulWidget {
  Photo? photo;
  final String imageUrl;
  final String tag;
  List<Photo>? photos = [];

  PhotoScreen({
    Key? key,
    this.photo,
    required this.imageUrl,
    required this.tag,
  }) : super(key: key);
  @override
  _PhotoScreenState createState() =>
      _PhotoScreenState(this.photo, this.imageUrl, this.tag);
}

class _PhotoScreenState extends State<PhotoScreen> {
  Photo? photo;
  final String imageUrl;
  final String tag;
  List<Photo>? photos;

  _PhotoScreenState(this.photo, this.imageUrl, this.tag);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Icon dropIcon = Icon(Icons.arrow_upward_outlined);
  Icon upIcon = Icon(Icons.arrow_upward_outlined);
  Icon downIcon = Icon(Icons.arrow_downward_outlined);
  PanelController pc = PanelController();
  bool _isVisible = true;
  bool _isDownloading = false;
  int progressTwo = 0;
  var totalTwo = 0;
  //GlobalKey<ScaffoldMessenger> scaffoldKey = GlobalKey();

  Future<void> setWallpaperLockScreen() async {
    String url;
    if (photo!.urls.full != null) {
      url = photo!.urls.full;
    } else {
      url = photo!.urls.regular;
    }
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
    Navigator.of(context).pop();
    _showSnackBar('Wallpaper set Successfully');
  }

  Future<void> setWallpaperHomeScreen() async {
    String url = photo!.urls.regular;
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
    Navigator.of(context).pop();
    _showSnackBar('Wallpaper set Successfully');
  }

  Future<void> setWallpaperBothScreen() async {
    String url = photo!.urls.regular;
    int location = WallpaperManager.BOTH_SCREENS;
    var file = await DefaultCacheManager().getSingleFile(url);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
    Navigator.of(context).pop();
    _showSnackBar('Wallpaper set Successfully');
  }

  getBottomSheetBarWidget(String text, function()) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).brightness != Brightness.dark
                ? Colors.black.withOpacity(0.90)
                : Colors.white.withOpacity(0.90),
          ),
        ),
      ),
    );
  }

  void showApplyWallpaperBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]!.withOpacity(0.80)
                        : Colors.white.withOpacity(0.80),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getBottomSheetBarWidget(
                          'Apply for Lockscreen', setWallpaperLockScreen),
                      Divider(),
                      getBottomSheetBarWidget(
                          'Apply for Homescreen', setWallpaperHomeScreen),
                      Divider(),
                      getBottomSheetBarWidget(
                          'Apply for Both', setWallpaperBothScreen),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: new BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]!.withOpacity(0.99)
                          : Colors.white.withOpacity(0.90),
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getBottomSheetBarWidget('Cancel', () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  downloadImage() async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(photo!.urls.regular);

      var size = await ImageDownloader.findByteSize(imageId!);
      _isDownloading = true;

      ImageDownloader.callback(
          onProgressUpdate: (String? imageId, int progress) {
        setState(() {
          progressTwo = progress;
          totalTwo = size!;
          if (progress == 100) {
            _isDownloading = false;
          }
          //print('From Print => $progress');
        });
        //downloadPage(progress, size);
      });
      //print(imageId);
      //print(photo.links.download);
      if (imageId == null) {
        _showSnackBar("Error");
        return;
      }
      _showSnackBar("Image Successfully Saved");
    } on PlatformException catch (error) {}
  }

  /*  downloadPage(progress, total) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Downloading...',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.0),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: double.parse(progress) / 100.0,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$progress %',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    //'${formatBytes(received, 1)} '
                    'of ${formatBytes(total, 1)}',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 */

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pc.isPanelOpen)
          pc.close();
        else
          Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          body: SlidingUpPanel(
            controller: pc,
            color: Colors.white.withOpacity(0.9),
            minHeight: 0.0,
            maxHeight: MediaQuery.of(context).size.height - 132.0,
            backdropEnabled: true,
            backdropTapClosesPanel: true,
            isDraggable: true,
            parallaxEnabled: true,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            body: panelBodyUI(photo!, imageUrl, context),
            panel: panelUI(),
            onPanelClosed: () {
              setState(() {
                dropIcon = upIcon;
              });
            },
            onPanelOpened: () {
              setState(() {
                dropIcon = downIcon;
              });
            },
          )),
    );
    //body: PanelBodyUi(photo: photo, imageUrl: imageUrl),
  }

  Widget panelUI() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70.withOpacity(0.93),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FutureBuilder<Photo>(
          future: fetchPhoto(http.Client(), photo!.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            return snapshot.hasData
                ? DetailPhoto(photo: snapshot.data!)
                : LoadingWidget5();
          },
        ),
      ),
    );
  }

  Widget panelBodyUI(Photo photo, String imageUrl, context) {
    return Stack(
      children: <Widget>[
        _isDownloading ?  CircularProgressIndicator() : SizedBox.shrink(),
        GestureDetector(
          /* onHorizontalDragStart: (drag) => print('on h'),
          onHorizontalDragEnd: (drag) {
            print('oh noooo');
            print(drag.primaryVelocity);
          },*/
          onTap: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: InteractiveViewer(
            constrained: true,
            boundaryMargin: EdgeInsets.all(0.0),
            minScale: 0.3,
            maxScale: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  //fadeInCurve: Curves.easeOutCirc,
                  //fadeInDuration: const Duration(milliseconds: 1800),
                  placeholder: (context, url) => LoadingWidget4(),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 80.0, horizontal: 25.0),
                decoration: BoxDecoration(
                  color: DynamicTheme.of(context)!.themeId == 2
                      ? Colors.grey[700]
                      : Colors.white60.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_outlined,
                    size: 26.0,
                    color: DynamicTheme.of(context)!.themeId == 2
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              FutureBuilder(
                  future: _isPhotoFavorite(photo.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[700]
                                : Colors.white60.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              print('Favorite Button Clicked..');
                              await kDatabase!.insert(kTable, {
                                'pid': photo.id,
                                'title': photo.altDescription != null
                                    ? photo.altDescription
                                    : 'Photo',
                                'urls_regural': photo.urls.regular,
                                'isphoto': 1
                              }).then((value) {
                                setState(() {});
                                _showSnackBar('Added to favorites');
                              });
                            },
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              size: 26.0,
                              color: DynamicTheme.of(context)!.themeId == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[700]
                                : Colors.white60.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              print('Favorite Button Clicked..');
                              await kDatabase!.delete(
                                kTable,
                                where: 'pid = ?',
                                whereArgs: [photo.id],
                              ).then((value) {
                                setState(() {});
                                _showSnackBar('Removed from favorites');
                              });
                            },
                            icon: Icon(
                              Icons.favorite_outline,
                              size: 26.0,
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
        Visibility(
          visible: _isVisible,
          child: Positioned(
            bottom: 24.0,
            left: MediaQuery.of(context).size.width / 3.99,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DetailButton(
                  icon: Icons.info_outline_rounded,
                  name: 'Info',
                  isApply: false,
                  onTap: () {
                    pc.isPanelClosed ? pc.open() : pc.close();
                  },
                ),
                const SizedBox(width: 15.0),
                DetailButton(
                  icon: Icons.file_download_outlined,
                  name: 'Save',
                  isApply: false,
                  onTap: () {
                    setState(() {
                      _isDownloading = true;
                    });
                    downloadImage();
                  },
                ),
                const SizedBox(width: 15.0),
                DetailButton(
                  icon: Icons.brush_outlined,
                  name: 'Apply',
                  onTap: () {
                    showApplyWallpaperBottomSheet(context);
                  },
                ),
              ],
            ),
          ),
        ),
        //_isDownloading ? downloadPage(progressTwo, totalTwo) : SizedBox.shrink(),
      ],
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
}
