import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class PhotoCarousel extends StatelessWidget {
  final List<Photo> photos;
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
    keepPage: true,
  );
  //dynamic photos = Config().bestOfWeek;

  PhotoCarousel({
    required this.pageController,
    required this.photos,
  });
  @override
  _buildPhoto(BuildContext context, int index) {
    Photo photo = photos[index];
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoScreen(
            imageUrl: photo.urls.regular,
            photo: photo,
            tag: photo.id,
          ),
        ),
      ),
      //print('$index in photos clicked..'),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (BuildContext context, Widget? widget) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page! - index;
            value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              child: widget,
              height: Curves.easeIn.transform(value) *
                  MediaQuery.of(context).size.height /
                  1.5,
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.0),
              width: double.infinity,
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: photo.id,
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width / 1.2,
                    fit: BoxFit.cover,
                    // TODO: image here
                    imageUrl: photo.urls.regular,
                    fadeInCurve: Curves.easeOutCirc,
                    fadeInDuration: const Duration(milliseconds: 1800),
                    placeholder: (context, url) => LoadingWidget3(),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width / 1.15,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildPhoto(context, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
