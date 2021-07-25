import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class UserDetailPhoto extends StatelessWidget {
  final Photo photo;
  const UserDetailPhoto({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('User Clicked..'),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            decoration: BoxDecoration(
              color: DynamicTheme.of(context)!.themeId == 2
                  ? Colors.grey[700]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.all(10.0),
                      //padding: EdgeInsets.symmetric(vertical: 3.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45.0),
                        child: CachedNetworkImage(
                          imageUrl: photo.user.profileImage.large,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => LoadingWidget2(),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 28.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          photo.user.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          photo.user.username,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0, width: 4.0),
                photo.user.bio != null
                    ? Text(
                        photo.user.bio,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : SizedBox.shrink(),
                //SizedBox(width: 5.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
