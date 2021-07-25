import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class BestOfWidget extends StatelessWidget {
  final String txt;
  final String photo;

  const BestOfWidget({
    Key? key,
    required this.txt,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>  BestOfScreen(title: txt),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: photo,
                fadeInCurve: Curves.easeInQuad,
                fadeInDuration: const Duration(milliseconds: 1800),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                placeholder: (context, url) => LoadingWidget3(),
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
                txt,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
